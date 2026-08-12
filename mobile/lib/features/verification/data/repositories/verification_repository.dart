import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/local_database.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../sync/data/sync_queue_repository.dart';
import '../models/document_model.dart';
import '../models/vehicle_model.dart';

class VerificationRepository {
  final ApiClient _apiClient;
  final LocalDatabase _database;
  final ConnectivityService _connectivityService;
  final SyncQueueRepository _syncQueueRepository;

  VerificationRepository({
    required this._apiClient,
    required this._database,
    required this._connectivityService,
    required this._syncQueueRepository,
  });

  /// Obtiene la documentación del trabajador actual (online u offline)
  Future<List<DocumentModel>> getWorkerDocuments(String workerId) async {
    final isOnline = await _connectivityService.isConnected;

    if (isOnline) {
      try {
        final response = await _apiClient.get(
          '/api/v1/workers/profile/documents',
        );
        final List<dynamic> data = response.data;
        final docs = data.map((json) => DocumentModel.fromJson(json)).toList();

        // Limpiar caché local y guardar nuevos registros en SQLite
        await (_database.delete(_database.workerDocumentsLocal)).go();

        for (final doc in docs) {
          await _database
              .into(_database.workerDocumentsLocal)
              .insert(
                WorkerDocumentsLocalCompanion(
                  id: Value(doc.id),
                  documentType: Value(doc.documentType),
                  emissionDate: Value(doc.emissionDate),
                  expiryDate: Value(doc.expiryDate),
                  fileUrl: Value(doc.fileUrl),
                ),
              );
        }

        return docs;
      } catch (e) {
        // Fallback a offline en caso de error del API
        return _getWorkerDocumentsOffline();
      }
    } else {
      return _getWorkerDocumentsOffline();
    }
  }

  Future<List<DocumentModel>> _getWorkerDocumentsOffline() async {
    final rows = await _database.select(_database.workerDocumentsLocal).get();
    return rows.map((row) {
      return DocumentModel(
        id: row.id,
        documentType: row.documentType,
        emissionDate: row.emissionDate,
        expiryDate: row.expiryDate,
        fileUrl: row.fileUrl,
      );
    }).toList();
  }

  /// Registra un evento de bloqueo operacional en el log local y cola de sincronización FIFO
  Future<void> logVerificationBlock({
    required String action, // WORKER_BLOCK, VEHICLE_BLOCK, CHECKLIST_BLOCK
    required String reason,
    required double gpsLat,
    required double gpsLon,
    required double gpsAccuracy,
  }) async {
    final blockId = DateTime.now().toIso8601String();
    final payload = {
      'block_id': blockId,
      'action': action,
      'reason': reason,
      'gps_lat': gpsLat,
      'gps_lon': gpsLon,
      'gps_accuracy': gpsAccuracy,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // 1. Guardar localmente en el log de auditorías
    await _database
        .into(_database.auditLogsLocal)
        .insert(
          AuditLogsLocalCompanion(
            id: Value(blockId),
            action: Value(action),
            timestamp: Value(DateTime.now()),
            gpsLat: Value(gpsLat),
            gpsLon: Value(gpsLon),
            payload: Value(jsonEncode(payload)),
          ),
        );

    // 2. Encolar en la cola de sincronización para alertar de inmediato al servidor (trigger de email)
    await _syncQueueRepository.addToQueue(
      endpoint: '/api/v1/audit/block-alert',
      method: 'POST',
      payload: payload,
    );
  }

  /// Obtiene la información de un vehículo y sus documentos asociados mediante escaneo QR
  Future<Map<String, dynamic>> getVehicleByQR(String qrToken) async {
    final isOnline = await _connectivityService.isConnected;

    if (isOnline) {
      try {
        final response = await _apiClient.get('/api/v1/vehicles/scan/$qrToken');
        final vehicleMap = response.data['vehicle'] as Map<String, dynamic>;
        final List<dynamic> docsList = response.data['documents'] ?? [];

        final vehicle = VehicleModel.fromJson(vehicleMap);
        final docs = docsList.map((j) => DocumentModel.fromJson(j)).toList();

        // Guardar caché local
        await (_database.delete(
          _database.vehiclesLocal,
        )..where((t) => t.qrCodeToken.equals(qrToken))).go();
        await _database
            .into(_database.vehiclesLocal)
            .insert(
              VehiclesLocalCompanion(
                id: Value(vehicle.id),
                plateNumber: Value(vehicle.plateNumber),
                brand: Value(vehicle.brand),
                model: Value(vehicle.model),
                year: Value(vehicle.year),
                lastOdometer: Value(vehicle.lastOdometer),
                qrCodeToken: Value(vehicle.qrCodeToken),
                isActive: Value(vehicle.isActive),
              ),
            );

        await (_database.delete(
          _database.vehicleDocumentsLocal,
        )..where((t) => t.vehicleId.equals(vehicle.id))).go();
        for (final doc in docs) {
          await _database
              .into(_database.vehicleDocumentsLocal)
              .insert(
                VehicleDocumentsLocalCompanion(
                  id: Value(doc.id),
                  vehicleId: Value(vehicle.id),
                  documentType: Value(doc.documentType),
                  emissionDate: Value(doc.emissionDate),
                  expiryDate: Value(doc.expiryDate),
                  fileUrl: Value(doc.fileUrl),
                ),
              );
        }

        return {'vehicle': vehicle, 'documents': docs};
      } catch (e) {
        return _getVehicleOffline(qrToken);
      }
    } else {
      return _getVehicleOffline(qrToken);
    }
  }

  Future<Map<String, dynamic>> _getVehicleOffline(String qrToken) async {
    final vehicleRow = await (_database.select(
      _database.vehiclesLocal,
    )..where((t) => t.qrCodeToken.equals(qrToken))).getSingleOrNull();

    if (vehicleRow == null) {
      throw Exception(
        'Vehículo no encontrado en el almacenamiento local. Debes escanearlo online al menos una vez.',
      );
    }

    final vehicle = VehicleModel(
      id: vehicleRow.id,
      plateNumber: vehicleRow.plateNumber,
      brand: vehicleRow.brand,
      model: vehicleRow.model,
      year: vehicleRow.year,
      lastOdometer: vehicleRow.lastOdometer,
      qrCodeToken: vehicleRow.qrCodeToken,
      isActive: vehicleRow.isActive,
    );

    final docRows = await (_database.select(
      _database.vehicleDocumentsLocal,
    )..where((t) => t.vehicleId.equals(vehicle.id))).get();

    final docs = docRows.map((row) {
      return DocumentModel(
        id: row.id,
        documentType: row.documentType,
        emissionDate: row.emissionDate,
        expiryDate: row.expiryDate,
        fileUrl: row.fileUrl,
      );
    }).toList();

    return {'vehicle': vehicle, 'documents': docs};
  }
}
