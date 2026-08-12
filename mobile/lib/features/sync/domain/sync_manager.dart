import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import '../../../../core/network/api_client.dart';
import '../../../../core/network/connectivity_service.dart';
import '../data/sync_queue_repository.dart';
import '../../../../core/database/local_database.dart';

enum SyncStatus { idle, syncing, error }

class SyncManager {
  final SyncQueueRepository _queueRepository;
  final ApiClient _apiClient;
  final ConnectivityService _connectivityService;
  final LocalDatabase _database;

  final _statusController = StreamController<SyncStatus>.broadcast();
  final _pendingCountController = StreamController<int>.broadcast();

  bool _isSyncing = false;
  SyncStatus _currentStatus = SyncStatus.idle;
  StreamSubscription<bool>? _connectivitySubscription;
  Timer? _retryTimer;
  int _retryCount = 0;

  SyncManager({
    required this._queueRepository,
    required this._apiClient,
    required this._connectivityService,
    required this._database,
  }) {
    // Escuchar cambios de conectividad para disparar la sincronización de forma automática
    _connectivitySubscription = _connectivityService.onConnectivityChanged
        .listen((isConnected) {
          if (isConnected) {
            triggerSync();
          }
        });
    // Emitir conteo inicial
    updatePendingCount();
  }

  Stream<SyncStatus> get statusStream => _statusController.stream;
  Stream<int> get pendingCountStream => _pendingCountController.stream;
  SyncStatus get currentStatus => _currentStatus;

  void _updateStatus(SyncStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  Future<void> updatePendingCount() async {
    final count = await _queueRepository.getQueueCount();
    _pendingCountController.add(count);
  }

  /// Dispara el proceso de sincronización
  Future<void> triggerSync() async {
    if (_isSyncing) return;

    final hasNet = await _connectivityService.isConnected;
    if (!hasNet) {
      _updateStatus(SyncStatus.idle);
      return;
    }

    _isSyncing = true;
    _updateStatus(SyncStatus.syncing);
    _retryTimer?.cancel();

    try {
      await _processQueue();
      _retryCount = 0;
      _updateStatus(SyncStatus.idle);
    } catch (e) {
      _updateStatus(SyncStatus.error);
      _scheduleRetry();
    } finally {
      _isSyncing = false;
      await updatePendingCount();
    }
  }

  /// Procesa los elementos de la cola FIFO uno por uno
  Future<void> _processQueue() async {
    while (true) {
      final item = await _queueRepository.getNextItem();
      if (item == null) {
        break; // Cola vacía, terminar
      }

      final success = await _syncItem(item);
      if (success) {
        await _queueRepository.deleteFromQueue(item.id);
        await updatePendingCount();
      } else {
        // Si no se pudo sincronizar debido a un error de red/servidor (5xx),
        // lanzamos excepción para abortar y reintentar toda la cola después.
        throw Exception('Fallo de red al procesar item de cola.');
      }
    }
  }

  /// Sincroniza un item específico con el API
  Future<bool> _syncItem(SyncQueueData item) async {
    try {
      var payload = jsonDecode(item.payload) as Map<String, dynamic>;

      // 1. Fase de Carga de Fotografías locales (si existen en el payload)
      // Buscamos si hay rutas de archivos locales (que comiencen con '/' o contengan la ruta de archivos de app)
      payload = await _uploadLocalPhotosIfPresent(payload);

      // 2. Fase de Envío de Datos JSON al Backend
      Response response;
      if (item.method == 'POST') {
        response = await _apiClient.post(item.endpoint, data: payload);
      } else if (item.method == 'PUT') {
        response = await _apiClient.put(item.endpoint, data: payload);
      } else {
        // Por defecto fallback a POST
        response = await _apiClient.post(item.endpoint, data: payload);
      }

      // Si retorna 2xx, fue exitoso
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return true;
      }

      // Manejar otros códigos de respuesta del servidor
      if (response.statusCode != null &&
          response.statusCode! >= 400 &&
          response.statusCode! < 500) {
        // Error de cliente (4xx): Validación fallida.
        // No bloqueamos la cola FIFO; registramos el error en la auditoría y saltamos el item.
        await _logSyncError(
          action: 'SYNC_CLIENT_ERROR',
          message:
              'Error 4xx al sincronizar endpoint ${item.endpoint}: ${response.data}',
        );
        return true; // Se considera "procesado" para descartar de la cola
      }

      return false; // Error de red o servidor (5xx)
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        final status = dioError.response!.statusCode;
        if (status != null && status >= 400 && status < 500) {
          // Error del cliente (4xx)
          await _logSyncError(
            action: 'SYNC_CLIENT_ERROR',
            message:
                'DioError 4xx en ${item.endpoint}: ${dioError.response?.data}',
          );
          return true;
        }
      }
      return false; // Error de red sin respuesta del servidor
    } catch (e) {
      // Error inesperado en formateo de datos
      await _logSyncError(
        action: 'SYNC_FORMAT_ERROR',
        message: 'Error inesperado al procesar item de sincronización: $e',
      );
      return true; // Saltamos el item de la cola para no bloquear
    }
  }

  /// Escanea el payload buscando llaves que puedan contener fotos locales para subirlas antes del JSON
  Future<Map<String, dynamic>> _uploadLocalPhotosIfPresent(
    Map<String, dynamic> payload,
  ) async {
    final updatedPayload = Map<String, dynamic>.from(payload);

    for (final entry in updatedPayload.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is String && _isLocalFilePath(value)) {
        // Es un archivo único
        final remoteUrl = await _uploadSingleFile(value);
        if (remoteUrl != null) {
          updatedPayload[key] = remoteUrl;
        }
      } else if (value is List) {
        // Puede ser un arreglo de fotos (ej. photos_before, photos_after)
        final List<String> updatedUrls = [];
        for (final item in value) {
          if (item is String && _isLocalFilePath(item)) {
            final remoteUrl = await _uploadSingleFile(item);
            if (remoteUrl != null) {
              updatedUrls.add(remoteUrl);
            }
          } else if (item is String) {
            updatedUrls.add(item); // Ya es URL remota
          }
        }
        if (updatedUrls.isNotEmpty) {
          updatedPayload[key] = updatedUrls;
        }
      }
    }

    return updatedPayload;
  }

  bool _isLocalFilePath(String path) {
    return path.startsWith('/') &&
        (path.endsWith('.jpg') ||
            path.endsWith('.jpeg') ||
            path.endsWith('.png'));
  }

  /// Sube un único archivo binario al endpoint del backend
  Future<String?> _uploadSingleFile(String localPath) async {
    final file = File(localPath);
    if (!await file.exists()) {
      return null; // Archivo no existe físicamente
    }

    try {
      final fileName = p.context.basename(localPath);
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(localPath, filename: fileName),
      });

      final response = await _apiClient.post(
        '/api/v1/sync/media/upload',
        data: formData,
      );
      if (response.statusCode == 200 || response.statusCode == 210) {
        return response.data['url'] as String;
      }
    } catch (e) {
      // Re-lanzar error para abortar la transacción de sincronización de este item
      throw Exception('Fallo al subir archivo binario de foto: $e');
    }
    return null;
  }

  /// Registra los fallos de cliente o formato locales
  Future<void> _logSyncError({
    required String action,
    required String message,
  }) async {
    try {
      final companion = AuditLogsLocalCompanion(
        id: Value(DateTime.now().toIso8601String()),
        action: Value(action),
        timestamp: Value(DateTime.now()),
        payload: Value(jsonEncode({'error': message})),
      );
      await _database.into(_database.auditLogsLocal).insert(companion);
    } catch (_) {}
  }

  /// Programa un reintento exponencial en caso de fallo de red
  void _scheduleRetry() {
    _retryCount++;
    // Reintento exponencial limitado a máximo 5 minutos (300 segundos)
    final seconds = (_retryCount * _retryCount * 2).clamp(5, 300);
    _retryTimer?.cancel();
    _retryTimer = Timer(Duration(seconds: seconds), () {
      triggerSync();
    });
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _retryTimer?.cancel();
    _statusController.close();
    _pendingCountController.close();
  }
}
