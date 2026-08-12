import '../../data/models/document_model.dart';
import '../../data/models/vehicle_model.dart';

abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class WorkerDocsChecked extends VerificationState {
  final List<DocumentModel> docs;
  final bool isBlocked;
  WorkerDocsChecked(this.docs, this.isBlocked);
}

class VehicleQRScanned extends VerificationState {
  final VehicleModel vehicle;
  final List<DocumentModel> docs;
  final bool isBlocked;
  VehicleQRScanned(this.vehicle, this.docs, this.isBlocked);
}

class VerificationSuccess extends VerificationState {
  final VehicleModel vehicle;
  VerificationSuccess(this.vehicle);
}

class VerificationBlocked extends VerificationState {
  final String reason;
  VerificationBlocked(this.reason);
}

class VerificationError extends VerificationState {
  final String message;
  VerificationError(this.message);
}
