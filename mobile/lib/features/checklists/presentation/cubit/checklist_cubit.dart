import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import '../../data/repositories/checklists_repository.dart';
import '../../data/models/checklist_model.dart';
import 'checklist_state.dart';

class ChecklistCubit extends Cubit<ChecklistState> {
  final ChecklistsRepository _checklistsRepository;
  final Uuid _uuid = const Uuid();

  ChecklistCubit(this._checklistsRepository) : super(ChecklistInitial());

  /// Carga las plantillas de checklists activos
  Future<void> loadChecklists() async {
    emit(ChecklistLoading());
    try {
      final checklists = await _checklistsRepository.getActiveChecklists();
      emit(ChecklistsLoaded(checklists));
    } catch (e) {
      emit(ChecklistError('Error al cargar checklists: ${e.toString()}'));
    }
  }

  /// Resuelve y envía las respuestas del checklist
  Future<void> submitAnswers({
    required String checklistId,
    required Map<String, String> answers, // Map<questionId, responseValue>
    required Map<String, String?>
    answerPhotos, // Map<questionId, localPhotoPath>
    required List<ChecklistQuestionModel> questions,
    String? vehicleId,
    String? routeId,
  }) async {
    emit(ChecklistSubmitting());
    try {
      final submissionId = _uuid.v4();
      final List<Map<String, dynamic>> processedAnswers = [];
      bool hasFailedCritical = false;
      String criticalQuestionText = '';

      for (final q in questions) {
        final value = answers[q.id] ?? '';
        final photoPath = answerPhotos[q.id];

        bool isFailedCritical = false;

        // Validar si la respuesta gatilla una falla crítica en checklist de seguridad
        if (q.isCritical) {
          if (q.questionType == 'YES_NO' && value.toUpperCase() == 'NO') {
            isFailedCritical = true;
          } else if (q.questionType == 'MULTIPLE_CHOICE') {
            final opt = q.options.firstWhere(
              (o) => o.optionText == value,
              orElse: () => ChecklistQuestionOptionModel(
                id: '',
                questionId: '',
                optionText: '',
                isCriticalTrigger: false,
              ),
            );
            if (opt.isCriticalTrigger) {
              isFailedCritical = true;
            }
          }
        }

        if (isFailedCritical) {
          hasFailedCritical = true;
          criticalQuestionText = q.questionText;
        }

        processedAnswers.add({
          'questionId': q.id,
          'value': value,
          'photoUrl':
              photoPath, // Se subirá por el SyncManager si es path local
          'signatureUrl': null,
          'isFailedCritical': isFailedCritical,
        });
      }

      final gps = await _getCurrentGPS();

      await _checklistsRepository.submitChecklist(
        submissionId: submissionId,
        checklistId: checklistId,
        vehicleId: vehicleId,
        routeId: routeId,
        answers: processedAnswers,
        gpsLat: gps['lat']!,
        gpsLon: gps['lon']!,
        gpsAccuracy: gps['accuracy']!,
      );

      if (hasFailedCritical) {
        emit(
          ChecklistSubmitBlocked(
            'El checklist falló en una pregunta de carácter CRÍTICO:\n"$criticalQuestionText". El ingreso queda bloqueado y se ha notificado al supervisor.',
          ),
        );
      } else {
        emit(ChecklistSubmitSuccess());
      }
    } catch (e) {
      emit(ChecklistError(e.toString()));
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
