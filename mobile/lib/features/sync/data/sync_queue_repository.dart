import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../core/database/local_database.dart';

class SyncQueueRepository {
  final LocalDatabase _database;

  SyncQueueRepository(this._database);

  /// Agrega un nuevo evento a la cola de sincronización FIFO
  Future<int> addToQueue({
    required String endpoint,
    required String method,
    required Map<String, dynamic> payload,
  }) async {
    final companion = SyncQueueCompanion(
      endpoint: Value(endpoint),
      method: Value(method),
      payload: Value(jsonEncode(payload)),
      createdAt: Value(DateTime.now()),
    );
    return _database.into(_database.syncQueue).insert(companion);
  }

  /// Obtiene el siguiente registro de la cola FIFO (el más antiguo)
  Future<SyncQueueData?> getNextItem() async {
    final query = _database.select(_database.syncQueue)
      ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc)])
      ..limit(1);

    return query.getSingleOrNull();
  }

  /// Elimina un registro de la cola una vez sincronizado
  Future<int> deleteFromQueue(int id) async {
    return (_database.delete(
      _database.syncQueue,
    )..where((t) => t.id.equals(id))).go();
  }

  /// Obtiene la cantidad de elementos pendientes de sincronización
  Future<int> getQueueCount() async {
    final countExpr = _database.syncQueue.id.count();
    final query = _database.selectOnly(_database.syncQueue)
      ..addColumns([countExpr]);
    final row = await query.getSingle();
    return row.read(countExpr) ?? 0;
  }
}
