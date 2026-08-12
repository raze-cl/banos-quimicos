import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/repositories/routes_repository.dart';
import 'routes_state.dart';

class RoutesCubit extends Cubit<RoutesState> {
  final RoutesRepository _routesRepository;

  RoutesCubit(this._routesRepository) : super(RoutesInitial());

  /// Carga las rutas asignadas al trabajador actual
  Future<void> loadRoutes(String workerId) async {
    emit(RoutesLoading());
    try {
      final routes = await _routesRepository.getAssignedRoutes(workerId);
      emit(RoutesLoaded(routes));
    } catch (e) {
      emit(RoutesError('Error al cargar rutas: ${e.toString()}'));
    }
  }

  /// Registra el inicio operacional de una ruta
  Future<void> startRoute(String routeId, String workerId) async {
    emit(RouteActionLoading());
    try {
      final gps = await _getCurrentGPS();
      await _routesRepository.startRoute(
        routeId: routeId,
        gpsLat: gps['lat']!,
        gpsLon: gps['lon']!,
        gpsAccuracy: gps['accuracy']!,
      );
      emit(RouteActionSuccess());
      // Recargar lista para refrescar estados
      await loadRoutes(workerId);
    } catch (e) {
      emit(RoutesError(e.toString()));
    }
  }

  /// Registra la atención operacional realizada a un punto (QR + GPS + Fotos)
  Future<void> visitPoint({
    required String pointId,
    required String routeId,
    required String workerId,
    required List<String> photosBefore,
    required List<String> photosAfter,
    required Map<String, dynamic> formData,
  }) async {
    emit(RouteActionLoading());
    try {
      final gps = await _getCurrentGPS();
      await _routesRepository.visitPoint(
        pointId: pointId,
        routeId: routeId,
        gpsLat: gps['lat']!,
        gpsLon: gps['lon']!,
        gpsAccuracy: gps['accuracy']!,
        photosBefore: photosBefore,
        photosAfter: photosAfter,
        formData: formData,
      );
      emit(RouteActionSuccess());
      await loadRoutes(workerId);
    } catch (e) {
      emit(RoutesError(e.toString()));
    }
  }

  /// Registra la omisión voluntaria de un punto
  Future<void> omitPoint({
    required String pointId,
    required String routeId,
    required String workerId,
  }) async {
    emit(RouteActionLoading());
    try {
      await _routesRepository.omitPoint(pointId: pointId, routeId: routeId);
      emit(RouteActionSuccess());
      await loadRoutes(workerId);
    } catch (e) {
      emit(RoutesError(e.toString()));
    }
  }

  /// Cierra/Finaliza la ruta de forma definitiva
  Future<void> finishRoute(String routeId, String workerId) async {
    emit(RouteActionLoading());
    try {
      final gps = await _getCurrentGPS();
      await _routesRepository.finishRoute(
        routeId: routeId,
        gpsLat: gps['lat']!,
        gpsLon: gps['lon']!,
        gpsAccuracy: gps['accuracy']!,
      );
      emit(RouteActionSuccess());
      await loadRoutes(workerId);
    } catch (e) {
      emit(RoutesError(e.toString()));
    }
  }

  /// Obtiene la posición GPS actual de forma segura
  Future<Map<String, double>> _getCurrentGPS() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        final pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 5),
        );
        return {
          'lat': pos.latitude,
          'lon': pos.longitude,
          'accuracy': pos.accuracy,
        };
      }
    } catch (_) {}
    return {'lat': 0.0, 'lon': 0.0, 'accuracy': 0.0};
  }
}
