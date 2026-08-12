import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/repositories/verification_repository.dart';
import '../../data/models/document_model.dart';
import '../../data/models/vehicle_model.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerificationRepository _verificationRepository;

  VerificationCubit(this._verificationRepository)
    : super(VerificationInitial());

  /// Valida la documentación diaria del trabajador
  Future<void> checkWorkerDocuments(String workerId) async {
    emit(VerificationLoading());
    try {
      final docs = await _verificationRepository.getWorkerDocuments(workerId);

      // Comprobar si existe algún documento en estado RED (vencido o < 30 días)
      final expiredDoc = docs.firstWhere(
        (doc) => doc.status == DocumentStatus.red,
        orElse: () => DocumentModel(
          id: '',
          documentType: '',
          emissionDate: '',
          expiryDate: '',
        ),
      );

      if (expiredDoc.id.isNotEmpty) {
        // Trabajador bloqueado
        final reason =
            'Documento vencido o próximo a vencer: ${expiredDoc.documentName} (Expira: ${expiredDoc.expiryDate})';
        final gps = await _getCurrentGPS();

        await _verificationRepository.logVerificationBlock(
          action: 'WORKER_DOCUMENT_EXPIRED',
          reason: reason,
          gpsLat: gps['lat']!,
          gpsLon: gps['lon']!,
          gpsAccuracy: gps['accuracy']!,
        );

        emit(VerificationBlocked(reason));
      } else {
        emit(WorkerDocsChecked(docs, false));
      }
    } catch (e) {
      emit(VerificationError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// Valida el vehículo escaneado mediante código QR
  Future<void> scanVehicleQR(String qrToken, String workerId) async {
    emit(VerificationLoading());
    try {
      final result = await _verificationRepository.getVehicleByQR(qrToken);
      final vehicle = result['vehicle'] as VehicleModel;
      final docs = result['documents'] as List<DocumentModel>;

      if (!vehicle.isActive) {
        final reason =
            'Vehículo inhabilitado administrativamente (Patente: ${vehicle.plateNumber})';
        final gps = await _getCurrentGPS();
        await _verificationRepository.logVerificationBlock(
          action: 'VEHICLE_INACTIVE',
          reason: reason,
          gpsLat: gps['lat']!,
          gpsLon: gps['lon']!,
          gpsAccuracy: gps['accuracy']!,
        );
        emit(VerificationBlocked(reason));
        return;
      }

      // Comprobar documentos vencidos del vehículo
      final expiredDoc = docs.firstWhere(
        (doc) => doc.status == DocumentStatus.red,
        orElse: () => DocumentModel(
          id: '',
          documentType: '',
          emissionDate: '',
          expiryDate: '',
        ),
      );

      if (expiredDoc.id.isNotEmpty) {
        final reason =
            'Vehículo bloqueado: Documento vencido o próximo a vencer en ${vehicle.plateNumber}: ${expiredDoc.documentName} (Expira: ${expiredDoc.expiryDate})';
        final gps = await _getCurrentGPS();

        await _verificationRepository.logVerificationBlock(
          action: 'VEHICLE_DOCUMENT_EXPIRED',
          reason: reason,
          gpsLat: gps['lat']!,
          gpsLon: gps['lon']!,
          gpsAccuracy: gps['accuracy']!,
        );

        emit(VerificationBlocked(reason));
      } else {
        emit(VehicleQRScanned(vehicle, docs, false));
      }
    } catch (e) {
      emit(VerificationError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// Finaliza la verificación con éxito
  void approveVerification(VehicleModel vehicle) {
    emit(VerificationSuccess(vehicle));
  }

  /// Resetea el flujo al inicio
  void reset() {
    emit(VerificationInitial());
  }

  /// Obtiene la posición GPS actual de forma segura para las auditorías
  Future<Map<String, double>> _getCurrentGPS() async {
    try {
      // Verificar permisos
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

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
    // Fallback si falla el GPS
    return {'lat': 0.0, 'lon': 0.0, 'accuracy': 0.0};
  }
}
