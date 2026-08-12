import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../../core/database/local_database.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../sync/data/sync_queue_repository.dart';
import '../models/checklist_model.dart';

class ChecklistsRepository {
  final ApiClient _apiClient;
  final LocalDatabase _database;
  final ConnectivityService _connectivityService;
  final SyncQueueRepository _syncQueueRepository;

  ChecklistsRepository({
    required this._apiClient,
    required this._database,
    required this._connectivityService,
    required this._syncQueueRepository,
  });

  /// Obtiene todos los checklists activos desde el servidor o el caché local (offline)
  Future<List<ChecklistModel>> getActiveChecklists() async {
    final isOnline = await _connectivityService.isConnected;

    if (isOnline) {
      try {
        final response = await _apiClient.get('/api/v1/checklists/active');
        final List<dynamic> data = response.data;
        final checklists = data
            .map((json) => ChecklistModel.fromJson(json))
            .toList();

        // 1. Limpiar caché local
        await _database.delete(_database.checklistsLocal).go();
        await _database.delete(_database.checklistQuestionsLocal).go();
        await _database.delete(_database.checklistQuestionOptionsLocal).go();

        // 2. Guardar en SQLite
        for (final cl in checklists) {
          await _database
              .into(_database.checklistsLocal)
              .insert(
                ChecklistsLocalCompanion(
                  id: Value(cl.id),
                  title: Value(cl.title),
                  description: Value(cl.description),
                  version: Value(cl.version),
                ),
              );

          for (final q in cl.questions) {
            await _database
                .into(_database.checklistQuestionsLocal)
                .insert(
                  ChecklistQuestionsLocalCompanion(
                    id: Value(q.id),
                    checklistId: Value(q.checklistId),
                    questionText: Value(q.questionText),
                    questionType: Value(q.questionType),
                    isRequired: Value(q.isRequired),
                    isCritical: Value(q.isCritical),
                    sortOrder: Value(q.sortOrder),
                  ),
                );

            for (final opt in q.options) {
              await _database
                  .into(_database.checklistQuestionOptionsLocal)
                  .insert(
                    ChecklistQuestionOptionsLocalCompanion(
                      id: Value(opt.id),
                      questionId: Value(opt.questionId),
                      optionText: Value(opt.optionText),
                      isCriticalTrigger: Value(opt.isCriticalTrigger),
                    ),
                  );
            }
          }
        }

        return checklists;
      } catch (e) {
        return _getActiveChecklistsOffline();
      }
    } else {
      return _getActiveChecklistsOffline();
    }
  }

  Future<List<ChecklistModel>> _getActiveChecklistsOffline() async {
    var clRows = await _database.select(_database.checklistsLocal).get();

    // Si la caché local está vacía, sembramos por defecto los 4 checklists estándar
    if (clRows.isEmpty) {
      await _seedDefaultChecklistsLocal();
      clRows = await _database.select(_database.checklistsLocal).get();
    }

    final List<ChecklistModel> checklists = [];

    for (final row in clRows) {
      final qRows =
          await (_database.select(_database.checklistQuestionsLocal)
                ..where((t) => t.checklistId.equals(row.id))
                ..orderBy([
                  (t) => OrderingTerm(
                    expression: t.sortOrder,
                    mode: OrderingMode.asc,
                  ),
                ]))
              .get();

      final List<ChecklistQuestionModel> questions = [];

      for (final qRow in qRows) {
        final optRows = await (_database.select(
          _database.checklistQuestionOptionsLocal,
        )..where((t) => t.questionId.equals(qRow.id))).get();

        final options = optRows.map((optRow) {
          return ChecklistQuestionOptionModel(
            id: optRow.id,
            questionId: optRow.questionId,
            optionText: optRow.optionText,
            isCriticalTrigger: optRow.isCriticalTrigger,
          );
        }).toList();

        questions.add(
          ChecklistQuestionModel(
            id: qRow.id,
            checklistId: qRow.checklistId,
            questionText: qRow.questionText,
            questionType: qRow.questionType,
            isRequired: qRow.isRequired,
            isCritical: qRow.isCritical,
            sortOrder: qRow.sortOrder,
            options: options,
          ),
        );
      }

      checklists.add(
        ChecklistModel(
          id: row.id,
          title: row.title,
          description: row.description,
          version: row.version,
          questions: questions,
        ),
      );
    }

    return checklists;
  }

  Future<void> _seedDefaultChecklistsLocal() async {
    final checklists = [
      {
        'id': 'chk-fatiga',
        'title': 'Fatiga y Somnolencia',
        'description': 'Autoevaluación del estado de fatiga diaria.',
        'questions': [
          {
            'id': 'q-fatiga-1',
            'text': '¿Durmió al menos 6 horas anoche?',
            'type': 'YES_NO',
            'required': true,
            'critical': true,
          },
          {
            'id': 'q-fatiga-2',
            'text': '¿Se siente alerta y en óptimas condiciones para conducir?',
            'type': 'YES_NO',
            'required': true,
            'critical': true,
          },
          {
            'id': 'q-fatiga-3',
            'text':
                '¿Ha consumido algún medicamento relajante en las últimas 12 horas?',
            'type': 'YES_NO',
            'required': true,
            'critical': false,
          },
        ],
      },
      {
        'id': 'chk-equipo',
        'title': 'Estado del Equipo / Camión',
        'description': 'Revisión rápida pre-operacional del camión.',
        'questions': [
          {
            'id': 'q-equipo-1',
            'text':
                'Inspección de dirección y frenos: ¿Funcionan correctamente?',
            'type': 'YES_NO',
            'required': true,
            'critical': true,
          },
          {
            'id': 'q-equipo-2',
            'text':
                '¿Los neumáticos tienen presión correcta y sin desgaste excesivo?',
            'type': 'YES_NO',
            'required': true,
            'critical': true,
          },
          {
            'id': 'q-equipo-3',
            'text': 'Tome una fotografía del odómetro actual:',
            'type': 'PHOTO',
            'required': true,
            'critical': false,
          },
        ],
      },
      {
        'id': 'chk-herramientas',
        'title': 'Estado de Herramientas',
        'description': 'Revisión de equipamiento de trabajo en terreno.',
        'questions': [
          {
            'id': 'q-herr-1',
            'text': '¿Todas las herramientas manuales están libres de fisuras?',
            'type': 'YES_NO',
            'required': true,
            'critical': true,
          },
          {
            'id': 'q-herr-2',
            'text':
                '¿Posee extintor de incendios vigente y cargado en el equipo?',
            'type': 'YES_NO',
            'required': true,
            'critical': true,
          },
        ],
      },
      {
        'id': 'chk-epp',
        'title': 'Estado del EPP',
        'description': 'Control de Elementos de Protección Personal.',
        'questions': [
          {
            'id': 'q-epp-1',
            'text': '¿Posee casco de seguridad y lentes con protección UV?',
            'type': 'YES_NO',
            'required': true,
            'critical': true,
          },
          {
            'id': 'q-epp-2',
            'text': '¿Utiliza zapatos de seguridad con puntera de acero?',
            'type': 'YES_NO',
            'required': true,
            'critical': true,
          },
        ],
      },
    ];

    for (final cl in checklists) {
      await _database
          .into(_database.checklistsLocal)
          .insert(
            ChecklistsLocalCompanion(
              id: Value(cl['id'] as String),
              title: Value(cl['title'] as String),
              description: Value(cl['description'] as String),
              version: const Value(1),
            ),
          );

      final List<Map<String, dynamic>> qs =
          cl['questions'] as List<Map<String, dynamic>>;
      int order = 0;
      for (final q in qs) {
        await _database
            .into(_database.checklistQuestionsLocal)
            .insert(
              ChecklistQuestionsLocalCompanion(
                id: Value(q['id'] as String),
                checklistId: Value(cl['id'] as String),
                questionText: Value(q['text'] as String),
                questionType: Value(q['type'] as String),
                isRequired: Value(q['required'] as bool),
                isCritical: Value(q['critical'] as bool),
                sortOrder: Value(order++),
              ),
            );
      }
    }
  }

  /// Envía o encola un checklist resuelto localmente (Soporte Offline-First)
  Future<void> submitChecklist({
    required String submissionId,
    required String checklistId,
    String? vehicleId,
    String? routeId,
    required List<Map<String, dynamic>>
    answers, // Contiene questionId, value, isFailedCritical, photoUrl
    required double gpsLat,
    required double gpsLon,
    required double gpsAccuracy,
  }) async {
    final payload = {
      'submissionId': submissionId,
      'checklistId': checklistId,
      'vehicleId': vehicleId,
      'routeId': routeId,
      'answers': answers,
      'gpsLat': gpsLat,
      'gpsLon': gpsLon,
      'gpsAccuracy': gpsAccuracy,
      'submittedAt': DateTime.now().toIso8601String(),
    };

    // 1. Guardar localmente la cabecera
    await _database
        .into(_database.checklistSubmissionsLocal)
        .insert(
          ChecklistSubmissionsLocalCompanion(
            id: Value(submissionId),
            checklistId: Value(checklistId),
            vehicleId: Value(vehicleId),
            routeId: Value(routeId),
            submittedAt: Value(DateTime.now()),
            gpsLat: Value(gpsLat),
            gpsLon: Value(gpsLon),
            gpsAccuracy: Value(gpsAccuracy),
          ),
        );

    // 2. Guardar localmente cada respuesta
    for (final ans in answers) {
      final answerId =
          DateTime.now().millisecondsSinceEpoch.toString() + ans['questionId'];
      await _database
          .into(_database.checklistAnswersLocal)
          .insert(
            ChecklistAnswersLocalCompanion(
              id: Value(answerId),
              submissionId: Value(submissionId),
              questionId: Value(ans['questionId']),
              answerValue: Value(ans['value'].toString()),
              photoUrl: Value(ans['photoUrl']),
              signatureUrl: Value(ans['signatureUrl']),
              isFailedCritical: Value(ans['isFailedCritical'] ?? false),
            ),
          );
    }

    // 3. Encolar el payload JSON para la sincronización FIFO
    await _syncQueueRepository.addToQueue(
      endpoint: '/api/v1/checklists/submissions',
      method: 'POST',
      payload: payload,
    );

    // 4. Si hay respuestas críticas fallidas, registrar alerta de bloqueo operacional de inmediato
    final criticalFail = answers.any((ans) => ans['isFailedCritical'] == true);
    if (criticalFail) {
      final alertPayload = {
        'block_id': submissionId,
        'action': 'CHECKLIST_CRITICAL_FAIL',
        'reason': 'Falla crítica reportada en checklist: $checklistId',
        'gps_lat': gpsLat,
        'gps_lon': gpsLon,
        'gps_accuracy': gpsAccuracy,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Registrar auditoría local
      await _database
          .into(_database.auditLogsLocal)
          .insert(
            AuditLogsLocalCompanion(
              id: Value(submissionId),
              action: const Value('CHECKLIST_CRITICAL_FAIL'),
              timestamp: Value(DateTime.now()),
              gpsLat: Value(gpsLat),
              gpsLon: Value(gpsLon),
              payload: Value(jsonEncode(alertPayload)),
            ),
          );

      // Encolar alerta al servidor de inmediato
      await _syncQueueRepository.addToQueue(
        endpoint: '/api/v1/audit/block-alert',
        method: 'POST',
        payload: alertPayload,
      );
    }
  }
}
