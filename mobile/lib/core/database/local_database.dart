import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'local_database.g.dart';

// 1. TABLA: SyncQueue (Cola FIFO para sincronización)
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get endpoint => text()();
  TextColumn get method => text()();
  TextColumn get payload => text()(); // Payload en formato JSON String
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// 2. TABLA: RoutesLocal (Rutas descargadas)
class RoutesLocal extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get clientName => text()();
  TextColumn get faenaName => text()();
  TextColumn get status => text()(); // PENDING, IN_PROGRESS, COMPLETED
  TextColumn get scheduledDate => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// 3. TABLA: RoutePointsLocal (Puntos de control descargados)
class RoutePointsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get routeId => text()();
  TextColumn get name => text()();
  TextColumn get qrCodeToken => text()();
  IntColumn get sequenceOrder => integer()();
  TextColumn get status => text()(); // PENDING, COMPLETED, OMITTED

  @override
  Set<Column> get primaryKey => {id};
}

// 4. TABLA: RoutePointVisitsLocal (Visitas registradas offline)
class RoutePointVisitsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get pointId => text()();
  DateTimeColumn get visitedAt => dateTime()();
  RealColumn get gpsLat => real()();
  RealColumn get gpsLon => real()();
  RealColumn get gpsAccuracy => real()();
  TextColumn get photosBefore => text()(); // Serializado en JSON o delimitado
  TextColumn get photosAfter => text()();  // Serializado en JSON o delimitado
  TextColumn get formData => text()();     // Respuestas adicionales JSON String

  @override
  Set<Column> get primaryKey => {id};
}

// 5. TABLA: ChecklistSubmissionsLocal (Respuestas de checklists offline)
class ChecklistSubmissionsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get checklistId => text()();
  TextColumn get vehicleId => text().nullable()();
  TextColumn get routeId => text().nullable()();
  DateTimeColumn get submittedAt => dateTime()();
  RealColumn get gpsLat => real()();
  RealColumn get gpsLon => real()();
  RealColumn get gpsAccuracy => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// 6. TABLA: ChecklistAnswersLocal (Detalles de respuestas offline)
class ChecklistAnswersLocal extends Table {
  TextColumn get id => text()();
  TextColumn get submissionId => text()();
  TextColumn get questionId => text()();
  TextColumn get answerValue => text()();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get signatureUrl => text().nullable()();
  BoolColumn get isFailedCritical => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// 7. TABLA: AuditLogsLocal (Trazabilidad y auditorías locales)
class AuditLogsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get action => text()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  TextColumn get deviceInfo => text().nullable()();
  RealColumn get gpsLat => real().nullable()();
  RealColumn get gpsLon => real().nullable()();
  TextColumn get payload => text()(); // Datos adicionales en JSON String

  @override
  Set<Column> get primaryKey => {id};
}

// 8. TABLA: WorkerDocumentsLocal (Caché local de documentos del operario)
class WorkerDocumentsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get documentType => text()();
  TextColumn get emissionDate => text()();
  TextColumn get expiryDate => text()();
  TextColumn get fileUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 9. TABLA: VehiclesLocal (Caché local de vehículos)
class VehiclesLocal extends Table {
  TextColumn get id => text()();
  TextColumn get plateNumber => text()();
  TextColumn get brand => text()();
  TextColumn get model => text()();
  IntColumn get year => integer()();
  IntColumn get lastOdometer => integer()();
  TextColumn get qrCodeToken => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

// 10. TABLA: VehicleDocumentsLocal (Caché local de documentos de vehículos)
class VehicleDocumentsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text()();
  TextColumn get documentType => text()();
  TextColumn get emissionDate => text()();
  TextColumn get expiryDate => text()();
  TextColumn get fileUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// 11. TABLA: ChecklistsLocal (Caché de plantillas de checklists)
class ChecklistsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get version => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 12. TABLA: ChecklistQuestionsLocal (Caché de preguntas de checklists)
class ChecklistQuestionsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get checklistId => text()();
  TextColumn get questionText => text()();
  TextColumn get questionType => text()();
  BoolColumn get isRequired => boolean().withDefault(const Constant(true))();
  BoolColumn get isCritical => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// 13. TABLA: ChecklistQuestionOptionsLocal (Caché de opciones de selección múltiple)
class ChecklistQuestionOptionsLocal extends Table {
  TextColumn get id => text()();
  TextColumn get questionId => text()();
  TextColumn get optionText => text()();
  BoolColumn get isCriticalTrigger => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// Configuración de la base de datos local
@DriftDatabase(tables: [
  SyncQueue,
  RoutesLocal,
  RoutePointsLocal,
  RoutePointVisitsLocal,
  ChecklistSubmissionsLocal,
  ChecklistAnswersLocal,
  AuditLogsLocal,
  WorkerDocumentsLocal,
  VehiclesLocal,
  VehicleDocumentsLocal,
  ChecklistsLocal,
  ChecklistQuestionsLocal,
  ChecklistQuestionOptionsLocal,
])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gestion_operacional.db'));
    return NativeDatabase.createInBackground(file);
  });
}
