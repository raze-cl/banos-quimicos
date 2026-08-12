// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _endpointMeta = const VerificationMeta(
    'endpoint',
  );
  @override
  late final GeneratedColumn<String> endpoint = GeneratedColumn<String>(
    'endpoint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    endpoint,
    method,
    payload,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('endpoint')) {
      context.handle(
        _endpointMeta,
        endpoint.isAcceptableOrUnknown(data['endpoint']!, _endpointMeta),
      );
    } else if (isInserting) {
      context.missing(_endpointMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      endpoint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}endpoint'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String endpoint;
  final String method;
  final String payload;
  final DateTime createdAt;
  const SyncQueueData({
    required this.id,
    required this.endpoint,
    required this.method,
    required this.payload,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['endpoint'] = Variable<String>(endpoint);
    map['method'] = Variable<String>(method);
    map['payload'] = Variable<String>(payload);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      endpoint: Value(endpoint),
      method: Value(method),
      payload: Value(payload),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      endpoint: serializer.fromJson<String>(json['endpoint']),
      method: serializer.fromJson<String>(json['method']),
      payload: serializer.fromJson<String>(json['payload']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'endpoint': serializer.toJson<String>(endpoint),
      'method': serializer.toJson<String>(method),
      'payload': serializer.toJson<String>(payload),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? endpoint,
    String? method,
    String? payload,
    DateTime? createdAt,
  }) => SyncQueueData(
    id: id ?? this.id,
    endpoint: endpoint ?? this.endpoint,
    method: method ?? this.method,
    payload: payload ?? this.payload,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      endpoint: data.endpoint.present ? data.endpoint.value : this.endpoint,
      method: data.method.present ? data.method.value : this.method,
      payload: data.payload.present ? data.payload.value : this.payload,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('endpoint: $endpoint, ')
          ..write('method: $method, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, endpoint, method, payload, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.endpoint == this.endpoint &&
          other.method == this.method &&
          other.payload == this.payload &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> endpoint;
  final Value<String> method;
  final Value<String> payload;
  final Value<DateTime> createdAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.endpoint = const Value.absent(),
    this.method = const Value.absent(),
    this.payload = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String endpoint,
    required String method,
    required String payload,
    this.createdAt = const Value.absent(),
  }) : endpoint = Value(endpoint),
       method = Value(method),
       payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? endpoint,
    Expression<String>? method,
    Expression<String>? payload,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (endpoint != null) 'endpoint': endpoint,
      if (method != null) 'method': method,
      if (payload != null) 'payload': payload,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? endpoint,
    Value<String>? method,
    Value<String>? payload,
    Value<DateTime>? createdAt,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      endpoint: endpoint ?? this.endpoint,
      method: method ?? this.method,
      payload: payload ?? this.payload,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (endpoint.present) {
      map['endpoint'] = Variable<String>(endpoint.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('endpoint: $endpoint, ')
          ..write('method: $method, ')
          ..write('payload: $payload, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RoutesLocalTable extends RoutesLocal
    with TableInfo<$RoutesLocalTable, RoutesLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutesLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientNameMeta = const VerificationMeta(
    'clientName',
  );
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
    'client_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _faenaNameMeta = const VerificationMeta(
    'faenaName',
  );
  @override
  late final GeneratedColumn<String> faenaName = GeneratedColumn<String>(
    'faena_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<String> scheduledDate = GeneratedColumn<String>(
    'scheduled_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    clientName,
    faenaName,
    status,
    scheduledDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routes_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutesLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('client_name')) {
      context.handle(
        _clientNameMeta,
        clientName.isAcceptableOrUnknown(data['client_name']!, _clientNameMeta),
      );
    } else if (isInserting) {
      context.missing(_clientNameMeta);
    }
    if (data.containsKey('faena_name')) {
      context.handle(
        _faenaNameMeta,
        faenaName.isAcceptableOrUnknown(data['faena_name']!, _faenaNameMeta),
      );
    } else if (isInserting) {
      context.missing(_faenaNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutesLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutesLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      clientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_name'],
      )!,
      faenaName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}faena_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheduled_date'],
      )!,
    );
  }

  @override
  $RoutesLocalTable createAlias(String alias) {
    return $RoutesLocalTable(attachedDatabase, alias);
  }
}

class RoutesLocalData extends DataClass implements Insertable<RoutesLocalData> {
  final String id;
  final String name;
  final String clientName;
  final String faenaName;
  final String status;
  final String scheduledDate;
  const RoutesLocalData({
    required this.id,
    required this.name,
    required this.clientName,
    required this.faenaName,
    required this.status,
    required this.scheduledDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['client_name'] = Variable<String>(clientName);
    map['faena_name'] = Variable<String>(faenaName);
    map['status'] = Variable<String>(status);
    map['scheduled_date'] = Variable<String>(scheduledDate);
    return map;
  }

  RoutesLocalCompanion toCompanion(bool nullToAbsent) {
    return RoutesLocalCompanion(
      id: Value(id),
      name: Value(name),
      clientName: Value(clientName),
      faenaName: Value(faenaName),
      status: Value(status),
      scheduledDate: Value(scheduledDate),
    );
  }

  factory RoutesLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutesLocalData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      clientName: serializer.fromJson<String>(json['clientName']),
      faenaName: serializer.fromJson<String>(json['faenaName']),
      status: serializer.fromJson<String>(json['status']),
      scheduledDate: serializer.fromJson<String>(json['scheduledDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'clientName': serializer.toJson<String>(clientName),
      'faenaName': serializer.toJson<String>(faenaName),
      'status': serializer.toJson<String>(status),
      'scheduledDate': serializer.toJson<String>(scheduledDate),
    };
  }

  RoutesLocalData copyWith({
    String? id,
    String? name,
    String? clientName,
    String? faenaName,
    String? status,
    String? scheduledDate,
  }) => RoutesLocalData(
    id: id ?? this.id,
    name: name ?? this.name,
    clientName: clientName ?? this.clientName,
    faenaName: faenaName ?? this.faenaName,
    status: status ?? this.status,
    scheduledDate: scheduledDate ?? this.scheduledDate,
  );
  RoutesLocalData copyWithCompanion(RoutesLocalCompanion data) {
    return RoutesLocalData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      clientName: data.clientName.present
          ? data.clientName.value
          : this.clientName,
      faenaName: data.faenaName.present ? data.faenaName.value : this.faenaName,
      status: data.status.present ? data.status.value : this.status,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutesLocalData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('clientName: $clientName, ')
          ..write('faenaName: $faenaName, ')
          ..write('status: $status, ')
          ..write('scheduledDate: $scheduledDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, clientName, faenaName, status, scheduledDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutesLocalData &&
          other.id == this.id &&
          other.name == this.name &&
          other.clientName == this.clientName &&
          other.faenaName == this.faenaName &&
          other.status == this.status &&
          other.scheduledDate == this.scheduledDate);
}

class RoutesLocalCompanion extends UpdateCompanion<RoutesLocalData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> clientName;
  final Value<String> faenaName;
  final Value<String> status;
  final Value<String> scheduledDate;
  final Value<int> rowid;
  const RoutesLocalCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.clientName = const Value.absent(),
    this.faenaName = const Value.absent(),
    this.status = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutesLocalCompanion.insert({
    required String id,
    required String name,
    required String clientName,
    required String faenaName,
    required String status,
    required String scheduledDate,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       clientName = Value(clientName),
       faenaName = Value(faenaName),
       status = Value(status),
       scheduledDate = Value(scheduledDate);
  static Insertable<RoutesLocalData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? clientName,
    Expression<String>? faenaName,
    Expression<String>? status,
    Expression<String>? scheduledDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (clientName != null) 'client_name': clientName,
      if (faenaName != null) 'faena_name': faenaName,
      if (status != null) 'status': status,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutesLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? clientName,
    Value<String>? faenaName,
    Value<String>? status,
    Value<String>? scheduledDate,
    Value<int>? rowid,
  }) {
    return RoutesLocalCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      clientName: clientName ?? this.clientName,
      faenaName: faenaName ?? this.faenaName,
      status: status ?? this.status,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (faenaName.present) {
      map['faena_name'] = Variable<String>(faenaName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<String>(scheduledDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutesLocalCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('clientName: $clientName, ')
          ..write('faenaName: $faenaName, ')
          ..write('status: $status, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutePointsLocalTable extends RoutePointsLocal
    with TableInfo<$RoutePointsLocalTable, RoutePointsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutePointsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routeIdMeta = const VerificationMeta(
    'routeId',
  );
  @override
  late final GeneratedColumn<String> routeId = GeneratedColumn<String>(
    'route_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrCodeTokenMeta = const VerificationMeta(
    'qrCodeToken',
  );
  @override
  late final GeneratedColumn<String> qrCodeToken = GeneratedColumn<String>(
    'qr_code_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sequenceOrderMeta = const VerificationMeta(
    'sequenceOrder',
  );
  @override
  late final GeneratedColumn<int> sequenceOrder = GeneratedColumn<int>(
    'sequence_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routeId,
    name,
    qrCodeToken,
    sequenceOrder,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'route_points_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutePointsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('route_id')) {
      context.handle(
        _routeIdMeta,
        routeId.isAcceptableOrUnknown(data['route_id']!, _routeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('qr_code_token')) {
      context.handle(
        _qrCodeTokenMeta,
        qrCodeToken.isAcceptableOrUnknown(
          data['qr_code_token']!,
          _qrCodeTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_qrCodeTokenMeta);
    }
    if (data.containsKey('sequence_order')) {
      context.handle(
        _sequenceOrderMeta,
        sequenceOrder.isAcceptableOrUnknown(
          data['sequence_order']!,
          _sequenceOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sequenceOrderMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutePointsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutePointsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      routeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      qrCodeToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_code_token'],
      )!,
      sequenceOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence_order'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $RoutePointsLocalTable createAlias(String alias) {
    return $RoutePointsLocalTable(attachedDatabase, alias);
  }
}

class RoutePointsLocalData extends DataClass
    implements Insertable<RoutePointsLocalData> {
  final String id;
  final String routeId;
  final String name;
  final String qrCodeToken;
  final int sequenceOrder;
  final String status;
  const RoutePointsLocalData({
    required this.id,
    required this.routeId,
    required this.name,
    required this.qrCodeToken,
    required this.sequenceOrder,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['route_id'] = Variable<String>(routeId);
    map['name'] = Variable<String>(name);
    map['qr_code_token'] = Variable<String>(qrCodeToken);
    map['sequence_order'] = Variable<int>(sequenceOrder);
    map['status'] = Variable<String>(status);
    return map;
  }

  RoutePointsLocalCompanion toCompanion(bool nullToAbsent) {
    return RoutePointsLocalCompanion(
      id: Value(id),
      routeId: Value(routeId),
      name: Value(name),
      qrCodeToken: Value(qrCodeToken),
      sequenceOrder: Value(sequenceOrder),
      status: Value(status),
    );
  }

  factory RoutePointsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutePointsLocalData(
      id: serializer.fromJson<String>(json['id']),
      routeId: serializer.fromJson<String>(json['routeId']),
      name: serializer.fromJson<String>(json['name']),
      qrCodeToken: serializer.fromJson<String>(json['qrCodeToken']),
      sequenceOrder: serializer.fromJson<int>(json['sequenceOrder']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routeId': serializer.toJson<String>(routeId),
      'name': serializer.toJson<String>(name),
      'qrCodeToken': serializer.toJson<String>(qrCodeToken),
      'sequenceOrder': serializer.toJson<int>(sequenceOrder),
      'status': serializer.toJson<String>(status),
    };
  }

  RoutePointsLocalData copyWith({
    String? id,
    String? routeId,
    String? name,
    String? qrCodeToken,
    int? sequenceOrder,
    String? status,
  }) => RoutePointsLocalData(
    id: id ?? this.id,
    routeId: routeId ?? this.routeId,
    name: name ?? this.name,
    qrCodeToken: qrCodeToken ?? this.qrCodeToken,
    sequenceOrder: sequenceOrder ?? this.sequenceOrder,
    status: status ?? this.status,
  );
  RoutePointsLocalData copyWithCompanion(RoutePointsLocalCompanion data) {
    return RoutePointsLocalData(
      id: data.id.present ? data.id.value : this.id,
      routeId: data.routeId.present ? data.routeId.value : this.routeId,
      name: data.name.present ? data.name.value : this.name,
      qrCodeToken: data.qrCodeToken.present
          ? data.qrCodeToken.value
          : this.qrCodeToken,
      sequenceOrder: data.sequenceOrder.present
          ? data.sequenceOrder.value
          : this.sequenceOrder,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutePointsLocalData(')
          ..write('id: $id, ')
          ..write('routeId: $routeId, ')
          ..write('name: $name, ')
          ..write('qrCodeToken: $qrCodeToken, ')
          ..write('sequenceOrder: $sequenceOrder, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, routeId, name, qrCodeToken, sequenceOrder, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutePointsLocalData &&
          other.id == this.id &&
          other.routeId == this.routeId &&
          other.name == this.name &&
          other.qrCodeToken == this.qrCodeToken &&
          other.sequenceOrder == this.sequenceOrder &&
          other.status == this.status);
}

class RoutePointsLocalCompanion extends UpdateCompanion<RoutePointsLocalData> {
  final Value<String> id;
  final Value<String> routeId;
  final Value<String> name;
  final Value<String> qrCodeToken;
  final Value<int> sequenceOrder;
  final Value<String> status;
  final Value<int> rowid;
  const RoutePointsLocalCompanion({
    this.id = const Value.absent(),
    this.routeId = const Value.absent(),
    this.name = const Value.absent(),
    this.qrCodeToken = const Value.absent(),
    this.sequenceOrder = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutePointsLocalCompanion.insert({
    required String id,
    required String routeId,
    required String name,
    required String qrCodeToken,
    required int sequenceOrder,
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       routeId = Value(routeId),
       name = Value(name),
       qrCodeToken = Value(qrCodeToken),
       sequenceOrder = Value(sequenceOrder),
       status = Value(status);
  static Insertable<RoutePointsLocalData> custom({
    Expression<String>? id,
    Expression<String>? routeId,
    Expression<String>? name,
    Expression<String>? qrCodeToken,
    Expression<int>? sequenceOrder,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routeId != null) 'route_id': routeId,
      if (name != null) 'name': name,
      if (qrCodeToken != null) 'qr_code_token': qrCodeToken,
      if (sequenceOrder != null) 'sequence_order': sequenceOrder,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutePointsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? routeId,
    Value<String>? name,
    Value<String>? qrCodeToken,
    Value<int>? sequenceOrder,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return RoutePointsLocalCompanion(
      id: id ?? this.id,
      routeId: routeId ?? this.routeId,
      name: name ?? this.name,
      qrCodeToken: qrCodeToken ?? this.qrCodeToken,
      sequenceOrder: sequenceOrder ?? this.sequenceOrder,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routeId.present) {
      map['route_id'] = Variable<String>(routeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (qrCodeToken.present) {
      map['qr_code_token'] = Variable<String>(qrCodeToken.value);
    }
    if (sequenceOrder.present) {
      map['sequence_order'] = Variable<int>(sequenceOrder.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutePointsLocalCompanion(')
          ..write('id: $id, ')
          ..write('routeId: $routeId, ')
          ..write('name: $name, ')
          ..write('qrCodeToken: $qrCodeToken, ')
          ..write('sequenceOrder: $sequenceOrder, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutePointVisitsLocalTable extends RoutePointVisitsLocal
    with TableInfo<$RoutePointVisitsLocalTable, RoutePointVisitsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutePointVisitsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointIdMeta = const VerificationMeta(
    'pointId',
  );
  @override
  late final GeneratedColumn<String> pointId = GeneratedColumn<String>(
    'point_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visitedAtMeta = const VerificationMeta(
    'visitedAt',
  );
  @override
  late final GeneratedColumn<DateTime> visitedAt = GeneratedColumn<DateTime>(
    'visited_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gpsLatMeta = const VerificationMeta('gpsLat');
  @override
  late final GeneratedColumn<double> gpsLat = GeneratedColumn<double>(
    'gps_lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gpsLonMeta = const VerificationMeta('gpsLon');
  @override
  late final GeneratedColumn<double> gpsLon = GeneratedColumn<double>(
    'gps_lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gpsAccuracyMeta = const VerificationMeta(
    'gpsAccuracy',
  );
  @override
  late final GeneratedColumn<double> gpsAccuracy = GeneratedColumn<double>(
    'gps_accuracy',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photosBeforeMeta = const VerificationMeta(
    'photosBefore',
  );
  @override
  late final GeneratedColumn<String> photosBefore = GeneratedColumn<String>(
    'photos_before',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photosAfterMeta = const VerificationMeta(
    'photosAfter',
  );
  @override
  late final GeneratedColumn<String> photosAfter = GeneratedColumn<String>(
    'photos_after',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formDataMeta = const VerificationMeta(
    'formData',
  );
  @override
  late final GeneratedColumn<String> formData = GeneratedColumn<String>(
    'form_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pointId,
    visitedAt,
    gpsLat,
    gpsLon,
    gpsAccuracy,
    photosBefore,
    photosAfter,
    formData,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'route_point_visits_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutePointVisitsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('point_id')) {
      context.handle(
        _pointIdMeta,
        pointId.isAcceptableOrUnknown(data['point_id']!, _pointIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pointIdMeta);
    }
    if (data.containsKey('visited_at')) {
      context.handle(
        _visitedAtMeta,
        visitedAt.isAcceptableOrUnknown(data['visited_at']!, _visitedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_visitedAtMeta);
    }
    if (data.containsKey('gps_lat')) {
      context.handle(
        _gpsLatMeta,
        gpsLat.isAcceptableOrUnknown(data['gps_lat']!, _gpsLatMeta),
      );
    } else if (isInserting) {
      context.missing(_gpsLatMeta);
    }
    if (data.containsKey('gps_lon')) {
      context.handle(
        _gpsLonMeta,
        gpsLon.isAcceptableOrUnknown(data['gps_lon']!, _gpsLonMeta),
      );
    } else if (isInserting) {
      context.missing(_gpsLonMeta);
    }
    if (data.containsKey('gps_accuracy')) {
      context.handle(
        _gpsAccuracyMeta,
        gpsAccuracy.isAcceptableOrUnknown(
          data['gps_accuracy']!,
          _gpsAccuracyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gpsAccuracyMeta);
    }
    if (data.containsKey('photos_before')) {
      context.handle(
        _photosBeforeMeta,
        photosBefore.isAcceptableOrUnknown(
          data['photos_before']!,
          _photosBeforeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_photosBeforeMeta);
    }
    if (data.containsKey('photos_after')) {
      context.handle(
        _photosAfterMeta,
        photosAfter.isAcceptableOrUnknown(
          data['photos_after']!,
          _photosAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_photosAfterMeta);
    }
    if (data.containsKey('form_data')) {
      context.handle(
        _formDataMeta,
        formData.isAcceptableOrUnknown(data['form_data']!, _formDataMeta),
      );
    } else if (isInserting) {
      context.missing(_formDataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutePointVisitsLocalData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutePointVisitsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}point_id'],
      )!,
      visitedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}visited_at'],
      )!,
      gpsLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_lat'],
      )!,
      gpsLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_lon'],
      )!,
      gpsAccuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_accuracy'],
      )!,
      photosBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photos_before'],
      )!,
      photosAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photos_after'],
      )!,
      formData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}form_data'],
      )!,
    );
  }

  @override
  $RoutePointVisitsLocalTable createAlias(String alias) {
    return $RoutePointVisitsLocalTable(attachedDatabase, alias);
  }
}

class RoutePointVisitsLocalData extends DataClass
    implements Insertable<RoutePointVisitsLocalData> {
  final String id;
  final String pointId;
  final DateTime visitedAt;
  final double gpsLat;
  final double gpsLon;
  final double gpsAccuracy;
  final String photosBefore;
  final String photosAfter;
  final String formData;
  const RoutePointVisitsLocalData({
    required this.id,
    required this.pointId,
    required this.visitedAt,
    required this.gpsLat,
    required this.gpsLon,
    required this.gpsAccuracy,
    required this.photosBefore,
    required this.photosAfter,
    required this.formData,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['point_id'] = Variable<String>(pointId);
    map['visited_at'] = Variable<DateTime>(visitedAt);
    map['gps_lat'] = Variable<double>(gpsLat);
    map['gps_lon'] = Variable<double>(gpsLon);
    map['gps_accuracy'] = Variable<double>(gpsAccuracy);
    map['photos_before'] = Variable<String>(photosBefore);
    map['photos_after'] = Variable<String>(photosAfter);
    map['form_data'] = Variable<String>(formData);
    return map;
  }

  RoutePointVisitsLocalCompanion toCompanion(bool nullToAbsent) {
    return RoutePointVisitsLocalCompanion(
      id: Value(id),
      pointId: Value(pointId),
      visitedAt: Value(visitedAt),
      gpsLat: Value(gpsLat),
      gpsLon: Value(gpsLon),
      gpsAccuracy: Value(gpsAccuracy),
      photosBefore: Value(photosBefore),
      photosAfter: Value(photosAfter),
      formData: Value(formData),
    );
  }

  factory RoutePointVisitsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutePointVisitsLocalData(
      id: serializer.fromJson<String>(json['id']),
      pointId: serializer.fromJson<String>(json['pointId']),
      visitedAt: serializer.fromJson<DateTime>(json['visitedAt']),
      gpsLat: serializer.fromJson<double>(json['gpsLat']),
      gpsLon: serializer.fromJson<double>(json['gpsLon']),
      gpsAccuracy: serializer.fromJson<double>(json['gpsAccuracy']),
      photosBefore: serializer.fromJson<String>(json['photosBefore']),
      photosAfter: serializer.fromJson<String>(json['photosAfter']),
      formData: serializer.fromJson<String>(json['formData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pointId': serializer.toJson<String>(pointId),
      'visitedAt': serializer.toJson<DateTime>(visitedAt),
      'gpsLat': serializer.toJson<double>(gpsLat),
      'gpsLon': serializer.toJson<double>(gpsLon),
      'gpsAccuracy': serializer.toJson<double>(gpsAccuracy),
      'photosBefore': serializer.toJson<String>(photosBefore),
      'photosAfter': serializer.toJson<String>(photosAfter),
      'formData': serializer.toJson<String>(formData),
    };
  }

  RoutePointVisitsLocalData copyWith({
    String? id,
    String? pointId,
    DateTime? visitedAt,
    double? gpsLat,
    double? gpsLon,
    double? gpsAccuracy,
    String? photosBefore,
    String? photosAfter,
    String? formData,
  }) => RoutePointVisitsLocalData(
    id: id ?? this.id,
    pointId: pointId ?? this.pointId,
    visitedAt: visitedAt ?? this.visitedAt,
    gpsLat: gpsLat ?? this.gpsLat,
    gpsLon: gpsLon ?? this.gpsLon,
    gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
    photosBefore: photosBefore ?? this.photosBefore,
    photosAfter: photosAfter ?? this.photosAfter,
    formData: formData ?? this.formData,
  );
  RoutePointVisitsLocalData copyWithCompanion(
    RoutePointVisitsLocalCompanion data,
  ) {
    return RoutePointVisitsLocalData(
      id: data.id.present ? data.id.value : this.id,
      pointId: data.pointId.present ? data.pointId.value : this.pointId,
      visitedAt: data.visitedAt.present ? data.visitedAt.value : this.visitedAt,
      gpsLat: data.gpsLat.present ? data.gpsLat.value : this.gpsLat,
      gpsLon: data.gpsLon.present ? data.gpsLon.value : this.gpsLon,
      gpsAccuracy: data.gpsAccuracy.present
          ? data.gpsAccuracy.value
          : this.gpsAccuracy,
      photosBefore: data.photosBefore.present
          ? data.photosBefore.value
          : this.photosBefore,
      photosAfter: data.photosAfter.present
          ? data.photosAfter.value
          : this.photosAfter,
      formData: data.formData.present ? data.formData.value : this.formData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutePointVisitsLocalData(')
          ..write('id: $id, ')
          ..write('pointId: $pointId, ')
          ..write('visitedAt: $visitedAt, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLon: $gpsLon, ')
          ..write('gpsAccuracy: $gpsAccuracy, ')
          ..write('photosBefore: $photosBefore, ')
          ..write('photosAfter: $photosAfter, ')
          ..write('formData: $formData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pointId,
    visitedAt,
    gpsLat,
    gpsLon,
    gpsAccuracy,
    photosBefore,
    photosAfter,
    formData,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutePointVisitsLocalData &&
          other.id == this.id &&
          other.pointId == this.pointId &&
          other.visitedAt == this.visitedAt &&
          other.gpsLat == this.gpsLat &&
          other.gpsLon == this.gpsLon &&
          other.gpsAccuracy == this.gpsAccuracy &&
          other.photosBefore == this.photosBefore &&
          other.photosAfter == this.photosAfter &&
          other.formData == this.formData);
}

class RoutePointVisitsLocalCompanion
    extends UpdateCompanion<RoutePointVisitsLocalData> {
  final Value<String> id;
  final Value<String> pointId;
  final Value<DateTime> visitedAt;
  final Value<double> gpsLat;
  final Value<double> gpsLon;
  final Value<double> gpsAccuracy;
  final Value<String> photosBefore;
  final Value<String> photosAfter;
  final Value<String> formData;
  final Value<int> rowid;
  const RoutePointVisitsLocalCompanion({
    this.id = const Value.absent(),
    this.pointId = const Value.absent(),
    this.visitedAt = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLon = const Value.absent(),
    this.gpsAccuracy = const Value.absent(),
    this.photosBefore = const Value.absent(),
    this.photosAfter = const Value.absent(),
    this.formData = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutePointVisitsLocalCompanion.insert({
    required String id,
    required String pointId,
    required DateTime visitedAt,
    required double gpsLat,
    required double gpsLon,
    required double gpsAccuracy,
    required String photosBefore,
    required String photosAfter,
    required String formData,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pointId = Value(pointId),
       visitedAt = Value(visitedAt),
       gpsLat = Value(gpsLat),
       gpsLon = Value(gpsLon),
       gpsAccuracy = Value(gpsAccuracy),
       photosBefore = Value(photosBefore),
       photosAfter = Value(photosAfter),
       formData = Value(formData);
  static Insertable<RoutePointVisitsLocalData> custom({
    Expression<String>? id,
    Expression<String>? pointId,
    Expression<DateTime>? visitedAt,
    Expression<double>? gpsLat,
    Expression<double>? gpsLon,
    Expression<double>? gpsAccuracy,
    Expression<String>? photosBefore,
    Expression<String>? photosAfter,
    Expression<String>? formData,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pointId != null) 'point_id': pointId,
      if (visitedAt != null) 'visited_at': visitedAt,
      if (gpsLat != null) 'gps_lat': gpsLat,
      if (gpsLon != null) 'gps_lon': gpsLon,
      if (gpsAccuracy != null) 'gps_accuracy': gpsAccuracy,
      if (photosBefore != null) 'photos_before': photosBefore,
      if (photosAfter != null) 'photos_after': photosAfter,
      if (formData != null) 'form_data': formData,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutePointVisitsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? pointId,
    Value<DateTime>? visitedAt,
    Value<double>? gpsLat,
    Value<double>? gpsLon,
    Value<double>? gpsAccuracy,
    Value<String>? photosBefore,
    Value<String>? photosAfter,
    Value<String>? formData,
    Value<int>? rowid,
  }) {
    return RoutePointVisitsLocalCompanion(
      id: id ?? this.id,
      pointId: pointId ?? this.pointId,
      visitedAt: visitedAt ?? this.visitedAt,
      gpsLat: gpsLat ?? this.gpsLat,
      gpsLon: gpsLon ?? this.gpsLon,
      gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
      photosBefore: photosBefore ?? this.photosBefore,
      photosAfter: photosAfter ?? this.photosAfter,
      formData: formData ?? this.formData,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pointId.present) {
      map['point_id'] = Variable<String>(pointId.value);
    }
    if (visitedAt.present) {
      map['visited_at'] = Variable<DateTime>(visitedAt.value);
    }
    if (gpsLat.present) {
      map['gps_lat'] = Variable<double>(gpsLat.value);
    }
    if (gpsLon.present) {
      map['gps_lon'] = Variable<double>(gpsLon.value);
    }
    if (gpsAccuracy.present) {
      map['gps_accuracy'] = Variable<double>(gpsAccuracy.value);
    }
    if (photosBefore.present) {
      map['photos_before'] = Variable<String>(photosBefore.value);
    }
    if (photosAfter.present) {
      map['photos_after'] = Variable<String>(photosAfter.value);
    }
    if (formData.present) {
      map['form_data'] = Variable<String>(formData.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutePointVisitsLocalCompanion(')
          ..write('id: $id, ')
          ..write('pointId: $pointId, ')
          ..write('visitedAt: $visitedAt, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLon: $gpsLon, ')
          ..write('gpsAccuracy: $gpsAccuracy, ')
          ..write('photosBefore: $photosBefore, ')
          ..write('photosAfter: $photosAfter, ')
          ..write('formData: $formData, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistSubmissionsLocalTable extends ChecklistSubmissionsLocal
    with
        TableInfo<
          $ChecklistSubmissionsLocalTable,
          ChecklistSubmissionsLocalData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistSubmissionsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checklistIdMeta = const VerificationMeta(
    'checklistId',
  );
  @override
  late final GeneratedColumn<String> checklistId = GeneratedColumn<String>(
    'checklist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _routeIdMeta = const VerificationMeta(
    'routeId',
  );
  @override
  late final GeneratedColumn<String> routeId = GeneratedColumn<String>(
    'route_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _submittedAtMeta = const VerificationMeta(
    'submittedAt',
  );
  @override
  late final GeneratedColumn<DateTime> submittedAt = GeneratedColumn<DateTime>(
    'submitted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gpsLatMeta = const VerificationMeta('gpsLat');
  @override
  late final GeneratedColumn<double> gpsLat = GeneratedColumn<double>(
    'gps_lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gpsLonMeta = const VerificationMeta('gpsLon');
  @override
  late final GeneratedColumn<double> gpsLon = GeneratedColumn<double>(
    'gps_lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gpsAccuracyMeta = const VerificationMeta(
    'gpsAccuracy',
  );
  @override
  late final GeneratedColumn<double> gpsAccuracy = GeneratedColumn<double>(
    'gps_accuracy',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checklistId,
    vehicleId,
    routeId,
    submittedAt,
    gpsLat,
    gpsLon,
    gpsAccuracy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_submissions_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistSubmissionsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('checklist_id')) {
      context.handle(
        _checklistIdMeta,
        checklistId.isAcceptableOrUnknown(
          data['checklist_id']!,
          _checklistIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checklistIdMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    }
    if (data.containsKey('route_id')) {
      context.handle(
        _routeIdMeta,
        routeId.isAcceptableOrUnknown(data['route_id']!, _routeIdMeta),
      );
    }
    if (data.containsKey('submitted_at')) {
      context.handle(
        _submittedAtMeta,
        submittedAt.isAcceptableOrUnknown(
          data['submitted_at']!,
          _submittedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_submittedAtMeta);
    }
    if (data.containsKey('gps_lat')) {
      context.handle(
        _gpsLatMeta,
        gpsLat.isAcceptableOrUnknown(data['gps_lat']!, _gpsLatMeta),
      );
    } else if (isInserting) {
      context.missing(_gpsLatMeta);
    }
    if (data.containsKey('gps_lon')) {
      context.handle(
        _gpsLonMeta,
        gpsLon.isAcceptableOrUnknown(data['gps_lon']!, _gpsLonMeta),
      );
    } else if (isInserting) {
      context.missing(_gpsLonMeta);
    }
    if (data.containsKey('gps_accuracy')) {
      context.handle(
        _gpsAccuracyMeta,
        gpsAccuracy.isAcceptableOrUnknown(
          data['gps_accuracy']!,
          _gpsAccuracyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gpsAccuracyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistSubmissionsLocalData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistSubmissionsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checklistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checklist_id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      ),
      routeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route_id'],
      ),
      submittedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}submitted_at'],
      )!,
      gpsLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_lat'],
      )!,
      gpsLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_lon'],
      )!,
      gpsAccuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_accuracy'],
      )!,
    );
  }

  @override
  $ChecklistSubmissionsLocalTable createAlias(String alias) {
    return $ChecklistSubmissionsLocalTable(attachedDatabase, alias);
  }
}

class ChecklistSubmissionsLocalData extends DataClass
    implements Insertable<ChecklistSubmissionsLocalData> {
  final String id;
  final String checklistId;
  final String? vehicleId;
  final String? routeId;
  final DateTime submittedAt;
  final double gpsLat;
  final double gpsLon;
  final double gpsAccuracy;
  const ChecklistSubmissionsLocalData({
    required this.id,
    required this.checklistId,
    this.vehicleId,
    this.routeId,
    required this.submittedAt,
    required this.gpsLat,
    required this.gpsLon,
    required this.gpsAccuracy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['checklist_id'] = Variable<String>(checklistId);
    if (!nullToAbsent || vehicleId != null) {
      map['vehicle_id'] = Variable<String>(vehicleId);
    }
    if (!nullToAbsent || routeId != null) {
      map['route_id'] = Variable<String>(routeId);
    }
    map['submitted_at'] = Variable<DateTime>(submittedAt);
    map['gps_lat'] = Variable<double>(gpsLat);
    map['gps_lon'] = Variable<double>(gpsLon);
    map['gps_accuracy'] = Variable<double>(gpsAccuracy);
    return map;
  }

  ChecklistSubmissionsLocalCompanion toCompanion(bool nullToAbsent) {
    return ChecklistSubmissionsLocalCompanion(
      id: Value(id),
      checklistId: Value(checklistId),
      vehicleId: vehicleId == null && nullToAbsent
          ? const Value.absent()
          : Value(vehicleId),
      routeId: routeId == null && nullToAbsent
          ? const Value.absent()
          : Value(routeId),
      submittedAt: Value(submittedAt),
      gpsLat: Value(gpsLat),
      gpsLon: Value(gpsLon),
      gpsAccuracy: Value(gpsAccuracy),
    );
  }

  factory ChecklistSubmissionsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistSubmissionsLocalData(
      id: serializer.fromJson<String>(json['id']),
      checklistId: serializer.fromJson<String>(json['checklistId']),
      vehicleId: serializer.fromJson<String?>(json['vehicleId']),
      routeId: serializer.fromJson<String?>(json['routeId']),
      submittedAt: serializer.fromJson<DateTime>(json['submittedAt']),
      gpsLat: serializer.fromJson<double>(json['gpsLat']),
      gpsLon: serializer.fromJson<double>(json['gpsLon']),
      gpsAccuracy: serializer.fromJson<double>(json['gpsAccuracy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checklistId': serializer.toJson<String>(checklistId),
      'vehicleId': serializer.toJson<String?>(vehicleId),
      'routeId': serializer.toJson<String?>(routeId),
      'submittedAt': serializer.toJson<DateTime>(submittedAt),
      'gpsLat': serializer.toJson<double>(gpsLat),
      'gpsLon': serializer.toJson<double>(gpsLon),
      'gpsAccuracy': serializer.toJson<double>(gpsAccuracy),
    };
  }

  ChecklistSubmissionsLocalData copyWith({
    String? id,
    String? checklistId,
    Value<String?> vehicleId = const Value.absent(),
    Value<String?> routeId = const Value.absent(),
    DateTime? submittedAt,
    double? gpsLat,
    double? gpsLon,
    double? gpsAccuracy,
  }) => ChecklistSubmissionsLocalData(
    id: id ?? this.id,
    checklistId: checklistId ?? this.checklistId,
    vehicleId: vehicleId.present ? vehicleId.value : this.vehicleId,
    routeId: routeId.present ? routeId.value : this.routeId,
    submittedAt: submittedAt ?? this.submittedAt,
    gpsLat: gpsLat ?? this.gpsLat,
    gpsLon: gpsLon ?? this.gpsLon,
    gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
  );
  ChecklistSubmissionsLocalData copyWithCompanion(
    ChecklistSubmissionsLocalCompanion data,
  ) {
    return ChecklistSubmissionsLocalData(
      id: data.id.present ? data.id.value : this.id,
      checklistId: data.checklistId.present
          ? data.checklistId.value
          : this.checklistId,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      routeId: data.routeId.present ? data.routeId.value : this.routeId,
      submittedAt: data.submittedAt.present
          ? data.submittedAt.value
          : this.submittedAt,
      gpsLat: data.gpsLat.present ? data.gpsLat.value : this.gpsLat,
      gpsLon: data.gpsLon.present ? data.gpsLon.value : this.gpsLon,
      gpsAccuracy: data.gpsAccuracy.present
          ? data.gpsAccuracy.value
          : this.gpsAccuracy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistSubmissionsLocalData(')
          ..write('id: $id, ')
          ..write('checklistId: $checklistId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('routeId: $routeId, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLon: $gpsLon, ')
          ..write('gpsAccuracy: $gpsAccuracy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checklistId,
    vehicleId,
    routeId,
    submittedAt,
    gpsLat,
    gpsLon,
    gpsAccuracy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistSubmissionsLocalData &&
          other.id == this.id &&
          other.checklistId == this.checklistId &&
          other.vehicleId == this.vehicleId &&
          other.routeId == this.routeId &&
          other.submittedAt == this.submittedAt &&
          other.gpsLat == this.gpsLat &&
          other.gpsLon == this.gpsLon &&
          other.gpsAccuracy == this.gpsAccuracy);
}

class ChecklistSubmissionsLocalCompanion
    extends UpdateCompanion<ChecklistSubmissionsLocalData> {
  final Value<String> id;
  final Value<String> checklistId;
  final Value<String?> vehicleId;
  final Value<String?> routeId;
  final Value<DateTime> submittedAt;
  final Value<double> gpsLat;
  final Value<double> gpsLon;
  final Value<double> gpsAccuracy;
  final Value<int> rowid;
  const ChecklistSubmissionsLocalCompanion({
    this.id = const Value.absent(),
    this.checklistId = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.routeId = const Value.absent(),
    this.submittedAt = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLon = const Value.absent(),
    this.gpsAccuracy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistSubmissionsLocalCompanion.insert({
    required String id,
    required String checklistId,
    this.vehicleId = const Value.absent(),
    this.routeId = const Value.absent(),
    required DateTime submittedAt,
    required double gpsLat,
    required double gpsLon,
    required double gpsAccuracy,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checklistId = Value(checklistId),
       submittedAt = Value(submittedAt),
       gpsLat = Value(gpsLat),
       gpsLon = Value(gpsLon),
       gpsAccuracy = Value(gpsAccuracy);
  static Insertable<ChecklistSubmissionsLocalData> custom({
    Expression<String>? id,
    Expression<String>? checklistId,
    Expression<String>? vehicleId,
    Expression<String>? routeId,
    Expression<DateTime>? submittedAt,
    Expression<double>? gpsLat,
    Expression<double>? gpsLon,
    Expression<double>? gpsAccuracy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checklistId != null) 'checklist_id': checklistId,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (routeId != null) 'route_id': routeId,
      if (submittedAt != null) 'submitted_at': submittedAt,
      if (gpsLat != null) 'gps_lat': gpsLat,
      if (gpsLon != null) 'gps_lon': gpsLon,
      if (gpsAccuracy != null) 'gps_accuracy': gpsAccuracy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistSubmissionsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? checklistId,
    Value<String?>? vehicleId,
    Value<String?>? routeId,
    Value<DateTime>? submittedAt,
    Value<double>? gpsLat,
    Value<double>? gpsLon,
    Value<double>? gpsAccuracy,
    Value<int>? rowid,
  }) {
    return ChecklistSubmissionsLocalCompanion(
      id: id ?? this.id,
      checklistId: checklistId ?? this.checklistId,
      vehicleId: vehicleId ?? this.vehicleId,
      routeId: routeId ?? this.routeId,
      submittedAt: submittedAt ?? this.submittedAt,
      gpsLat: gpsLat ?? this.gpsLat,
      gpsLon: gpsLon ?? this.gpsLon,
      gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checklistId.present) {
      map['checklist_id'] = Variable<String>(checklistId.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (routeId.present) {
      map['route_id'] = Variable<String>(routeId.value);
    }
    if (submittedAt.present) {
      map['submitted_at'] = Variable<DateTime>(submittedAt.value);
    }
    if (gpsLat.present) {
      map['gps_lat'] = Variable<double>(gpsLat.value);
    }
    if (gpsLon.present) {
      map['gps_lon'] = Variable<double>(gpsLon.value);
    }
    if (gpsAccuracy.present) {
      map['gps_accuracy'] = Variable<double>(gpsAccuracy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistSubmissionsLocalCompanion(')
          ..write('id: $id, ')
          ..write('checklistId: $checklistId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('routeId: $routeId, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLon: $gpsLon, ')
          ..write('gpsAccuracy: $gpsAccuracy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistAnswersLocalTable extends ChecklistAnswersLocal
    with TableInfo<$ChecklistAnswersLocalTable, ChecklistAnswersLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistAnswersLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _submissionIdMeta = const VerificationMeta(
    'submissionId',
  );
  @override
  late final GeneratedColumn<String> submissionId = GeneratedColumn<String>(
    'submission_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerValueMeta = const VerificationMeta(
    'answerValue',
  );
  @override
  late final GeneratedColumn<String> answerValue = GeneratedColumn<String>(
    'answer_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signatureUrlMeta = const VerificationMeta(
    'signatureUrl',
  );
  @override
  late final GeneratedColumn<String> signatureUrl = GeneratedColumn<String>(
    'signature_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFailedCriticalMeta = const VerificationMeta(
    'isFailedCritical',
  );
  @override
  late final GeneratedColumn<bool> isFailedCritical = GeneratedColumn<bool>(
    'is_failed_critical',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_failed_critical" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    submissionId,
    questionId,
    answerValue,
    photoUrl,
    signatureUrl,
    isFailedCritical,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_answers_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistAnswersLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('submission_id')) {
      context.handle(
        _submissionIdMeta,
        submissionId.isAcceptableOrUnknown(
          data['submission_id']!,
          _submissionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_submissionIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('answer_value')) {
      context.handle(
        _answerValueMeta,
        answerValue.isAcceptableOrUnknown(
          data['answer_value']!,
          _answerValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answerValueMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('signature_url')) {
      context.handle(
        _signatureUrlMeta,
        signatureUrl.isAcceptableOrUnknown(
          data['signature_url']!,
          _signatureUrlMeta,
        ),
      );
    }
    if (data.containsKey('is_failed_critical')) {
      context.handle(
        _isFailedCriticalMeta,
        isFailedCritical.isAcceptableOrUnknown(
          data['is_failed_critical']!,
          _isFailedCriticalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistAnswersLocalData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistAnswersLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      submissionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}submission_id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      answerValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer_value'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      signatureUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signature_url'],
      ),
      isFailedCritical: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_failed_critical'],
      )!,
    );
  }

  @override
  $ChecklistAnswersLocalTable createAlias(String alias) {
    return $ChecklistAnswersLocalTable(attachedDatabase, alias);
  }
}

class ChecklistAnswersLocalData extends DataClass
    implements Insertable<ChecklistAnswersLocalData> {
  final String id;
  final String submissionId;
  final String questionId;
  final String answerValue;
  final String? photoUrl;
  final String? signatureUrl;
  final bool isFailedCritical;
  const ChecklistAnswersLocalData({
    required this.id,
    required this.submissionId,
    required this.questionId,
    required this.answerValue,
    this.photoUrl,
    this.signatureUrl,
    required this.isFailedCritical,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['submission_id'] = Variable<String>(submissionId);
    map['question_id'] = Variable<String>(questionId);
    map['answer_value'] = Variable<String>(answerValue);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || signatureUrl != null) {
      map['signature_url'] = Variable<String>(signatureUrl);
    }
    map['is_failed_critical'] = Variable<bool>(isFailedCritical);
    return map;
  }

  ChecklistAnswersLocalCompanion toCompanion(bool nullToAbsent) {
    return ChecklistAnswersLocalCompanion(
      id: Value(id),
      submissionId: Value(submissionId),
      questionId: Value(questionId),
      answerValue: Value(answerValue),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      signatureUrl: signatureUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(signatureUrl),
      isFailedCritical: Value(isFailedCritical),
    );
  }

  factory ChecklistAnswersLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistAnswersLocalData(
      id: serializer.fromJson<String>(json['id']),
      submissionId: serializer.fromJson<String>(json['submissionId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      answerValue: serializer.fromJson<String>(json['answerValue']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      signatureUrl: serializer.fromJson<String?>(json['signatureUrl']),
      isFailedCritical: serializer.fromJson<bool>(json['isFailedCritical']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'submissionId': serializer.toJson<String>(submissionId),
      'questionId': serializer.toJson<String>(questionId),
      'answerValue': serializer.toJson<String>(answerValue),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'signatureUrl': serializer.toJson<String?>(signatureUrl),
      'isFailedCritical': serializer.toJson<bool>(isFailedCritical),
    };
  }

  ChecklistAnswersLocalData copyWith({
    String? id,
    String? submissionId,
    String? questionId,
    String? answerValue,
    Value<String?> photoUrl = const Value.absent(),
    Value<String?> signatureUrl = const Value.absent(),
    bool? isFailedCritical,
  }) => ChecklistAnswersLocalData(
    id: id ?? this.id,
    submissionId: submissionId ?? this.submissionId,
    questionId: questionId ?? this.questionId,
    answerValue: answerValue ?? this.answerValue,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    signatureUrl: signatureUrl.present ? signatureUrl.value : this.signatureUrl,
    isFailedCritical: isFailedCritical ?? this.isFailedCritical,
  );
  ChecklistAnswersLocalData copyWithCompanion(
    ChecklistAnswersLocalCompanion data,
  ) {
    return ChecklistAnswersLocalData(
      id: data.id.present ? data.id.value : this.id,
      submissionId: data.submissionId.present
          ? data.submissionId.value
          : this.submissionId,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      answerValue: data.answerValue.present
          ? data.answerValue.value
          : this.answerValue,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      signatureUrl: data.signatureUrl.present
          ? data.signatureUrl.value
          : this.signatureUrl,
      isFailedCritical: data.isFailedCritical.present
          ? data.isFailedCritical.value
          : this.isFailedCritical,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistAnswersLocalData(')
          ..write('id: $id, ')
          ..write('submissionId: $submissionId, ')
          ..write('questionId: $questionId, ')
          ..write('answerValue: $answerValue, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('signatureUrl: $signatureUrl, ')
          ..write('isFailedCritical: $isFailedCritical')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    submissionId,
    questionId,
    answerValue,
    photoUrl,
    signatureUrl,
    isFailedCritical,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistAnswersLocalData &&
          other.id == this.id &&
          other.submissionId == this.submissionId &&
          other.questionId == this.questionId &&
          other.answerValue == this.answerValue &&
          other.photoUrl == this.photoUrl &&
          other.signatureUrl == this.signatureUrl &&
          other.isFailedCritical == this.isFailedCritical);
}

class ChecklistAnswersLocalCompanion
    extends UpdateCompanion<ChecklistAnswersLocalData> {
  final Value<String> id;
  final Value<String> submissionId;
  final Value<String> questionId;
  final Value<String> answerValue;
  final Value<String?> photoUrl;
  final Value<String?> signatureUrl;
  final Value<bool> isFailedCritical;
  final Value<int> rowid;
  const ChecklistAnswersLocalCompanion({
    this.id = const Value.absent(),
    this.submissionId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.answerValue = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.signatureUrl = const Value.absent(),
    this.isFailedCritical = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistAnswersLocalCompanion.insert({
    required String id,
    required String submissionId,
    required String questionId,
    required String answerValue,
    this.photoUrl = const Value.absent(),
    this.signatureUrl = const Value.absent(),
    this.isFailedCritical = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       submissionId = Value(submissionId),
       questionId = Value(questionId),
       answerValue = Value(answerValue);
  static Insertable<ChecklistAnswersLocalData> custom({
    Expression<String>? id,
    Expression<String>? submissionId,
    Expression<String>? questionId,
    Expression<String>? answerValue,
    Expression<String>? photoUrl,
    Expression<String>? signatureUrl,
    Expression<bool>? isFailedCritical,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (submissionId != null) 'submission_id': submissionId,
      if (questionId != null) 'question_id': questionId,
      if (answerValue != null) 'answer_value': answerValue,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (signatureUrl != null) 'signature_url': signatureUrl,
      if (isFailedCritical != null) 'is_failed_critical': isFailedCritical,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistAnswersLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? submissionId,
    Value<String>? questionId,
    Value<String>? answerValue,
    Value<String?>? photoUrl,
    Value<String?>? signatureUrl,
    Value<bool>? isFailedCritical,
    Value<int>? rowid,
  }) {
    return ChecklistAnswersLocalCompanion(
      id: id ?? this.id,
      submissionId: submissionId ?? this.submissionId,
      questionId: questionId ?? this.questionId,
      answerValue: answerValue ?? this.answerValue,
      photoUrl: photoUrl ?? this.photoUrl,
      signatureUrl: signatureUrl ?? this.signatureUrl,
      isFailedCritical: isFailedCritical ?? this.isFailedCritical,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (submissionId.present) {
      map['submission_id'] = Variable<String>(submissionId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (answerValue.present) {
      map['answer_value'] = Variable<String>(answerValue.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (signatureUrl.present) {
      map['signature_url'] = Variable<String>(signatureUrl.value);
    }
    if (isFailedCritical.present) {
      map['is_failed_critical'] = Variable<bool>(isFailedCritical.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistAnswersLocalCompanion(')
          ..write('id: $id, ')
          ..write('submissionId: $submissionId, ')
          ..write('questionId: $questionId, ')
          ..write('answerValue: $answerValue, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('signatureUrl: $signatureUrl, ')
          ..write('isFailedCritical: $isFailedCritical, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsLocalTable extends AuditLogsLocal
    with TableInfo<$AuditLogsLocalTable, AuditLogsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deviceInfoMeta = const VerificationMeta(
    'deviceInfo',
  );
  @override
  late final GeneratedColumn<String> deviceInfo = GeneratedColumn<String>(
    'device_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gpsLatMeta = const VerificationMeta('gpsLat');
  @override
  late final GeneratedColumn<double> gpsLat = GeneratedColumn<double>(
    'gps_lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gpsLonMeta = const VerificationMeta('gpsLon');
  @override
  late final GeneratedColumn<double> gpsLon = GeneratedColumn<double>(
    'gps_lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    timestamp,
    deviceInfo,
    gpsLat,
    gpsLon,
    payload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('device_info')) {
      context.handle(
        _deviceInfoMeta,
        deviceInfo.isAcceptableOrUnknown(data['device_info']!, _deviceInfoMeta),
      );
    }
    if (data.containsKey('gps_lat')) {
      context.handle(
        _gpsLatMeta,
        gpsLat.isAcceptableOrUnknown(data['gps_lat']!, _gpsLatMeta),
      );
    }
    if (data.containsKey('gps_lon')) {
      context.handle(
        _gpsLonMeta,
        gpsLon.isAcceptableOrUnknown(data['gps_lon']!, _gpsLonMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      deviceInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_info'],
      ),
      gpsLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_lat'],
      ),
      gpsLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gps_lon'],
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
    );
  }

  @override
  $AuditLogsLocalTable createAlias(String alias) {
    return $AuditLogsLocalTable(attachedDatabase, alias);
  }
}

class AuditLogsLocalData extends DataClass
    implements Insertable<AuditLogsLocalData> {
  final String id;
  final String action;
  final DateTime timestamp;
  final String? deviceInfo;
  final double? gpsLat;
  final double? gpsLon;
  final String payload;
  const AuditLogsLocalData({
    required this.id,
    required this.action,
    required this.timestamp,
    this.deviceInfo,
    this.gpsLat,
    this.gpsLon,
    required this.payload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['action'] = Variable<String>(action);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || deviceInfo != null) {
      map['device_info'] = Variable<String>(deviceInfo);
    }
    if (!nullToAbsent || gpsLat != null) {
      map['gps_lat'] = Variable<double>(gpsLat);
    }
    if (!nullToAbsent || gpsLon != null) {
      map['gps_lon'] = Variable<double>(gpsLon);
    }
    map['payload'] = Variable<String>(payload);
    return map;
  }

  AuditLogsLocalCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsLocalCompanion(
      id: Value(id),
      action: Value(action),
      timestamp: Value(timestamp),
      deviceInfo: deviceInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceInfo),
      gpsLat: gpsLat == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLat),
      gpsLon: gpsLon == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLon),
      payload: Value(payload),
    );
  }

  factory AuditLogsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogsLocalData(
      id: serializer.fromJson<String>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      deviceInfo: serializer.fromJson<String?>(json['deviceInfo']),
      gpsLat: serializer.fromJson<double?>(json['gpsLat']),
      gpsLon: serializer.fromJson<double?>(json['gpsLon']),
      payload: serializer.fromJson<String>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'action': serializer.toJson<String>(action),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'deviceInfo': serializer.toJson<String?>(deviceInfo),
      'gpsLat': serializer.toJson<double?>(gpsLat),
      'gpsLon': serializer.toJson<double?>(gpsLon),
      'payload': serializer.toJson<String>(payload),
    };
  }

  AuditLogsLocalData copyWith({
    String? id,
    String? action,
    DateTime? timestamp,
    Value<String?> deviceInfo = const Value.absent(),
    Value<double?> gpsLat = const Value.absent(),
    Value<double?> gpsLon = const Value.absent(),
    String? payload,
  }) => AuditLogsLocalData(
    id: id ?? this.id,
    action: action ?? this.action,
    timestamp: timestamp ?? this.timestamp,
    deviceInfo: deviceInfo.present ? deviceInfo.value : this.deviceInfo,
    gpsLat: gpsLat.present ? gpsLat.value : this.gpsLat,
    gpsLon: gpsLon.present ? gpsLon.value : this.gpsLon,
    payload: payload ?? this.payload,
  );
  AuditLogsLocalData copyWithCompanion(AuditLogsLocalCompanion data) {
    return AuditLogsLocalData(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      deviceInfo: data.deviceInfo.present
          ? data.deviceInfo.value
          : this.deviceInfo,
      gpsLat: data.gpsLat.present ? data.gpsLat.value : this.gpsLat,
      gpsLon: data.gpsLon.present ? data.gpsLon.value : this.gpsLon,
      payload: data.payload.present ? data.payload.value : this.payload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsLocalData(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('timestamp: $timestamp, ')
          ..write('deviceInfo: $deviceInfo, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLon: $gpsLon, ')
          ..write('payload: $payload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, action, timestamp, deviceInfo, gpsLat, gpsLon, payload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogsLocalData &&
          other.id == this.id &&
          other.action == this.action &&
          other.timestamp == this.timestamp &&
          other.deviceInfo == this.deviceInfo &&
          other.gpsLat == this.gpsLat &&
          other.gpsLon == this.gpsLon &&
          other.payload == this.payload);
}

class AuditLogsLocalCompanion extends UpdateCompanion<AuditLogsLocalData> {
  final Value<String> id;
  final Value<String> action;
  final Value<DateTime> timestamp;
  final Value<String?> deviceInfo;
  final Value<double?> gpsLat;
  final Value<double?> gpsLon;
  final Value<String> payload;
  final Value<int> rowid;
  const AuditLogsLocalCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.deviceInfo = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLon = const Value.absent(),
    this.payload = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogsLocalCompanion.insert({
    required String id,
    required String action,
    this.timestamp = const Value.absent(),
    this.deviceInfo = const Value.absent(),
    this.gpsLat = const Value.absent(),
    this.gpsLon = const Value.absent(),
    required String payload,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       action = Value(action),
       payload = Value(payload);
  static Insertable<AuditLogsLocalData> custom({
    Expression<String>? id,
    Expression<String>? action,
    Expression<DateTime>? timestamp,
    Expression<String>? deviceInfo,
    Expression<double>? gpsLat,
    Expression<double>? gpsLon,
    Expression<String>? payload,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (timestamp != null) 'timestamp': timestamp,
      if (deviceInfo != null) 'device_info': deviceInfo,
      if (gpsLat != null) 'gps_lat': gpsLat,
      if (gpsLon != null) 'gps_lon': gpsLon,
      if (payload != null) 'payload': payload,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? action,
    Value<DateTime>? timestamp,
    Value<String?>? deviceInfo,
    Value<double?>? gpsLat,
    Value<double?>? gpsLon,
    Value<String>? payload,
    Value<int>? rowid,
  }) {
    return AuditLogsLocalCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      gpsLat: gpsLat ?? this.gpsLat,
      gpsLon: gpsLon ?? this.gpsLon,
      payload: payload ?? this.payload,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (deviceInfo.present) {
      map['device_info'] = Variable<String>(deviceInfo.value);
    }
    if (gpsLat.present) {
      map['gps_lat'] = Variable<double>(gpsLat.value);
    }
    if (gpsLon.present) {
      map['gps_lon'] = Variable<double>(gpsLon.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsLocalCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('timestamp: $timestamp, ')
          ..write('deviceInfo: $deviceInfo, ')
          ..write('gpsLat: $gpsLat, ')
          ..write('gpsLon: $gpsLon, ')
          ..write('payload: $payload, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkerDocumentsLocalTable extends WorkerDocumentsLocal
    with TableInfo<$WorkerDocumentsLocalTable, WorkerDocumentsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkerDocumentsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emissionDateMeta = const VerificationMeta(
    'emissionDate',
  );
  @override
  late final GeneratedColumn<String> emissionDate = GeneratedColumn<String>(
    'emission_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<String> expiryDate = GeneratedColumn<String>(
    'expiry_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileUrlMeta = const VerificationMeta(
    'fileUrl',
  );
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
    'file_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    documentType,
    emissionDate,
    expiryDate,
    fileUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'worker_documents_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkerDocumentsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTypeMeta);
    }
    if (data.containsKey('emission_date')) {
      context.handle(
        _emissionDateMeta,
        emissionDate.isAcceptableOrUnknown(
          data['emission_date']!,
          _emissionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emissionDateMeta);
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expiryDateMeta);
    }
    if (data.containsKey('file_url')) {
      context.handle(
        _fileUrlMeta,
        fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkerDocumentsLocalData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkerDocumentsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      )!,
      emissionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emission_date'],
      )!,
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expiry_date'],
      )!,
      fileUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_url'],
      ),
    );
  }

  @override
  $WorkerDocumentsLocalTable createAlias(String alias) {
    return $WorkerDocumentsLocalTable(attachedDatabase, alias);
  }
}

class WorkerDocumentsLocalData extends DataClass
    implements Insertable<WorkerDocumentsLocalData> {
  final String id;
  final String documentType;
  final String emissionDate;
  final String expiryDate;
  final String? fileUrl;
  const WorkerDocumentsLocalData({
    required this.id,
    required this.documentType,
    required this.emissionDate,
    required this.expiryDate,
    this.fileUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['document_type'] = Variable<String>(documentType);
    map['emission_date'] = Variable<String>(emissionDate);
    map['expiry_date'] = Variable<String>(expiryDate);
    if (!nullToAbsent || fileUrl != null) {
      map['file_url'] = Variable<String>(fileUrl);
    }
    return map;
  }

  WorkerDocumentsLocalCompanion toCompanion(bool nullToAbsent) {
    return WorkerDocumentsLocalCompanion(
      id: Value(id),
      documentType: Value(documentType),
      emissionDate: Value(emissionDate),
      expiryDate: Value(expiryDate),
      fileUrl: fileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUrl),
    );
  }

  factory WorkerDocumentsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkerDocumentsLocalData(
      id: serializer.fromJson<String>(json['id']),
      documentType: serializer.fromJson<String>(json['documentType']),
      emissionDate: serializer.fromJson<String>(json['emissionDate']),
      expiryDate: serializer.fromJson<String>(json['expiryDate']),
      fileUrl: serializer.fromJson<String?>(json['fileUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'documentType': serializer.toJson<String>(documentType),
      'emissionDate': serializer.toJson<String>(emissionDate),
      'expiryDate': serializer.toJson<String>(expiryDate),
      'fileUrl': serializer.toJson<String?>(fileUrl),
    };
  }

  WorkerDocumentsLocalData copyWith({
    String? id,
    String? documentType,
    String? emissionDate,
    String? expiryDate,
    Value<String?> fileUrl = const Value.absent(),
  }) => WorkerDocumentsLocalData(
    id: id ?? this.id,
    documentType: documentType ?? this.documentType,
    emissionDate: emissionDate ?? this.emissionDate,
    expiryDate: expiryDate ?? this.expiryDate,
    fileUrl: fileUrl.present ? fileUrl.value : this.fileUrl,
  );
  WorkerDocumentsLocalData copyWithCompanion(
    WorkerDocumentsLocalCompanion data,
  ) {
    return WorkerDocumentsLocalData(
      id: data.id.present ? data.id.value : this.id,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      emissionDate: data.emissionDate.present
          ? data.emissionDate.value
          : this.emissionDate,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkerDocumentsLocalData(')
          ..write('id: $id, ')
          ..write('documentType: $documentType, ')
          ..write('emissionDate: $emissionDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('fileUrl: $fileUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, documentType, emissionDate, expiryDate, fileUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkerDocumentsLocalData &&
          other.id == this.id &&
          other.documentType == this.documentType &&
          other.emissionDate == this.emissionDate &&
          other.expiryDate == this.expiryDate &&
          other.fileUrl == this.fileUrl);
}

class WorkerDocumentsLocalCompanion
    extends UpdateCompanion<WorkerDocumentsLocalData> {
  final Value<String> id;
  final Value<String> documentType;
  final Value<String> emissionDate;
  final Value<String> expiryDate;
  final Value<String?> fileUrl;
  final Value<int> rowid;
  const WorkerDocumentsLocalCompanion({
    this.id = const Value.absent(),
    this.documentType = const Value.absent(),
    this.emissionDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkerDocumentsLocalCompanion.insert({
    required String id,
    required String documentType,
    required String emissionDate,
    required String expiryDate,
    this.fileUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       documentType = Value(documentType),
       emissionDate = Value(emissionDate),
       expiryDate = Value(expiryDate);
  static Insertable<WorkerDocumentsLocalData> custom({
    Expression<String>? id,
    Expression<String>? documentType,
    Expression<String>? emissionDate,
    Expression<String>? expiryDate,
    Expression<String>? fileUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (documentType != null) 'document_type': documentType,
      if (emissionDate != null) 'emission_date': emissionDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (fileUrl != null) 'file_url': fileUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkerDocumentsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? documentType,
    Value<String>? emissionDate,
    Value<String>? expiryDate,
    Value<String?>? fileUrl,
    Value<int>? rowid,
  }) {
    return WorkerDocumentsLocalCompanion(
      id: id ?? this.id,
      documentType: documentType ?? this.documentType,
      emissionDate: emissionDate ?? this.emissionDate,
      expiryDate: expiryDate ?? this.expiryDate,
      fileUrl: fileUrl ?? this.fileUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (emissionDate.present) {
      map['emission_date'] = Variable<String>(emissionDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<String>(expiryDate.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkerDocumentsLocalCompanion(')
          ..write('id: $id, ')
          ..write('documentType: $documentType, ')
          ..write('emissionDate: $emissionDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesLocalTable extends VehiclesLocal
    with TableInfo<$VehiclesLocalTable, VehiclesLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plateNumberMeta = const VerificationMeta(
    'plateNumber',
  );
  @override
  late final GeneratedColumn<String> plateNumber = GeneratedColumn<String>(
    'plate_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastOdometerMeta = const VerificationMeta(
    'lastOdometer',
  );
  @override
  late final GeneratedColumn<int> lastOdometer = GeneratedColumn<int>(
    'last_odometer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qrCodeTokenMeta = const VerificationMeta(
    'qrCodeToken',
  );
  @override
  late final GeneratedColumn<String> qrCodeToken = GeneratedColumn<String>(
    'qr_code_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    plateNumber,
    brand,
    model,
    year,
    lastOdometer,
    qrCodeToken,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehiclesLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plate_number')) {
      context.handle(
        _plateNumberMeta,
        plateNumber.isAcceptableOrUnknown(
          data['plate_number']!,
          _plateNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plateNumberMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('last_odometer')) {
      context.handle(
        _lastOdometerMeta,
        lastOdometer.isAcceptableOrUnknown(
          data['last_odometer']!,
          _lastOdometerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastOdometerMeta);
    }
    if (data.containsKey('qr_code_token')) {
      context.handle(
        _qrCodeTokenMeta,
        qrCodeToken.isAcceptableOrUnknown(
          data['qr_code_token']!,
          _qrCodeTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_qrCodeTokenMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehiclesLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehiclesLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      plateNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate_number'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      lastOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_odometer'],
      )!,
      qrCodeToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qr_code_token'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $VehiclesLocalTable createAlias(String alias) {
    return $VehiclesLocalTable(attachedDatabase, alias);
  }
}

class VehiclesLocalData extends DataClass
    implements Insertable<VehiclesLocalData> {
  final String id;
  final String plateNumber;
  final String brand;
  final String model;
  final int year;
  final int lastOdometer;
  final String qrCodeToken;
  final bool isActive;
  const VehiclesLocalData({
    required this.id,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.year,
    required this.lastOdometer,
    required this.qrCodeToken,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plate_number'] = Variable<String>(plateNumber);
    map['brand'] = Variable<String>(brand);
    map['model'] = Variable<String>(model);
    map['year'] = Variable<int>(year);
    map['last_odometer'] = Variable<int>(lastOdometer);
    map['qr_code_token'] = Variable<String>(qrCodeToken);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  VehiclesLocalCompanion toCompanion(bool nullToAbsent) {
    return VehiclesLocalCompanion(
      id: Value(id),
      plateNumber: Value(plateNumber),
      brand: Value(brand),
      model: Value(model),
      year: Value(year),
      lastOdometer: Value(lastOdometer),
      qrCodeToken: Value(qrCodeToken),
      isActive: Value(isActive),
    );
  }

  factory VehiclesLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehiclesLocalData(
      id: serializer.fromJson<String>(json['id']),
      plateNumber: serializer.fromJson<String>(json['plateNumber']),
      brand: serializer.fromJson<String>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int>(json['year']),
      lastOdometer: serializer.fromJson<int>(json['lastOdometer']),
      qrCodeToken: serializer.fromJson<String>(json['qrCodeToken']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'plateNumber': serializer.toJson<String>(plateNumber),
      'brand': serializer.toJson<String>(brand),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int>(year),
      'lastOdometer': serializer.toJson<int>(lastOdometer),
      'qrCodeToken': serializer.toJson<String>(qrCodeToken),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  VehiclesLocalData copyWith({
    String? id,
    String? plateNumber,
    String? brand,
    String? model,
    int? year,
    int? lastOdometer,
    String? qrCodeToken,
    bool? isActive,
  }) => VehiclesLocalData(
    id: id ?? this.id,
    plateNumber: plateNumber ?? this.plateNumber,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    year: year ?? this.year,
    lastOdometer: lastOdometer ?? this.lastOdometer,
    qrCodeToken: qrCodeToken ?? this.qrCodeToken,
    isActive: isActive ?? this.isActive,
  );
  VehiclesLocalData copyWithCompanion(VehiclesLocalCompanion data) {
    return VehiclesLocalData(
      id: data.id.present ? data.id.value : this.id,
      plateNumber: data.plateNumber.present
          ? data.plateNumber.value
          : this.plateNumber,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      lastOdometer: data.lastOdometer.present
          ? data.lastOdometer.value
          : this.lastOdometer,
      qrCodeToken: data.qrCodeToken.present
          ? data.qrCodeToken.value
          : this.qrCodeToken,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesLocalData(')
          ..write('id: $id, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('lastOdometer: $lastOdometer, ')
          ..write('qrCodeToken: $qrCodeToken, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    plateNumber,
    brand,
    model,
    year,
    lastOdometer,
    qrCodeToken,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehiclesLocalData &&
          other.id == this.id &&
          other.plateNumber == this.plateNumber &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.year == this.year &&
          other.lastOdometer == this.lastOdometer &&
          other.qrCodeToken == this.qrCodeToken &&
          other.isActive == this.isActive);
}

class VehiclesLocalCompanion extends UpdateCompanion<VehiclesLocalData> {
  final Value<String> id;
  final Value<String> plateNumber;
  final Value<String> brand;
  final Value<String> model;
  final Value<int> year;
  final Value<int> lastOdometer;
  final Value<String> qrCodeToken;
  final Value<bool> isActive;
  final Value<int> rowid;
  const VehiclesLocalCompanion({
    this.id = const Value.absent(),
    this.plateNumber = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.lastOdometer = const Value.absent(),
    this.qrCodeToken = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesLocalCompanion.insert({
    required String id,
    required String plateNumber,
    required String brand,
    required String model,
    required int year,
    required int lastOdometer,
    required String qrCodeToken,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       plateNumber = Value(plateNumber),
       brand = Value(brand),
       model = Value(model),
       year = Value(year),
       lastOdometer = Value(lastOdometer),
       qrCodeToken = Value(qrCodeToken);
  static Insertable<VehiclesLocalData> custom({
    Expression<String>? id,
    Expression<String>? plateNumber,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<int>? year,
    Expression<int>? lastOdometer,
    Expression<String>? qrCodeToken,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plateNumber != null) 'plate_number': plateNumber,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (lastOdometer != null) 'last_odometer': lastOdometer,
      if (qrCodeToken != null) 'qr_code_token': qrCodeToken,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? plateNumber,
    Value<String>? brand,
    Value<String>? model,
    Value<int>? year,
    Value<int>? lastOdometer,
    Value<String>? qrCodeToken,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return VehiclesLocalCompanion(
      id: id ?? this.id,
      plateNumber: plateNumber ?? this.plateNumber,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      lastOdometer: lastOdometer ?? this.lastOdometer,
      qrCodeToken: qrCodeToken ?? this.qrCodeToken,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (plateNumber.present) {
      map['plate_number'] = Variable<String>(plateNumber.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (lastOdometer.present) {
      map['last_odometer'] = Variable<int>(lastOdometer.value);
    }
    if (qrCodeToken.present) {
      map['qr_code_token'] = Variable<String>(qrCodeToken.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesLocalCompanion(')
          ..write('id: $id, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('lastOdometer: $lastOdometer, ')
          ..write('qrCodeToken: $qrCodeToken, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehicleDocumentsLocalTable extends VehicleDocumentsLocal
    with TableInfo<$VehicleDocumentsLocalTable, VehicleDocumentsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehicleDocumentsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentTypeMeta = const VerificationMeta(
    'documentType',
  );
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
    'document_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emissionDateMeta = const VerificationMeta(
    'emissionDate',
  );
  @override
  late final GeneratedColumn<String> emissionDate = GeneratedColumn<String>(
    'emission_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<String> expiryDate = GeneratedColumn<String>(
    'expiry_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileUrlMeta = const VerificationMeta(
    'fileUrl',
  );
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
    'file_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    documentType,
    emissionDate,
    expiryDate,
    fileUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicle_documents_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleDocumentsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('document_type')) {
      context.handle(
        _documentTypeMeta,
        documentType.isAcceptableOrUnknown(
          data['document_type']!,
          _documentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentTypeMeta);
    }
    if (data.containsKey('emission_date')) {
      context.handle(
        _emissionDateMeta,
        emissionDate.isAcceptableOrUnknown(
          data['emission_date']!,
          _emissionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emissionDateMeta);
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_expiryDateMeta);
    }
    if (data.containsKey('file_url')) {
      context.handle(
        _fileUrlMeta,
        fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleDocumentsLocalData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleDocumentsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      documentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_type'],
      )!,
      emissionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emission_date'],
      )!,
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expiry_date'],
      )!,
      fileUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_url'],
      ),
    );
  }

  @override
  $VehicleDocumentsLocalTable createAlias(String alias) {
    return $VehicleDocumentsLocalTable(attachedDatabase, alias);
  }
}

class VehicleDocumentsLocalData extends DataClass
    implements Insertable<VehicleDocumentsLocalData> {
  final String id;
  final String vehicleId;
  final String documentType;
  final String emissionDate;
  final String expiryDate;
  final String? fileUrl;
  const VehicleDocumentsLocalData({
    required this.id,
    required this.vehicleId,
    required this.documentType,
    required this.emissionDate,
    required this.expiryDate,
    this.fileUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['document_type'] = Variable<String>(documentType);
    map['emission_date'] = Variable<String>(emissionDate);
    map['expiry_date'] = Variable<String>(expiryDate);
    if (!nullToAbsent || fileUrl != null) {
      map['file_url'] = Variable<String>(fileUrl);
    }
    return map;
  }

  VehicleDocumentsLocalCompanion toCompanion(bool nullToAbsent) {
    return VehicleDocumentsLocalCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      documentType: Value(documentType),
      emissionDate: Value(emissionDate),
      expiryDate: Value(expiryDate),
      fileUrl: fileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUrl),
    );
  }

  factory VehicleDocumentsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleDocumentsLocalData(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      documentType: serializer.fromJson<String>(json['documentType']),
      emissionDate: serializer.fromJson<String>(json['emissionDate']),
      expiryDate: serializer.fromJson<String>(json['expiryDate']),
      fileUrl: serializer.fromJson<String?>(json['fileUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'documentType': serializer.toJson<String>(documentType),
      'emissionDate': serializer.toJson<String>(emissionDate),
      'expiryDate': serializer.toJson<String>(expiryDate),
      'fileUrl': serializer.toJson<String?>(fileUrl),
    };
  }

  VehicleDocumentsLocalData copyWith({
    String? id,
    String? vehicleId,
    String? documentType,
    String? emissionDate,
    String? expiryDate,
    Value<String?> fileUrl = const Value.absent(),
  }) => VehicleDocumentsLocalData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    documentType: documentType ?? this.documentType,
    emissionDate: emissionDate ?? this.emissionDate,
    expiryDate: expiryDate ?? this.expiryDate,
    fileUrl: fileUrl.present ? fileUrl.value : this.fileUrl,
  );
  VehicleDocumentsLocalData copyWithCompanion(
    VehicleDocumentsLocalCompanion data,
  ) {
    return VehicleDocumentsLocalData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      emissionDate: data.emissionDate.present
          ? data.emissionDate.value
          : this.emissionDate,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleDocumentsLocalData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('documentType: $documentType, ')
          ..write('emissionDate: $emissionDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('fileUrl: $fileUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    documentType,
    emissionDate,
    expiryDate,
    fileUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleDocumentsLocalData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.documentType == this.documentType &&
          other.emissionDate == this.emissionDate &&
          other.expiryDate == this.expiryDate &&
          other.fileUrl == this.fileUrl);
}

class VehicleDocumentsLocalCompanion
    extends UpdateCompanion<VehicleDocumentsLocalData> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> documentType;
  final Value<String> emissionDate;
  final Value<String> expiryDate;
  final Value<String?> fileUrl;
  final Value<int> rowid;
  const VehicleDocumentsLocalCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.documentType = const Value.absent(),
    this.emissionDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehicleDocumentsLocalCompanion.insert({
    required String id,
    required String vehicleId,
    required String documentType,
    required String emissionDate,
    required String expiryDate,
    this.fileUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       documentType = Value(documentType),
       emissionDate = Value(emissionDate),
       expiryDate = Value(expiryDate);
  static Insertable<VehicleDocumentsLocalData> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? documentType,
    Expression<String>? emissionDate,
    Expression<String>? expiryDate,
    Expression<String>? fileUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (documentType != null) 'document_type': documentType,
      if (emissionDate != null) 'emission_date': emissionDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (fileUrl != null) 'file_url': fileUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehicleDocumentsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? documentType,
    Value<String>? emissionDate,
    Value<String>? expiryDate,
    Value<String?>? fileUrl,
    Value<int>? rowid,
  }) {
    return VehicleDocumentsLocalCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      documentType: documentType ?? this.documentType,
      emissionDate: emissionDate ?? this.emissionDate,
      expiryDate: expiryDate ?? this.expiryDate,
      fileUrl: fileUrl ?? this.fileUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (emissionDate.present) {
      map['emission_date'] = Variable<String>(emissionDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<String>(expiryDate.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehicleDocumentsLocalCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('documentType: $documentType, ')
          ..write('emissionDate: $emissionDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistsLocalTable extends ChecklistsLocal
    with TableInfo<$ChecklistsLocalTable, ChecklistsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, description, version];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklists_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistsLocalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $ChecklistsLocalTable createAlias(String alias) {
    return $ChecklistsLocalTable(attachedDatabase, alias);
  }
}

class ChecklistsLocalData extends DataClass
    implements Insertable<ChecklistsLocalData> {
  final String id;
  final String title;
  final String? description;
  final int version;
  const ChecklistsLocalData({
    required this.id,
    required this.title,
    this.description,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['version'] = Variable<int>(version);
    return map;
  }

  ChecklistsLocalCompanion toCompanion(bool nullToAbsent) {
    return ChecklistsLocalCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      version: Value(version),
    );
  }

  factory ChecklistsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistsLocalData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'version': serializer.toJson<int>(version),
    };
  }

  ChecklistsLocalData copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    int? version,
  }) => ChecklistsLocalData(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    version: version ?? this.version,
  );
  ChecklistsLocalData copyWithCompanion(ChecklistsLocalCompanion data) {
    return ChecklistsLocalData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistsLocalData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistsLocalData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.version == this.version);
}

class ChecklistsLocalCompanion extends UpdateCompanion<ChecklistsLocalData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> version;
  final Value<int> rowid;
  const ChecklistsLocalCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistsLocalCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required int version,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       version = Value(version);
  static Insertable<ChecklistsLocalData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return ChecklistsLocalCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistsLocalCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistQuestionsLocalTable extends ChecklistQuestionsLocal
    with TableInfo<$ChecklistQuestionsLocalTable, ChecklistQuestionsLocalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistQuestionsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checklistIdMeta = const VerificationMeta(
    'checklistId',
  );
  @override
  late final GeneratedColumn<String> checklistId = GeneratedColumn<String>(
    'checklist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionTextMeta = const VerificationMeta(
    'questionText',
  );
  @override
  late final GeneratedColumn<String> questionText = GeneratedColumn<String>(
    'question_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionTypeMeta = const VerificationMeta(
    'questionType',
  );
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
    'question_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRequiredMeta = const VerificationMeta(
    'isRequired',
  );
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
    'is_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_required" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isCriticalMeta = const VerificationMeta(
    'isCritical',
  );
  @override
  late final GeneratedColumn<bool> isCritical = GeneratedColumn<bool>(
    'is_critical',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_critical" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    checklistId,
    questionText,
    questionType,
    isRequired,
    isCritical,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_questions_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistQuestionsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('checklist_id')) {
      context.handle(
        _checklistIdMeta,
        checklistId.isAcceptableOrUnknown(
          data['checklist_id']!,
          _checklistIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_checklistIdMeta);
    }
    if (data.containsKey('question_text')) {
      context.handle(
        _questionTextMeta,
        questionText.isAcceptableOrUnknown(
          data['question_text']!,
          _questionTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionTextMeta);
    }
    if (data.containsKey('question_type')) {
      context.handle(
        _questionTypeMeta,
        questionType.isAcceptableOrUnknown(
          data['question_type']!,
          _questionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionTypeMeta);
    }
    if (data.containsKey('is_required')) {
      context.handle(
        _isRequiredMeta,
        isRequired.isAcceptableOrUnknown(data['is_required']!, _isRequiredMeta),
      );
    }
    if (data.containsKey('is_critical')) {
      context.handle(
        _isCriticalMeta,
        isCritical.isAcceptableOrUnknown(data['is_critical']!, _isCriticalMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistQuestionsLocalData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistQuestionsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      checklistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checklist_id'],
      )!,
      questionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_text'],
      )!,
      questionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_type'],
      )!,
      isRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_required'],
      )!,
      isCritical: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_critical'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ChecklistQuestionsLocalTable createAlias(String alias) {
    return $ChecklistQuestionsLocalTable(attachedDatabase, alias);
  }
}

class ChecklistQuestionsLocalData extends DataClass
    implements Insertable<ChecklistQuestionsLocalData> {
  final String id;
  final String checklistId;
  final String questionText;
  final String questionType;
  final bool isRequired;
  final bool isCritical;
  final int sortOrder;
  const ChecklistQuestionsLocalData({
    required this.id,
    required this.checklistId,
    required this.questionText,
    required this.questionType,
    required this.isRequired,
    required this.isCritical,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['checklist_id'] = Variable<String>(checklistId);
    map['question_text'] = Variable<String>(questionText);
    map['question_type'] = Variable<String>(questionType);
    map['is_required'] = Variable<bool>(isRequired);
    map['is_critical'] = Variable<bool>(isCritical);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ChecklistQuestionsLocalCompanion toCompanion(bool nullToAbsent) {
    return ChecklistQuestionsLocalCompanion(
      id: Value(id),
      checklistId: Value(checklistId),
      questionText: Value(questionText),
      questionType: Value(questionType),
      isRequired: Value(isRequired),
      isCritical: Value(isCritical),
      sortOrder: Value(sortOrder),
    );
  }

  factory ChecklistQuestionsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistQuestionsLocalData(
      id: serializer.fromJson<String>(json['id']),
      checklistId: serializer.fromJson<String>(json['checklistId']),
      questionText: serializer.fromJson<String>(json['questionText']),
      questionType: serializer.fromJson<String>(json['questionType']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      isCritical: serializer.fromJson<bool>(json['isCritical']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'checklistId': serializer.toJson<String>(checklistId),
      'questionText': serializer.toJson<String>(questionText),
      'questionType': serializer.toJson<String>(questionType),
      'isRequired': serializer.toJson<bool>(isRequired),
      'isCritical': serializer.toJson<bool>(isCritical),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ChecklistQuestionsLocalData copyWith({
    String? id,
    String? checklistId,
    String? questionText,
    String? questionType,
    bool? isRequired,
    bool? isCritical,
    int? sortOrder,
  }) => ChecklistQuestionsLocalData(
    id: id ?? this.id,
    checklistId: checklistId ?? this.checklistId,
    questionText: questionText ?? this.questionText,
    questionType: questionType ?? this.questionType,
    isRequired: isRequired ?? this.isRequired,
    isCritical: isCritical ?? this.isCritical,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ChecklistQuestionsLocalData copyWithCompanion(
    ChecklistQuestionsLocalCompanion data,
  ) {
    return ChecklistQuestionsLocalData(
      id: data.id.present ? data.id.value : this.id,
      checklistId: data.checklistId.present
          ? data.checklistId.value
          : this.checklistId,
      questionText: data.questionText.present
          ? data.questionText.value
          : this.questionText,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      isRequired: data.isRequired.present
          ? data.isRequired.value
          : this.isRequired,
      isCritical: data.isCritical.present
          ? data.isCritical.value
          : this.isCritical,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistQuestionsLocalData(')
          ..write('id: $id, ')
          ..write('checklistId: $checklistId, ')
          ..write('questionText: $questionText, ')
          ..write('questionType: $questionType, ')
          ..write('isRequired: $isRequired, ')
          ..write('isCritical: $isCritical, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    checklistId,
    questionText,
    questionType,
    isRequired,
    isCritical,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistQuestionsLocalData &&
          other.id == this.id &&
          other.checklistId == this.checklistId &&
          other.questionText == this.questionText &&
          other.questionType == this.questionType &&
          other.isRequired == this.isRequired &&
          other.isCritical == this.isCritical &&
          other.sortOrder == this.sortOrder);
}

class ChecklistQuestionsLocalCompanion
    extends UpdateCompanion<ChecklistQuestionsLocalData> {
  final Value<String> id;
  final Value<String> checklistId;
  final Value<String> questionText;
  final Value<String> questionType;
  final Value<bool> isRequired;
  final Value<bool> isCritical;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ChecklistQuestionsLocalCompanion({
    this.id = const Value.absent(),
    this.checklistId = const Value.absent(),
    this.questionText = const Value.absent(),
    this.questionType = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.isCritical = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistQuestionsLocalCompanion.insert({
    required String id,
    required String checklistId,
    required String questionText,
    required String questionType,
    this.isRequired = const Value.absent(),
    this.isCritical = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       checklistId = Value(checklistId),
       questionText = Value(questionText),
       questionType = Value(questionType),
       sortOrder = Value(sortOrder);
  static Insertable<ChecklistQuestionsLocalData> custom({
    Expression<String>? id,
    Expression<String>? checklistId,
    Expression<String>? questionText,
    Expression<String>? questionType,
    Expression<bool>? isRequired,
    Expression<bool>? isCritical,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (checklistId != null) 'checklist_id': checklistId,
      if (questionText != null) 'question_text': questionText,
      if (questionType != null) 'question_type': questionType,
      if (isRequired != null) 'is_required': isRequired,
      if (isCritical != null) 'is_critical': isCritical,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistQuestionsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? checklistId,
    Value<String>? questionText,
    Value<String>? questionType,
    Value<bool>? isRequired,
    Value<bool>? isCritical,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ChecklistQuestionsLocalCompanion(
      id: id ?? this.id,
      checklistId: checklistId ?? this.checklistId,
      questionText: questionText ?? this.questionText,
      questionType: questionType ?? this.questionType,
      isRequired: isRequired ?? this.isRequired,
      isCritical: isCritical ?? this.isCritical,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (checklistId.present) {
      map['checklist_id'] = Variable<String>(checklistId.value);
    }
    if (questionText.present) {
      map['question_text'] = Variable<String>(questionText.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (isCritical.present) {
      map['is_critical'] = Variable<bool>(isCritical.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistQuestionsLocalCompanion(')
          ..write('id: $id, ')
          ..write('checklistId: $checklistId, ')
          ..write('questionText: $questionText, ')
          ..write('questionType: $questionType, ')
          ..write('isRequired: $isRequired, ')
          ..write('isCritical: $isCritical, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChecklistQuestionOptionsLocalTable extends ChecklistQuestionOptionsLocal
    with
        TableInfo<
          $ChecklistQuestionOptionsLocalTable,
          ChecklistQuestionOptionsLocalData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistQuestionOptionsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _optionTextMeta = const VerificationMeta(
    'optionText',
  );
  @override
  late final GeneratedColumn<String> optionText = GeneratedColumn<String>(
    'option_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCriticalTriggerMeta = const VerificationMeta(
    'isCriticalTrigger',
  );
  @override
  late final GeneratedColumn<bool> isCriticalTrigger = GeneratedColumn<bool>(
    'is_critical_trigger',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_critical_trigger" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionId,
    optionText,
    isCriticalTrigger,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_question_options_local';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistQuestionOptionsLocalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('option_text')) {
      context.handle(
        _optionTextMeta,
        optionText.isAcceptableOrUnknown(data['option_text']!, _optionTextMeta),
      );
    } else if (isInserting) {
      context.missing(_optionTextMeta);
    }
    if (data.containsKey('is_critical_trigger')) {
      context.handle(
        _isCriticalTriggerMeta,
        isCriticalTrigger.isAcceptableOrUnknown(
          data['is_critical_trigger']!,
          _isCriticalTriggerMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistQuestionOptionsLocalData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistQuestionOptionsLocalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      optionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_text'],
      )!,
      isCriticalTrigger: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_critical_trigger'],
      )!,
    );
  }

  @override
  $ChecklistQuestionOptionsLocalTable createAlias(String alias) {
    return $ChecklistQuestionOptionsLocalTable(attachedDatabase, alias);
  }
}

class ChecklistQuestionOptionsLocalData extends DataClass
    implements Insertable<ChecklistQuestionOptionsLocalData> {
  final String id;
  final String questionId;
  final String optionText;
  final bool isCriticalTrigger;
  const ChecklistQuestionOptionsLocalData({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.isCriticalTrigger,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['question_id'] = Variable<String>(questionId);
    map['option_text'] = Variable<String>(optionText);
    map['is_critical_trigger'] = Variable<bool>(isCriticalTrigger);
    return map;
  }

  ChecklistQuestionOptionsLocalCompanion toCompanion(bool nullToAbsent) {
    return ChecklistQuestionOptionsLocalCompanion(
      id: Value(id),
      questionId: Value(questionId),
      optionText: Value(optionText),
      isCriticalTrigger: Value(isCriticalTrigger),
    );
  }

  factory ChecklistQuestionOptionsLocalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistQuestionOptionsLocalData(
      id: serializer.fromJson<String>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      optionText: serializer.fromJson<String>(json['optionText']),
      isCriticalTrigger: serializer.fromJson<bool>(json['isCriticalTrigger']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'questionId': serializer.toJson<String>(questionId),
      'optionText': serializer.toJson<String>(optionText),
      'isCriticalTrigger': serializer.toJson<bool>(isCriticalTrigger),
    };
  }

  ChecklistQuestionOptionsLocalData copyWith({
    String? id,
    String? questionId,
    String? optionText,
    bool? isCriticalTrigger,
  }) => ChecklistQuestionOptionsLocalData(
    id: id ?? this.id,
    questionId: questionId ?? this.questionId,
    optionText: optionText ?? this.optionText,
    isCriticalTrigger: isCriticalTrigger ?? this.isCriticalTrigger,
  );
  ChecklistQuestionOptionsLocalData copyWithCompanion(
    ChecklistQuestionOptionsLocalCompanion data,
  ) {
    return ChecklistQuestionOptionsLocalData(
      id: data.id.present ? data.id.value : this.id,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      optionText: data.optionText.present
          ? data.optionText.value
          : this.optionText,
      isCriticalTrigger: data.isCriticalTrigger.present
          ? data.isCriticalTrigger.value
          : this.isCriticalTrigger,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistQuestionOptionsLocalData(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('optionText: $optionText, ')
          ..write('isCriticalTrigger: $isCriticalTrigger')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, questionId, optionText, isCriticalTrigger);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistQuestionOptionsLocalData &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.optionText == this.optionText &&
          other.isCriticalTrigger == this.isCriticalTrigger);
}

class ChecklistQuestionOptionsLocalCompanion
    extends UpdateCompanion<ChecklistQuestionOptionsLocalData> {
  final Value<String> id;
  final Value<String> questionId;
  final Value<String> optionText;
  final Value<bool> isCriticalTrigger;
  final Value<int> rowid;
  const ChecklistQuestionOptionsLocalCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.optionText = const Value.absent(),
    this.isCriticalTrigger = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChecklistQuestionOptionsLocalCompanion.insert({
    required String id,
    required String questionId,
    required String optionText,
    this.isCriticalTrigger = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       questionId = Value(questionId),
       optionText = Value(optionText);
  static Insertable<ChecklistQuestionOptionsLocalData> custom({
    Expression<String>? id,
    Expression<String>? questionId,
    Expression<String>? optionText,
    Expression<bool>? isCriticalTrigger,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (optionText != null) 'option_text': optionText,
      if (isCriticalTrigger != null) 'is_critical_trigger': isCriticalTrigger,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChecklistQuestionOptionsLocalCompanion copyWith({
    Value<String>? id,
    Value<String>? questionId,
    Value<String>? optionText,
    Value<bool>? isCriticalTrigger,
    Value<int>? rowid,
  }) {
    return ChecklistQuestionOptionsLocalCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      optionText: optionText ?? this.optionText,
      isCriticalTrigger: isCriticalTrigger ?? this.isCriticalTrigger,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (optionText.present) {
      map['option_text'] = Variable<String>(optionText.value);
    }
    if (isCriticalTrigger.present) {
      map['is_critical_trigger'] = Variable<bool>(isCriticalTrigger.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistQuestionOptionsLocalCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('optionText: $optionText, ')
          ..write('isCriticalTrigger: $isCriticalTrigger, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $RoutesLocalTable routesLocal = $RoutesLocalTable(this);
  late final $RoutePointsLocalTable routePointsLocal = $RoutePointsLocalTable(
    this,
  );
  late final $RoutePointVisitsLocalTable routePointVisitsLocal =
      $RoutePointVisitsLocalTable(this);
  late final $ChecklistSubmissionsLocalTable checklistSubmissionsLocal =
      $ChecklistSubmissionsLocalTable(this);
  late final $ChecklistAnswersLocalTable checklistAnswersLocal =
      $ChecklistAnswersLocalTable(this);
  late final $AuditLogsLocalTable auditLogsLocal = $AuditLogsLocalTable(this);
  late final $WorkerDocumentsLocalTable workerDocumentsLocal =
      $WorkerDocumentsLocalTable(this);
  late final $VehiclesLocalTable vehiclesLocal = $VehiclesLocalTable(this);
  late final $VehicleDocumentsLocalTable vehicleDocumentsLocal =
      $VehicleDocumentsLocalTable(this);
  late final $ChecklistsLocalTable checklistsLocal = $ChecklistsLocalTable(
    this,
  );
  late final $ChecklistQuestionsLocalTable checklistQuestionsLocal =
      $ChecklistQuestionsLocalTable(this);
  late final $ChecklistQuestionOptionsLocalTable checklistQuestionOptionsLocal =
      $ChecklistQuestionOptionsLocalTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    syncQueue,
    routesLocal,
    routePointsLocal,
    routePointVisitsLocal,
    checklistSubmissionsLocal,
    checklistAnswersLocal,
    auditLogsLocal,
    workerDocumentsLocal,
    vehiclesLocal,
    vehicleDocumentsLocal,
    checklistsLocal,
    checklistQuestionsLocal,
    checklistQuestionOptionsLocal,
  ];
}

typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String endpoint,
      required String method,
      required String payload,
      Value<DateTime> createdAt,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> endpoint,
      Value<String> method,
      Value<String> payload,
      Value<DateTime> createdAt,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$LocalDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endpoint => $composableBuilder(
    column: $table.endpoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$LocalDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endpoint => $composableBuilder(
    column: $table.endpoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$LocalDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get endpoint =>
      $composableBuilder(column: $table.endpoint, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$LocalDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$LocalDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> endpoint = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                endpoint: endpoint,
                method: method,
                payload: payload,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String endpoint,
                required String method,
                required String payload,
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                endpoint: endpoint,
                method: method,
                payload: payload,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$LocalDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$RoutesLocalTableCreateCompanionBuilder =
    RoutesLocalCompanion Function({
      required String id,
      required String name,
      required String clientName,
      required String faenaName,
      required String status,
      required String scheduledDate,
      Value<int> rowid,
    });
typedef $$RoutesLocalTableUpdateCompanionBuilder =
    RoutesLocalCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> clientName,
      Value<String> faenaName,
      Value<String> status,
      Value<String> scheduledDate,
      Value<int> rowid,
    });

class $$RoutesLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $RoutesLocalTable> {
  $$RoutesLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get faenaName => $composableBuilder(
    column: $table.faenaName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutesLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $RoutesLocalTable> {
  $$RoutesLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get faenaName => $composableBuilder(
    column: $table.faenaName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutesLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $RoutesLocalTable> {
  $$RoutesLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get faenaName =>
      $composableBuilder(column: $table.faenaName, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );
}

class $$RoutesLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $RoutesLocalTable,
          RoutesLocalData,
          $$RoutesLocalTableFilterComposer,
          $$RoutesLocalTableOrderingComposer,
          $$RoutesLocalTableAnnotationComposer,
          $$RoutesLocalTableCreateCompanionBuilder,
          $$RoutesLocalTableUpdateCompanionBuilder,
          (
            RoutesLocalData,
            BaseReferences<_$LocalDatabase, $RoutesLocalTable, RoutesLocalData>,
          ),
          RoutesLocalData,
          PrefetchHooks Function()
        > {
  $$RoutesLocalTableTableManager(_$LocalDatabase db, $RoutesLocalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutesLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutesLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutesLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> clientName = const Value.absent(),
                Value<String> faenaName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> scheduledDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutesLocalCompanion(
                id: id,
                name: name,
                clientName: clientName,
                faenaName: faenaName,
                status: status,
                scheduledDate: scheduledDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String clientName,
                required String faenaName,
                required String status,
                required String scheduledDate,
                Value<int> rowid = const Value.absent(),
              }) => RoutesLocalCompanion.insert(
                id: id,
                name: name,
                clientName: clientName,
                faenaName: faenaName,
                status: status,
                scheduledDate: scheduledDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutesLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $RoutesLocalTable,
      RoutesLocalData,
      $$RoutesLocalTableFilterComposer,
      $$RoutesLocalTableOrderingComposer,
      $$RoutesLocalTableAnnotationComposer,
      $$RoutesLocalTableCreateCompanionBuilder,
      $$RoutesLocalTableUpdateCompanionBuilder,
      (
        RoutesLocalData,
        BaseReferences<_$LocalDatabase, $RoutesLocalTable, RoutesLocalData>,
      ),
      RoutesLocalData,
      PrefetchHooks Function()
    >;
typedef $$RoutePointsLocalTableCreateCompanionBuilder =
    RoutePointsLocalCompanion Function({
      required String id,
      required String routeId,
      required String name,
      required String qrCodeToken,
      required int sequenceOrder,
      required String status,
      Value<int> rowid,
    });
typedef $$RoutePointsLocalTableUpdateCompanionBuilder =
    RoutePointsLocalCompanion Function({
      Value<String> id,
      Value<String> routeId,
      Value<String> name,
      Value<String> qrCodeToken,
      Value<int> sequenceOrder,
      Value<String> status,
      Value<int> rowid,
    });

class $$RoutePointsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $RoutePointsLocalTable> {
  $$RoutePointsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routeId => $composableBuilder(
    column: $table.routeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrCodeToken => $composableBuilder(
    column: $table.qrCodeToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequenceOrder => $composableBuilder(
    column: $table.sequenceOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutePointsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $RoutePointsLocalTable> {
  $$RoutePointsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routeId => $composableBuilder(
    column: $table.routeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrCodeToken => $composableBuilder(
    column: $table.qrCodeToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequenceOrder => $composableBuilder(
    column: $table.sequenceOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutePointsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $RoutePointsLocalTable> {
  $$RoutePointsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get routeId =>
      $composableBuilder(column: $table.routeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get qrCodeToken => $composableBuilder(
    column: $table.qrCodeToken,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sequenceOrder => $composableBuilder(
    column: $table.sequenceOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$RoutePointsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $RoutePointsLocalTable,
          RoutePointsLocalData,
          $$RoutePointsLocalTableFilterComposer,
          $$RoutePointsLocalTableOrderingComposer,
          $$RoutePointsLocalTableAnnotationComposer,
          $$RoutePointsLocalTableCreateCompanionBuilder,
          $$RoutePointsLocalTableUpdateCompanionBuilder,
          (
            RoutePointsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $RoutePointsLocalTable,
              RoutePointsLocalData
            >,
          ),
          RoutePointsLocalData,
          PrefetchHooks Function()
        > {
  $$RoutePointsLocalTableTableManager(
    _$LocalDatabase db,
    $RoutePointsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutePointsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutePointsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutePointsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> routeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> qrCodeToken = const Value.absent(),
                Value<int> sequenceOrder = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutePointsLocalCompanion(
                id: id,
                routeId: routeId,
                name: name,
                qrCodeToken: qrCodeToken,
                sequenceOrder: sequenceOrder,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String routeId,
                required String name,
                required String qrCodeToken,
                required int sequenceOrder,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => RoutePointsLocalCompanion.insert(
                id: id,
                routeId: routeId,
                name: name,
                qrCodeToken: qrCodeToken,
                sequenceOrder: sequenceOrder,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutePointsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $RoutePointsLocalTable,
      RoutePointsLocalData,
      $$RoutePointsLocalTableFilterComposer,
      $$RoutePointsLocalTableOrderingComposer,
      $$RoutePointsLocalTableAnnotationComposer,
      $$RoutePointsLocalTableCreateCompanionBuilder,
      $$RoutePointsLocalTableUpdateCompanionBuilder,
      (
        RoutePointsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $RoutePointsLocalTable,
          RoutePointsLocalData
        >,
      ),
      RoutePointsLocalData,
      PrefetchHooks Function()
    >;
typedef $$RoutePointVisitsLocalTableCreateCompanionBuilder =
    RoutePointVisitsLocalCompanion Function({
      required String id,
      required String pointId,
      required DateTime visitedAt,
      required double gpsLat,
      required double gpsLon,
      required double gpsAccuracy,
      required String photosBefore,
      required String photosAfter,
      required String formData,
      Value<int> rowid,
    });
typedef $$RoutePointVisitsLocalTableUpdateCompanionBuilder =
    RoutePointVisitsLocalCompanion Function({
      Value<String> id,
      Value<String> pointId,
      Value<DateTime> visitedAt,
      Value<double> gpsLat,
      Value<double> gpsLon,
      Value<double> gpsAccuracy,
      Value<String> photosBefore,
      Value<String> photosAfter,
      Value<String> formData,
      Value<int> rowid,
    });

class $$RoutePointVisitsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $RoutePointVisitsLocalTable> {
  $$RoutePointVisitsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pointId => $composableBuilder(
    column: $table.pointId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get visitedAt => $composableBuilder(
    column: $table.visitedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsLat => $composableBuilder(
    column: $table.gpsLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsLon => $composableBuilder(
    column: $table.gpsLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photosBefore => $composableBuilder(
    column: $table.photosBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photosAfter => $composableBuilder(
    column: $table.photosAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formData => $composableBuilder(
    column: $table.formData,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutePointVisitsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $RoutePointVisitsLocalTable> {
  $$RoutePointVisitsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pointId => $composableBuilder(
    column: $table.pointId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get visitedAt => $composableBuilder(
    column: $table.visitedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsLat => $composableBuilder(
    column: $table.gpsLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsLon => $composableBuilder(
    column: $table.gpsLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photosBefore => $composableBuilder(
    column: $table.photosBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photosAfter => $composableBuilder(
    column: $table.photosAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formData => $composableBuilder(
    column: $table.formData,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutePointVisitsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $RoutePointVisitsLocalTable> {
  $$RoutePointVisitsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pointId =>
      $composableBuilder(column: $table.pointId, builder: (column) => column);

  GeneratedColumn<DateTime> get visitedAt =>
      $composableBuilder(column: $table.visitedAt, builder: (column) => column);

  GeneratedColumn<double> get gpsLat =>
      $composableBuilder(column: $table.gpsLat, builder: (column) => column);

  GeneratedColumn<double> get gpsLon =>
      $composableBuilder(column: $table.gpsLon, builder: (column) => column);

  GeneratedColumn<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photosBefore => $composableBuilder(
    column: $table.photosBefore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photosAfter => $composableBuilder(
    column: $table.photosAfter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formData =>
      $composableBuilder(column: $table.formData, builder: (column) => column);
}

class $$RoutePointVisitsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $RoutePointVisitsLocalTable,
          RoutePointVisitsLocalData,
          $$RoutePointVisitsLocalTableFilterComposer,
          $$RoutePointVisitsLocalTableOrderingComposer,
          $$RoutePointVisitsLocalTableAnnotationComposer,
          $$RoutePointVisitsLocalTableCreateCompanionBuilder,
          $$RoutePointVisitsLocalTableUpdateCompanionBuilder,
          (
            RoutePointVisitsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $RoutePointVisitsLocalTable,
              RoutePointVisitsLocalData
            >,
          ),
          RoutePointVisitsLocalData,
          PrefetchHooks Function()
        > {
  $$RoutePointVisitsLocalTableTableManager(
    _$LocalDatabase db,
    $RoutePointVisitsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutePointVisitsLocalTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$RoutePointVisitsLocalTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RoutePointVisitsLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pointId = const Value.absent(),
                Value<DateTime> visitedAt = const Value.absent(),
                Value<double> gpsLat = const Value.absent(),
                Value<double> gpsLon = const Value.absent(),
                Value<double> gpsAccuracy = const Value.absent(),
                Value<String> photosBefore = const Value.absent(),
                Value<String> photosAfter = const Value.absent(),
                Value<String> formData = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutePointVisitsLocalCompanion(
                id: id,
                pointId: pointId,
                visitedAt: visitedAt,
                gpsLat: gpsLat,
                gpsLon: gpsLon,
                gpsAccuracy: gpsAccuracy,
                photosBefore: photosBefore,
                photosAfter: photosAfter,
                formData: formData,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pointId,
                required DateTime visitedAt,
                required double gpsLat,
                required double gpsLon,
                required double gpsAccuracy,
                required String photosBefore,
                required String photosAfter,
                required String formData,
                Value<int> rowid = const Value.absent(),
              }) => RoutePointVisitsLocalCompanion.insert(
                id: id,
                pointId: pointId,
                visitedAt: visitedAt,
                gpsLat: gpsLat,
                gpsLon: gpsLon,
                gpsAccuracy: gpsAccuracy,
                photosBefore: photosBefore,
                photosAfter: photosAfter,
                formData: formData,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutePointVisitsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $RoutePointVisitsLocalTable,
      RoutePointVisitsLocalData,
      $$RoutePointVisitsLocalTableFilterComposer,
      $$RoutePointVisitsLocalTableOrderingComposer,
      $$RoutePointVisitsLocalTableAnnotationComposer,
      $$RoutePointVisitsLocalTableCreateCompanionBuilder,
      $$RoutePointVisitsLocalTableUpdateCompanionBuilder,
      (
        RoutePointVisitsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $RoutePointVisitsLocalTable,
          RoutePointVisitsLocalData
        >,
      ),
      RoutePointVisitsLocalData,
      PrefetchHooks Function()
    >;
typedef $$ChecklistSubmissionsLocalTableCreateCompanionBuilder =
    ChecklistSubmissionsLocalCompanion Function({
      required String id,
      required String checklistId,
      Value<String?> vehicleId,
      Value<String?> routeId,
      required DateTime submittedAt,
      required double gpsLat,
      required double gpsLon,
      required double gpsAccuracy,
      Value<int> rowid,
    });
typedef $$ChecklistSubmissionsLocalTableUpdateCompanionBuilder =
    ChecklistSubmissionsLocalCompanion Function({
      Value<String> id,
      Value<String> checklistId,
      Value<String?> vehicleId,
      Value<String?> routeId,
      Value<DateTime> submittedAt,
      Value<double> gpsLat,
      Value<double> gpsLon,
      Value<double> gpsAccuracy,
      Value<int> rowid,
    });

class $$ChecklistSubmissionsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $ChecklistSubmissionsLocalTable> {
  $$ChecklistSubmissionsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checklistId => $composableBuilder(
    column: $table.checklistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routeId => $composableBuilder(
    column: $table.routeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsLat => $composableBuilder(
    column: $table.gpsLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsLon => $composableBuilder(
    column: $table.gpsLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistSubmissionsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $ChecklistSubmissionsLocalTable> {
  $$ChecklistSubmissionsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checklistId => $composableBuilder(
    column: $table.checklistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routeId => $composableBuilder(
    column: $table.routeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsLat => $composableBuilder(
    column: $table.gpsLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsLon => $composableBuilder(
    column: $table.gpsLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistSubmissionsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ChecklistSubmissionsLocalTable> {
  $$ChecklistSubmissionsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checklistId => $composableBuilder(
    column: $table.checklistId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<String> get routeId =>
      $composableBuilder(column: $table.routeId, builder: (column) => column);

  GeneratedColumn<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gpsLat =>
      $composableBuilder(column: $table.gpsLat, builder: (column) => column);

  GeneratedColumn<double> get gpsLon =>
      $composableBuilder(column: $table.gpsLon, builder: (column) => column);

  GeneratedColumn<double> get gpsAccuracy => $composableBuilder(
    column: $table.gpsAccuracy,
    builder: (column) => column,
  );
}

class $$ChecklistSubmissionsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ChecklistSubmissionsLocalTable,
          ChecklistSubmissionsLocalData,
          $$ChecklistSubmissionsLocalTableFilterComposer,
          $$ChecklistSubmissionsLocalTableOrderingComposer,
          $$ChecklistSubmissionsLocalTableAnnotationComposer,
          $$ChecklistSubmissionsLocalTableCreateCompanionBuilder,
          $$ChecklistSubmissionsLocalTableUpdateCompanionBuilder,
          (
            ChecklistSubmissionsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $ChecklistSubmissionsLocalTable,
              ChecklistSubmissionsLocalData
            >,
          ),
          ChecklistSubmissionsLocalData,
          PrefetchHooks Function()
        > {
  $$ChecklistSubmissionsLocalTableTableManager(
    _$LocalDatabase db,
    $ChecklistSubmissionsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistSubmissionsLocalTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ChecklistSubmissionsLocalTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChecklistSubmissionsLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checklistId = const Value.absent(),
                Value<String?> vehicleId = const Value.absent(),
                Value<String?> routeId = const Value.absent(),
                Value<DateTime> submittedAt = const Value.absent(),
                Value<double> gpsLat = const Value.absent(),
                Value<double> gpsLon = const Value.absent(),
                Value<double> gpsAccuracy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistSubmissionsLocalCompanion(
                id: id,
                checklistId: checklistId,
                vehicleId: vehicleId,
                routeId: routeId,
                submittedAt: submittedAt,
                gpsLat: gpsLat,
                gpsLon: gpsLon,
                gpsAccuracy: gpsAccuracy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checklistId,
                Value<String?> vehicleId = const Value.absent(),
                Value<String?> routeId = const Value.absent(),
                required DateTime submittedAt,
                required double gpsLat,
                required double gpsLon,
                required double gpsAccuracy,
                Value<int> rowid = const Value.absent(),
              }) => ChecklistSubmissionsLocalCompanion.insert(
                id: id,
                checklistId: checklistId,
                vehicleId: vehicleId,
                routeId: routeId,
                submittedAt: submittedAt,
                gpsLat: gpsLat,
                gpsLon: gpsLon,
                gpsAccuracy: gpsAccuracy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistSubmissionsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ChecklistSubmissionsLocalTable,
      ChecklistSubmissionsLocalData,
      $$ChecklistSubmissionsLocalTableFilterComposer,
      $$ChecklistSubmissionsLocalTableOrderingComposer,
      $$ChecklistSubmissionsLocalTableAnnotationComposer,
      $$ChecklistSubmissionsLocalTableCreateCompanionBuilder,
      $$ChecklistSubmissionsLocalTableUpdateCompanionBuilder,
      (
        ChecklistSubmissionsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $ChecklistSubmissionsLocalTable,
          ChecklistSubmissionsLocalData
        >,
      ),
      ChecklistSubmissionsLocalData,
      PrefetchHooks Function()
    >;
typedef $$ChecklistAnswersLocalTableCreateCompanionBuilder =
    ChecklistAnswersLocalCompanion Function({
      required String id,
      required String submissionId,
      required String questionId,
      required String answerValue,
      Value<String?> photoUrl,
      Value<String?> signatureUrl,
      Value<bool> isFailedCritical,
      Value<int> rowid,
    });
typedef $$ChecklistAnswersLocalTableUpdateCompanionBuilder =
    ChecklistAnswersLocalCompanion Function({
      Value<String> id,
      Value<String> submissionId,
      Value<String> questionId,
      Value<String> answerValue,
      Value<String?> photoUrl,
      Value<String?> signatureUrl,
      Value<bool> isFailedCritical,
      Value<int> rowid,
    });

class $$ChecklistAnswersLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $ChecklistAnswersLocalTable> {
  $$ChecklistAnswersLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get submissionId => $composableBuilder(
    column: $table.submissionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answerValue => $composableBuilder(
    column: $table.answerValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signatureUrl => $composableBuilder(
    column: $table.signatureUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFailedCritical => $composableBuilder(
    column: $table.isFailedCritical,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistAnswersLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $ChecklistAnswersLocalTable> {
  $$ChecklistAnswersLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get submissionId => $composableBuilder(
    column: $table.submissionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answerValue => $composableBuilder(
    column: $table.answerValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signatureUrl => $composableBuilder(
    column: $table.signatureUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFailedCritical => $composableBuilder(
    column: $table.isFailedCritical,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistAnswersLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ChecklistAnswersLocalTable> {
  $$ChecklistAnswersLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get submissionId => $composableBuilder(
    column: $table.submissionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answerValue => $composableBuilder(
    column: $table.answerValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get signatureUrl => $composableBuilder(
    column: $table.signatureUrl,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFailedCritical => $composableBuilder(
    column: $table.isFailedCritical,
    builder: (column) => column,
  );
}

class $$ChecklistAnswersLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ChecklistAnswersLocalTable,
          ChecklistAnswersLocalData,
          $$ChecklistAnswersLocalTableFilterComposer,
          $$ChecklistAnswersLocalTableOrderingComposer,
          $$ChecklistAnswersLocalTableAnnotationComposer,
          $$ChecklistAnswersLocalTableCreateCompanionBuilder,
          $$ChecklistAnswersLocalTableUpdateCompanionBuilder,
          (
            ChecklistAnswersLocalData,
            BaseReferences<
              _$LocalDatabase,
              $ChecklistAnswersLocalTable,
              ChecklistAnswersLocalData
            >,
          ),
          ChecklistAnswersLocalData,
          PrefetchHooks Function()
        > {
  $$ChecklistAnswersLocalTableTableManager(
    _$LocalDatabase db,
    $ChecklistAnswersLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistAnswersLocalTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ChecklistAnswersLocalTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChecklistAnswersLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> submissionId = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<String> answerValue = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> signatureUrl = const Value.absent(),
                Value<bool> isFailedCritical = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistAnswersLocalCompanion(
                id: id,
                submissionId: submissionId,
                questionId: questionId,
                answerValue: answerValue,
                photoUrl: photoUrl,
                signatureUrl: signatureUrl,
                isFailedCritical: isFailedCritical,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String submissionId,
                required String questionId,
                required String answerValue,
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> signatureUrl = const Value.absent(),
                Value<bool> isFailedCritical = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistAnswersLocalCompanion.insert(
                id: id,
                submissionId: submissionId,
                questionId: questionId,
                answerValue: answerValue,
                photoUrl: photoUrl,
                signatureUrl: signatureUrl,
                isFailedCritical: isFailedCritical,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistAnswersLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ChecklistAnswersLocalTable,
      ChecklistAnswersLocalData,
      $$ChecklistAnswersLocalTableFilterComposer,
      $$ChecklistAnswersLocalTableOrderingComposer,
      $$ChecklistAnswersLocalTableAnnotationComposer,
      $$ChecklistAnswersLocalTableCreateCompanionBuilder,
      $$ChecklistAnswersLocalTableUpdateCompanionBuilder,
      (
        ChecklistAnswersLocalData,
        BaseReferences<
          _$LocalDatabase,
          $ChecklistAnswersLocalTable,
          ChecklistAnswersLocalData
        >,
      ),
      ChecklistAnswersLocalData,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsLocalTableCreateCompanionBuilder =
    AuditLogsLocalCompanion Function({
      required String id,
      required String action,
      Value<DateTime> timestamp,
      Value<String?> deviceInfo,
      Value<double?> gpsLat,
      Value<double?> gpsLon,
      required String payload,
      Value<int> rowid,
    });
typedef $$AuditLogsLocalTableUpdateCompanionBuilder =
    AuditLogsLocalCompanion Function({
      Value<String> id,
      Value<String> action,
      Value<DateTime> timestamp,
      Value<String?> deviceInfo,
      Value<double?> gpsLat,
      Value<double?> gpsLon,
      Value<String> payload,
      Value<int> rowid,
    });

class $$AuditLogsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $AuditLogsLocalTable> {
  $$AuditLogsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceInfo => $composableBuilder(
    column: $table.deviceInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsLat => $composableBuilder(
    column: $table.gpsLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gpsLon => $composableBuilder(
    column: $table.gpsLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $AuditLogsLocalTable> {
  $$AuditLogsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceInfo => $composableBuilder(
    column: $table.deviceInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsLat => $composableBuilder(
    column: $table.gpsLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gpsLon => $composableBuilder(
    column: $table.gpsLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $AuditLogsLocalTable> {
  $$AuditLogsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get deviceInfo => $composableBuilder(
    column: $table.deviceInfo,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gpsLat =>
      $composableBuilder(column: $table.gpsLat, builder: (column) => column);

  GeneratedColumn<double> get gpsLon =>
      $composableBuilder(column: $table.gpsLon, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);
}

class $$AuditLogsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $AuditLogsLocalTable,
          AuditLogsLocalData,
          $$AuditLogsLocalTableFilterComposer,
          $$AuditLogsLocalTableOrderingComposer,
          $$AuditLogsLocalTableAnnotationComposer,
          $$AuditLogsLocalTableCreateCompanionBuilder,
          $$AuditLogsLocalTableUpdateCompanionBuilder,
          (
            AuditLogsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $AuditLogsLocalTable,
              AuditLogsLocalData
            >,
          ),
          AuditLogsLocalData,
          PrefetchHooks Function()
        > {
  $$AuditLogsLocalTableTableManager(
    _$LocalDatabase db,
    $AuditLogsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> deviceInfo = const Value.absent(),
                Value<double?> gpsLat = const Value.absent(),
                Value<double?> gpsLon = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsLocalCompanion(
                id: id,
                action: action,
                timestamp: timestamp,
                deviceInfo: deviceInfo,
                gpsLat: gpsLat,
                gpsLon: gpsLon,
                payload: payload,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String action,
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> deviceInfo = const Value.absent(),
                Value<double?> gpsLat = const Value.absent(),
                Value<double?> gpsLon = const Value.absent(),
                required String payload,
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsLocalCompanion.insert(
                id: id,
                action: action,
                timestamp: timestamp,
                deviceInfo: deviceInfo,
                gpsLat: gpsLat,
                gpsLon: gpsLon,
                payload: payload,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $AuditLogsLocalTable,
      AuditLogsLocalData,
      $$AuditLogsLocalTableFilterComposer,
      $$AuditLogsLocalTableOrderingComposer,
      $$AuditLogsLocalTableAnnotationComposer,
      $$AuditLogsLocalTableCreateCompanionBuilder,
      $$AuditLogsLocalTableUpdateCompanionBuilder,
      (
        AuditLogsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $AuditLogsLocalTable,
          AuditLogsLocalData
        >,
      ),
      AuditLogsLocalData,
      PrefetchHooks Function()
    >;
typedef $$WorkerDocumentsLocalTableCreateCompanionBuilder =
    WorkerDocumentsLocalCompanion Function({
      required String id,
      required String documentType,
      required String emissionDate,
      required String expiryDate,
      Value<String?> fileUrl,
      Value<int> rowid,
    });
typedef $$WorkerDocumentsLocalTableUpdateCompanionBuilder =
    WorkerDocumentsLocalCompanion Function({
      Value<String> id,
      Value<String> documentType,
      Value<String> emissionDate,
      Value<String> expiryDate,
      Value<String?> fileUrl,
      Value<int> rowid,
    });

class $$WorkerDocumentsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $WorkerDocumentsLocalTable> {
  $$WorkerDocumentsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileUrl => $composableBuilder(
    column: $table.fileUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkerDocumentsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $WorkerDocumentsLocalTable> {
  $$WorkerDocumentsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileUrl => $composableBuilder(
    column: $table.fileUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkerDocumentsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $WorkerDocumentsLocalTable> {
  $$WorkerDocumentsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);
}

class $$WorkerDocumentsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $WorkerDocumentsLocalTable,
          WorkerDocumentsLocalData,
          $$WorkerDocumentsLocalTableFilterComposer,
          $$WorkerDocumentsLocalTableOrderingComposer,
          $$WorkerDocumentsLocalTableAnnotationComposer,
          $$WorkerDocumentsLocalTableCreateCompanionBuilder,
          $$WorkerDocumentsLocalTableUpdateCompanionBuilder,
          (
            WorkerDocumentsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $WorkerDocumentsLocalTable,
              WorkerDocumentsLocalData
            >,
          ),
          WorkerDocumentsLocalData,
          PrefetchHooks Function()
        > {
  $$WorkerDocumentsLocalTableTableManager(
    _$LocalDatabase db,
    $WorkerDocumentsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkerDocumentsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkerDocumentsLocalTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkerDocumentsLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> documentType = const Value.absent(),
                Value<String> emissionDate = const Value.absent(),
                Value<String> expiryDate = const Value.absent(),
                Value<String?> fileUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkerDocumentsLocalCompanion(
                id: id,
                documentType: documentType,
                emissionDate: emissionDate,
                expiryDate: expiryDate,
                fileUrl: fileUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String documentType,
                required String emissionDate,
                required String expiryDate,
                Value<String?> fileUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkerDocumentsLocalCompanion.insert(
                id: id,
                documentType: documentType,
                emissionDate: emissionDate,
                expiryDate: expiryDate,
                fileUrl: fileUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkerDocumentsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $WorkerDocumentsLocalTable,
      WorkerDocumentsLocalData,
      $$WorkerDocumentsLocalTableFilterComposer,
      $$WorkerDocumentsLocalTableOrderingComposer,
      $$WorkerDocumentsLocalTableAnnotationComposer,
      $$WorkerDocumentsLocalTableCreateCompanionBuilder,
      $$WorkerDocumentsLocalTableUpdateCompanionBuilder,
      (
        WorkerDocumentsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $WorkerDocumentsLocalTable,
          WorkerDocumentsLocalData
        >,
      ),
      WorkerDocumentsLocalData,
      PrefetchHooks Function()
    >;
typedef $$VehiclesLocalTableCreateCompanionBuilder =
    VehiclesLocalCompanion Function({
      required String id,
      required String plateNumber,
      required String brand,
      required String model,
      required int year,
      required int lastOdometer,
      required String qrCodeToken,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$VehiclesLocalTableUpdateCompanionBuilder =
    VehiclesLocalCompanion Function({
      Value<String> id,
      Value<String> plateNumber,
      Value<String> brand,
      Value<String> model,
      Value<int> year,
      Value<int> lastOdometer,
      Value<String> qrCodeToken,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$VehiclesLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $VehiclesLocalTable> {
  $$VehiclesLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastOdometer => $composableBuilder(
    column: $table.lastOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qrCodeToken => $composableBuilder(
    column: $table.qrCodeToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VehiclesLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $VehiclesLocalTable> {
  $$VehiclesLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastOdometer => $composableBuilder(
    column: $table.lastOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qrCodeToken => $composableBuilder(
    column: $table.qrCodeToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiclesLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $VehiclesLocalTable> {
  $$VehiclesLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get lastOdometer => $composableBuilder(
    column: $table.lastOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qrCodeToken => $composableBuilder(
    column: $table.qrCodeToken,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$VehiclesLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $VehiclesLocalTable,
          VehiclesLocalData,
          $$VehiclesLocalTableFilterComposer,
          $$VehiclesLocalTableOrderingComposer,
          $$VehiclesLocalTableAnnotationComposer,
          $$VehiclesLocalTableCreateCompanionBuilder,
          $$VehiclesLocalTableUpdateCompanionBuilder,
          (
            VehiclesLocalData,
            BaseReferences<
              _$LocalDatabase,
              $VehiclesLocalTable,
              VehiclesLocalData
            >,
          ),
          VehiclesLocalData,
          PrefetchHooks Function()
        > {
  $$VehiclesLocalTableTableManager(
    _$LocalDatabase db,
    $VehiclesLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> plateNumber = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> lastOdometer = const Value.absent(),
                Value<String> qrCodeToken = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesLocalCompanion(
                id: id,
                plateNumber: plateNumber,
                brand: brand,
                model: model,
                year: year,
                lastOdometer: lastOdometer,
                qrCodeToken: qrCodeToken,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String plateNumber,
                required String brand,
                required String model,
                required int year,
                required int lastOdometer,
                required String qrCodeToken,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesLocalCompanion.insert(
                id: id,
                plateNumber: plateNumber,
                brand: brand,
                model: model,
                year: year,
                lastOdometer: lastOdometer,
                qrCodeToken: qrCodeToken,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VehiclesLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $VehiclesLocalTable,
      VehiclesLocalData,
      $$VehiclesLocalTableFilterComposer,
      $$VehiclesLocalTableOrderingComposer,
      $$VehiclesLocalTableAnnotationComposer,
      $$VehiclesLocalTableCreateCompanionBuilder,
      $$VehiclesLocalTableUpdateCompanionBuilder,
      (
        VehiclesLocalData,
        BaseReferences<_$LocalDatabase, $VehiclesLocalTable, VehiclesLocalData>,
      ),
      VehiclesLocalData,
      PrefetchHooks Function()
    >;
typedef $$VehicleDocumentsLocalTableCreateCompanionBuilder =
    VehicleDocumentsLocalCompanion Function({
      required String id,
      required String vehicleId,
      required String documentType,
      required String emissionDate,
      required String expiryDate,
      Value<String?> fileUrl,
      Value<int> rowid,
    });
typedef $$VehicleDocumentsLocalTableUpdateCompanionBuilder =
    VehicleDocumentsLocalCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<String> documentType,
      Value<String> emissionDate,
      Value<String> expiryDate,
      Value<String?> fileUrl,
      Value<int> rowid,
    });

class $$VehicleDocumentsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $VehicleDocumentsLocalTable> {
  $$VehicleDocumentsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileUrl => $composableBuilder(
    column: $table.fileUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VehicleDocumentsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $VehicleDocumentsLocalTable> {
  $$VehicleDocumentsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileUrl => $composableBuilder(
    column: $table.fileUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehicleDocumentsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $VehicleDocumentsLocalTable> {
  $$VehicleDocumentsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
    column: $table.documentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emissionDate => $composableBuilder(
    column: $table.emissionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);
}

class $$VehicleDocumentsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $VehicleDocumentsLocalTable,
          VehicleDocumentsLocalData,
          $$VehicleDocumentsLocalTableFilterComposer,
          $$VehicleDocumentsLocalTableOrderingComposer,
          $$VehicleDocumentsLocalTableAnnotationComposer,
          $$VehicleDocumentsLocalTableCreateCompanionBuilder,
          $$VehicleDocumentsLocalTableUpdateCompanionBuilder,
          (
            VehicleDocumentsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $VehicleDocumentsLocalTable,
              VehicleDocumentsLocalData
            >,
          ),
          VehicleDocumentsLocalData,
          PrefetchHooks Function()
        > {
  $$VehicleDocumentsLocalTableTableManager(
    _$LocalDatabase db,
    $VehicleDocumentsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehicleDocumentsLocalTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$VehicleDocumentsLocalTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$VehicleDocumentsLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> documentType = const Value.absent(),
                Value<String> emissionDate = const Value.absent(),
                Value<String> expiryDate = const Value.absent(),
                Value<String?> fileUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleDocumentsLocalCompanion(
                id: id,
                vehicleId: vehicleId,
                documentType: documentType,
                emissionDate: emissionDate,
                expiryDate: expiryDate,
                fileUrl: fileUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String documentType,
                required String emissionDate,
                required String expiryDate,
                Value<String?> fileUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehicleDocumentsLocalCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                documentType: documentType,
                emissionDate: emissionDate,
                expiryDate: expiryDate,
                fileUrl: fileUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VehicleDocumentsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $VehicleDocumentsLocalTable,
      VehicleDocumentsLocalData,
      $$VehicleDocumentsLocalTableFilterComposer,
      $$VehicleDocumentsLocalTableOrderingComposer,
      $$VehicleDocumentsLocalTableAnnotationComposer,
      $$VehicleDocumentsLocalTableCreateCompanionBuilder,
      $$VehicleDocumentsLocalTableUpdateCompanionBuilder,
      (
        VehicleDocumentsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $VehicleDocumentsLocalTable,
          VehicleDocumentsLocalData
        >,
      ),
      VehicleDocumentsLocalData,
      PrefetchHooks Function()
    >;
typedef $$ChecklistsLocalTableCreateCompanionBuilder =
    ChecklistsLocalCompanion Function({
      required String id,
      required String title,
      Value<String?> description,
      required int version,
      Value<int> rowid,
    });
typedef $$ChecklistsLocalTableUpdateCompanionBuilder =
    ChecklistsLocalCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<int> version,
      Value<int> rowid,
    });

class $$ChecklistsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $ChecklistsLocalTable> {
  $$ChecklistsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $ChecklistsLocalTable> {
  $$ChecklistsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ChecklistsLocalTable> {
  $$ChecklistsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$ChecklistsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ChecklistsLocalTable,
          ChecklistsLocalData,
          $$ChecklistsLocalTableFilterComposer,
          $$ChecklistsLocalTableOrderingComposer,
          $$ChecklistsLocalTableAnnotationComposer,
          $$ChecklistsLocalTableCreateCompanionBuilder,
          $$ChecklistsLocalTableUpdateCompanionBuilder,
          (
            ChecklistsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $ChecklistsLocalTable,
              ChecklistsLocalData
            >,
          ),
          ChecklistsLocalData,
          PrefetchHooks Function()
        > {
  $$ChecklistsLocalTableTableManager(
    _$LocalDatabase db,
    $ChecklistsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistsLocalCompanion(
                id: id,
                title: title,
                description: description,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> description = const Value.absent(),
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => ChecklistsLocalCompanion.insert(
                id: id,
                title: title,
                description: description,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ChecklistsLocalTable,
      ChecklistsLocalData,
      $$ChecklistsLocalTableFilterComposer,
      $$ChecklistsLocalTableOrderingComposer,
      $$ChecklistsLocalTableAnnotationComposer,
      $$ChecklistsLocalTableCreateCompanionBuilder,
      $$ChecklistsLocalTableUpdateCompanionBuilder,
      (
        ChecklistsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $ChecklistsLocalTable,
          ChecklistsLocalData
        >,
      ),
      ChecklistsLocalData,
      PrefetchHooks Function()
    >;
typedef $$ChecklistQuestionsLocalTableCreateCompanionBuilder =
    ChecklistQuestionsLocalCompanion Function({
      required String id,
      required String checklistId,
      required String questionText,
      required String questionType,
      Value<bool> isRequired,
      Value<bool> isCritical,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$ChecklistQuestionsLocalTableUpdateCompanionBuilder =
    ChecklistQuestionsLocalCompanion Function({
      Value<String> id,
      Value<String> checklistId,
      Value<String> questionText,
      Value<String> questionType,
      Value<bool> isRequired,
      Value<bool> isCritical,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$ChecklistQuestionsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $ChecklistQuestionsLocalTable> {
  $$ChecklistQuestionsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checklistId => $composableBuilder(
    column: $table.checklistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionText => $composableBuilder(
    column: $table.questionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistQuestionsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $ChecklistQuestionsLocalTable> {
  $$ChecklistQuestionsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checklistId => $composableBuilder(
    column: $table.checklistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionText => $composableBuilder(
    column: $table.questionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistQuestionsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ChecklistQuestionsLocalTable> {
  $$ChecklistQuestionsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get checklistId => $composableBuilder(
    column: $table.checklistId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionText => $composableBuilder(
    column: $table.questionText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$ChecklistQuestionsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ChecklistQuestionsLocalTable,
          ChecklistQuestionsLocalData,
          $$ChecklistQuestionsLocalTableFilterComposer,
          $$ChecklistQuestionsLocalTableOrderingComposer,
          $$ChecklistQuestionsLocalTableAnnotationComposer,
          $$ChecklistQuestionsLocalTableCreateCompanionBuilder,
          $$ChecklistQuestionsLocalTableUpdateCompanionBuilder,
          (
            ChecklistQuestionsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $ChecklistQuestionsLocalTable,
              ChecklistQuestionsLocalData
            >,
          ),
          ChecklistQuestionsLocalData,
          PrefetchHooks Function()
        > {
  $$ChecklistQuestionsLocalTableTableManager(
    _$LocalDatabase db,
    $ChecklistQuestionsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistQuestionsLocalTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ChecklistQuestionsLocalTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChecklistQuestionsLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> checklistId = const Value.absent(),
                Value<String> questionText = const Value.absent(),
                Value<String> questionType = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<bool> isCritical = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistQuestionsLocalCompanion(
                id: id,
                checklistId: checklistId,
                questionText: questionText,
                questionType: questionType,
                isRequired: isRequired,
                isCritical: isCritical,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String checklistId,
                required String questionText,
                required String questionType,
                Value<bool> isRequired = const Value.absent(),
                Value<bool> isCritical = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => ChecklistQuestionsLocalCompanion.insert(
                id: id,
                checklistId: checklistId,
                questionText: questionText,
                questionType: questionType,
                isRequired: isRequired,
                isCritical: isCritical,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistQuestionsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ChecklistQuestionsLocalTable,
      ChecklistQuestionsLocalData,
      $$ChecklistQuestionsLocalTableFilterComposer,
      $$ChecklistQuestionsLocalTableOrderingComposer,
      $$ChecklistQuestionsLocalTableAnnotationComposer,
      $$ChecklistQuestionsLocalTableCreateCompanionBuilder,
      $$ChecklistQuestionsLocalTableUpdateCompanionBuilder,
      (
        ChecklistQuestionsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $ChecklistQuestionsLocalTable,
          ChecklistQuestionsLocalData
        >,
      ),
      ChecklistQuestionsLocalData,
      PrefetchHooks Function()
    >;
typedef $$ChecklistQuestionOptionsLocalTableCreateCompanionBuilder =
    ChecklistQuestionOptionsLocalCompanion Function({
      required String id,
      required String questionId,
      required String optionText,
      Value<bool> isCriticalTrigger,
      Value<int> rowid,
    });
typedef $$ChecklistQuestionOptionsLocalTableUpdateCompanionBuilder =
    ChecklistQuestionOptionsLocalCompanion Function({
      Value<String> id,
      Value<String> questionId,
      Value<String> optionText,
      Value<bool> isCriticalTrigger,
      Value<int> rowid,
    });

class $$ChecklistQuestionOptionsLocalTableFilterComposer
    extends Composer<_$LocalDatabase, $ChecklistQuestionOptionsLocalTable> {
  $$ChecklistQuestionOptionsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCriticalTrigger => $composableBuilder(
    column: $table.isCriticalTrigger,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChecklistQuestionOptionsLocalTableOrderingComposer
    extends Composer<_$LocalDatabase, $ChecklistQuestionOptionsLocalTable> {
  $$ChecklistQuestionOptionsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCriticalTrigger => $composableBuilder(
    column: $table.isCriticalTrigger,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChecklistQuestionOptionsLocalTableAnnotationComposer
    extends Composer<_$LocalDatabase, $ChecklistQuestionOptionsLocalTable> {
  $$ChecklistQuestionOptionsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCriticalTrigger => $composableBuilder(
    column: $table.isCriticalTrigger,
    builder: (column) => column,
  );
}

class $$ChecklistQuestionOptionsLocalTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $ChecklistQuestionOptionsLocalTable,
          ChecklistQuestionOptionsLocalData,
          $$ChecklistQuestionOptionsLocalTableFilterComposer,
          $$ChecklistQuestionOptionsLocalTableOrderingComposer,
          $$ChecklistQuestionOptionsLocalTableAnnotationComposer,
          $$ChecklistQuestionOptionsLocalTableCreateCompanionBuilder,
          $$ChecklistQuestionOptionsLocalTableUpdateCompanionBuilder,
          (
            ChecklistQuestionOptionsLocalData,
            BaseReferences<
              _$LocalDatabase,
              $ChecklistQuestionOptionsLocalTable,
              ChecklistQuestionOptionsLocalData
            >,
          ),
          ChecklistQuestionOptionsLocalData,
          PrefetchHooks Function()
        > {
  $$ChecklistQuestionOptionsLocalTableTableManager(
    _$LocalDatabase db,
    $ChecklistQuestionOptionsLocalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistQuestionOptionsLocalTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ChecklistQuestionOptionsLocalTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ChecklistQuestionOptionsLocalTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<String> optionText = const Value.absent(),
                Value<bool> isCriticalTrigger = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistQuestionOptionsLocalCompanion(
                id: id,
                questionId: questionId,
                optionText: optionText,
                isCriticalTrigger: isCriticalTrigger,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String questionId,
                required String optionText,
                Value<bool> isCriticalTrigger = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChecklistQuestionOptionsLocalCompanion.insert(
                id: id,
                questionId: questionId,
                optionText: optionText,
                isCriticalTrigger: isCriticalTrigger,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChecklistQuestionOptionsLocalTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $ChecklistQuestionOptionsLocalTable,
      ChecklistQuestionOptionsLocalData,
      $$ChecklistQuestionOptionsLocalTableFilterComposer,
      $$ChecklistQuestionOptionsLocalTableOrderingComposer,
      $$ChecklistQuestionOptionsLocalTableAnnotationComposer,
      $$ChecklistQuestionOptionsLocalTableCreateCompanionBuilder,
      $$ChecklistQuestionOptionsLocalTableUpdateCompanionBuilder,
      (
        ChecklistQuestionOptionsLocalData,
        BaseReferences<
          _$LocalDatabase,
          $ChecklistQuestionOptionsLocalTable,
          ChecklistQuestionOptionsLocalData
        >,
      ),
      ChecklistQuestionOptionsLocalData,
      PrefetchHooks Function()
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$RoutesLocalTableTableManager get routesLocal =>
      $$RoutesLocalTableTableManager(_db, _db.routesLocal);
  $$RoutePointsLocalTableTableManager get routePointsLocal =>
      $$RoutePointsLocalTableTableManager(_db, _db.routePointsLocal);
  $$RoutePointVisitsLocalTableTableManager get routePointVisitsLocal =>
      $$RoutePointVisitsLocalTableTableManager(_db, _db.routePointVisitsLocal);
  $$ChecklistSubmissionsLocalTableTableManager get checklistSubmissionsLocal =>
      $$ChecklistSubmissionsLocalTableTableManager(
        _db,
        _db.checklistSubmissionsLocal,
      );
  $$ChecklistAnswersLocalTableTableManager get checklistAnswersLocal =>
      $$ChecklistAnswersLocalTableTableManager(_db, _db.checklistAnswersLocal);
  $$AuditLogsLocalTableTableManager get auditLogsLocal =>
      $$AuditLogsLocalTableTableManager(_db, _db.auditLogsLocal);
  $$WorkerDocumentsLocalTableTableManager get workerDocumentsLocal =>
      $$WorkerDocumentsLocalTableTableManager(_db, _db.workerDocumentsLocal);
  $$VehiclesLocalTableTableManager get vehiclesLocal =>
      $$VehiclesLocalTableTableManager(_db, _db.vehiclesLocal);
  $$VehicleDocumentsLocalTableTableManager get vehicleDocumentsLocal =>
      $$VehicleDocumentsLocalTableTableManager(_db, _db.vehicleDocumentsLocal);
  $$ChecklistsLocalTableTableManager get checklistsLocal =>
      $$ChecklistsLocalTableTableManager(_db, _db.checklistsLocal);
  $$ChecklistQuestionsLocalTableTableManager get checklistQuestionsLocal =>
      $$ChecklistQuestionsLocalTableTableManager(
        _db,
        _db.checklistQuestionsLocal,
      );
  $$ChecklistQuestionOptionsLocalTableTableManager
  get checklistQuestionOptionsLocal =>
      $$ChecklistQuestionOptionsLocalTableTableManager(
        _db,
        _db.checklistQuestionOptionsLocal,
      );
}
