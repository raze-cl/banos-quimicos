import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/local_database.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../sync/data/sync_queue_repository.dart';
import '../models/route_model.dart';

class RoutesRepository {
  final ApiClient _apiClient;
  final LocalDatabase _database;
  final ConnectivityService _connectivityService;
  final SyncQueueRepository _syncQueueRepository;

  RoutesRepository({
    required this._apiClient,
    required this._database,
    required this._connectivityService,
    required this._syncQueueRepository,
  });

  /// Obtiene las rutas asignadas al trabajador (híbrido online/offline con seed fallback)
  Future<List<RouteModel>> getAssignedRoutes(String workerId) async {
    final isOnline = await _connectivityService.isConnected;

    if (isOnline) {
      try {
        final response = await _apiClient.get('/api/v1/routes/assigned');
        final List<dynamic> data = response.data;
        final routes = data.map((json) => RouteModel.fromJson(json)).toList();

        // 1. Limpiar caché local
        await _database.delete(_database.routesLocal).go();
        await _database.delete(_database.routePointsLocal).go();

        // 2. Guardar en SQLite
        for (final rt in routes) {
          await _database
              .into(_database.routesLocal)
              .insert(
                RoutesLocalCompanion(
                  id: Value(rt.id),
                  name: Value(rt.name),
                  clientName: Value(rt.clientName),
                  faenaName: Value(rt.faenaName),
                  status: Value(rt.status),
                  scheduledDate: Value(rt.scheduledDate),
                ),
              );

          for (final pt in rt.points) {
            await _database
                .into(_database.routePointsLocal)
                .insert(
                  RoutePointsLocalCompanion(
                    id: Value(pt.id),
                    routeId: Value(pt.routeId),
                    name: Value(pt.name),
                    qrCodeToken: Value(pt.qrCodeToken),
                    sequenceOrder: Value(pt.sequenceOrder),
                    status: Value(pt.status),
                  ),
                );
          }
        }

        return routes;
      } catch (e) {
        return _getAssignedRoutesOffline();
      }
    } else {
      return _getAssignedRoutesOffline();
    }
  }

  Future<List<RouteModel>> _getAssignedRoutesOffline() async {
    var rows = await _database.select(_database.routesLocal).get();

    // Fallback: si no hay nada en caché local, auto-sembramos 2 rutas de prueba
    if (rows.isEmpty) {
      await _seedDefaultRoutesLocal();
      rows = await _database.select(_database.routesLocal).get();
    }

    final List<RouteModel> routes = [];

    for (final row in rows) {
      final ptRows =
          await (_database.select(_database.routePointsLocal)
                ..where((t) => t.routeId.equals(row.id))
                ..orderBy([
                  (t) => OrderingTerm(
                    expression: t.sequenceOrder,
                    mode: OrderingMode.asc,
                  ),
                ]))
              .get();

      final points = ptRows.map((ptRow) {
        return RoutePointModel(
          id: ptRow.id,
          routeId: ptRow.routeId,
          name: ptRow.name,
          qrCodeToken: ptRow.qrCodeToken,
          sequenceOrder: ptRow.sequenceOrder,
          status: ptRow.status,
        );
      }).toList();

      routes.add(
        RouteModel(
          id: row.id,
          name: row.name,
          clientName: row.clientName,
          faenaName: row.faenaName,
          status: row.status,
          scheduledDate: row.scheduledDate,
          points: points,
        ),
      );
    }

    return routes;
  }

  /// Registra el inicio de una ruta (GPS + hora) y lo encola para la sincronización FIFO
  Future<void> startRoute({
    required String routeId,
    required double gpsLat,
    required double gpsLon,
    required double gpsAccuracy,
  }) async {
    // 1. Actualizar estado local
    await (_database.update(_database.routesLocal)
          ..where((t) => t.id.equals(routeId)))
        .write(const RoutesLocalCompanion(status: Value('IN_PROGRESS')));

    // 2. Encolar evento de inicio en la cola FIFO
    final payload = {
      'routeId': routeId,
      'gpsLat': gpsLat,
      'gpsLon': gpsLon,
      'gpsAccuracy': gpsAccuracy,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await _syncQueueRepository.addToQueue(
      endpoint: '/api/v1/routes/$routeId/start',
      method: 'POST',
      payload: payload,
    );
  }

  /// Registra la visita realizada offline a un punto de control (QR + GPS + Fotos) y encola el evento FIFO
  Future<void> visitPoint({
    required String pointId,
    required String routeId,
    required double gpsLat,
    required double gpsLon,
    required double gpsAccuracy,
    required List<String> photosBefore, // Arreglo de rutas locales de archivos
    required List<String> photosAfter, // Arreglo de rutas locales de archivos
    required Map<String, dynamic> formData,
  }) async {
    final visitId = DateTime.now().millisecondsSinceEpoch.toString() + pointId;

    // 1. Guardar localmente el registro detallado de la visita en SQLite
    await _database
        .into(_database.routePointVisitsLocal)
        .insert(
          RoutePointVisitsLocalCompanion(
            id: Value(visitId),
            pointId: Value(pointId),
            visitedAt: Value(DateTime.now()),
            gpsLat: Value(gpsLat),
            gpsLon: Value(gpsLon),
            gpsAccuracy: Value(gpsAccuracy),
            photosBefore: Value(photosBefore.join(',')),
            photosAfter: Value(photosAfter.join(',')),
            formData: Value(formData.isEmpty ? '{}' : jsonEncode(formData)),
          ),
        );

    // 2. Actualizar estado local del punto a COMPLETED
    await (_database.update(_database.routePointsLocal)
          ..where((t) => t.id.equals(pointId)))
        .write(const RoutePointsLocalCompanion(status: Value('COMPLETED')));

    // 3. Encolar evento en la cola FIFO (el SyncManager subirá las imágenes primero y reemplazará las rutas locales con URLs de Supabase)
    final payload = {
      'pointId': pointId,
      'routeId': routeId,
      'gpsLat': gpsLat,
      'gpsLon': gpsLon,
      'gpsAccuracy': gpsAccuracy,
      'photosBefore': photosBefore, // Se subirá por el SyncManager
      'photosAfter': photosAfter, // Se subirá por el SyncManager
      'formData': formData,
      'visitedAt': DateTime.now().toIso8601String(),
    };

    await _syncQueueRepository.addToQueue(
      endpoint: '/api/v1/routes/points/$pointId/visit',
      method: 'POST',
      payload: payload,
    );
  }

  /// Registra la omisión voluntaria de un punto de la ruta
  Future<void> omitPoint({
    required String pointId,
    required String routeId,
  }) async {
    // 1. Actualizar estado local del punto a OMITTED
    await (_database.update(_database.routePointsLocal)
          ..where((t) => t.id.equals(pointId)))
        .write(const RoutePointsLocalCompanion(status: Value('OMITTED')));

    // 2. Encolar evento en la cola FIFO
    final payload = {
      'pointId': pointId,
      'routeId': routeId,
      'status': 'OMITTED',
      'timestamp': DateTime.now().toIso8601String(),
    };

    await _syncQueueRepository.addToQueue(
      endpoint: '/api/v1/routes/points/$pointId/omit',
      method: 'POST',
      payload: payload,
    );
  }

  /// Finaliza la ruta actual calculando KPIs locales y encolando la clausura FIFO
  Future<void> finishRoute({
    required String routeId,
    required double gpsLat,
    required double gpsLon,
    required double gpsAccuracy,
  }) async {
    // 1. Cambiar estado local a COMPLETED
    await (_database.update(_database.routesLocal)
          ..where((t) => t.id.equals(routeId)))
        .write(const RoutesLocalCompanion(status: Value('COMPLETED')));

    // 2. Calcular KPIs básicos para la clausura
    final ptRows = await (_database.select(
      _database.routePointsLocal,
    )..where((t) => t.routeId.equals(routeId))).get();

    final totalPoints = ptRows.length;
    final visitedPoints = ptRows.where((p) => p.status == 'COMPLETED').length;
    final omittedPoints = ptRows.where((p) => p.status == 'OMITTED').length;
    final complianceRate = totalPoints > 0
        ? (visitedPoints / totalPoints) * 100
        : 0.0;

    final payload = {
      'routeId': routeId,
      'gpsLat': gpsLat,
      'gpsLon': gpsLon,
      'gpsAccuracy': gpsAccuracy,
      'timestamp': DateTime.now().toIso8601String(),
      'kpiSummary': {
        'totalPoints': totalPoints,
        'visitedPoints': visitedPoints,
        'omittedPoints': omittedPoints,
        'complianceRate': complianceRate,
      },
    };

    // 3. Encolar evento FIFO
    await _syncQueueRepository.addToQueue(
      endpoint: '/api/v1/routes/$routeId/finish',
      method: 'POST',
      payload: payload,
    );
  }

  Future<void> _seedDefaultRoutesLocal() async {
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);

    final routes = [
      {
        'id': 'route-001',
        'name': 'Ruta Baños Químicos - Zona Norte',
        'clientName': 'Minera Escondida',
        'faenaName': 'Escondida',
        'scheduledDate': todayStr,
        'points': [
          {
            'id': 'pt-101',
            'name': 'Taller Principal Camiones',
            'qrCodeToken': 'QR-NORTH-TALLER',
            'seq': 1,
          },
          {
            'id': 'pt-102',
            'name': 'Garita de Acceso Norte',
            'qrCodeToken': 'QR-NORTH-GARITA',
            'seq': 2,
          },
          {
            'id': 'pt-103',
            'name': 'Campamento Central M1',
            'qrCodeToken': 'QR-NORTH-CAMP',
            'seq': 3,
          },
        ],
      },
      {
        'id': 'route-002',
        'name': 'Ruta Mantención - Zona Sur',
        'clientName': 'Anglo American',
        'faenaName': 'Los Bronces',
        'scheduledDate': todayStr,
        'points': [
          {
            'id': 'pt-201',
            'name': 'Subestación Eléctrica Sur',
            'qrCodeToken': 'QR-SOUTH-SUB',
            'seq': 1,
          },
          {
            'id': 'pt-202',
            'name': 'Casino de Operarios',
            'qrCodeToken': 'QR-SOUTH-CASINO',
            'seq': 2,
          },
        ],
      },
    ];

    for (final rt in routes) {
      await _database
          .into(_database.routesLocal)
          .insert(
            RoutesLocalCompanion(
              id: Value(rt['id'] as String),
              name: Value(rt['name'] as String),
              clientName: Value(rt['clientName'] as String),
              faenaName: Value(rt['faenaName'] as String),
              status: const Value('PENDING'),
              scheduledDate: Value(rt['scheduledDate'] as String),
            ),
          );

      final pts = rt['points'] as List<Map<String, dynamic>>;
      for (final pt in pts) {
        await _database
            .into(_database.routePointsLocal)
            .insert(
              RoutePointsLocalCompanion(
                id: Value(pt['id'] as String),
                routeId: Value(rt['id'] as String),
                name: Value(pt['name'] as String),
                qrCodeToken: Value(pt['qrCodeToken'] as String),
                sequenceOrder: Value(pt['seq'] as int),
                status: const Value('PENDING'),
              ),
            );
      }
    }
  }
}
