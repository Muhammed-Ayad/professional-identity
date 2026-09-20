/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:professional_identity_server/src/generated/protocol.dart'
    as _idwwx28q;
import 'package:serverpod/serverpod.dart' as _is;
import '../profile/profile.dart' as _i1157qfm;

abstract class ProfileAnalyticsEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ProfileAnalyticsEvent._({
    this.id,
    required this.profileId,
    this.profile,
    required this.eventType,
    this.target,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ProfileAnalyticsEvent({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String eventType,
    String? target,
    DateTime? createdAt,
  }) = _ProfileAnalyticsEventImpl;

  factory ProfileAnalyticsEvent.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProfileAnalyticsEvent(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      eventType: jsonSerialization['eventType'] as String,
      target: jsonSerialization['target'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ProfileAnalyticsEventTable();

  static const db = ProfileAnalyticsEventRepository._();

  @override
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String eventType;

  String? target;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProfileAnalyticsEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProfileAnalyticsEvent copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? eventType,
    String? target,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileAnalyticsEvent',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'eventType': eventType,
      if (target != null) 'target': target,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileAnalyticsEvent',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'eventType': eventType,
      if (target != null) 'target': target,
      'createdAt': createdAt.toJson(),
    };
  }

  static ProfileAnalyticsEventInclude include({
    _i1157qfm.ProfileInclude? profile,
  }) {
    return ProfileAnalyticsEventInclude._(profile: profile);
  }

  static ProfileAnalyticsEventIncludeList includeList({
    _is.WhereExpressionBuilder<ProfileAnalyticsEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileAnalyticsEventTable>? orderBy,
    _is.OrderByListBuilder<ProfileAnalyticsEventTable>? orderByList,
    ProfileAnalyticsEventInclude? include,
  }) {
    return ProfileAnalyticsEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProfileAnalyticsEvent.t),
      orderByList: orderByList?.call(ProfileAnalyticsEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileAnalyticsEventImpl extends ProfileAnalyticsEvent {
  _ProfileAnalyticsEventImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String eventType,
    String? target,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         eventType: eventType,
         target: target,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProfileAnalyticsEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProfileAnalyticsEvent copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? eventType,
    Object? target = _Undefined,
    DateTime? createdAt,
  }) {
    return ProfileAnalyticsEvent(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      eventType: eventType ?? this.eventType,
      target: target is String? ? target : this.target,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ProfileAnalyticsEventUpdateTable
    extends _is.UpdateTable<ProfileAnalyticsEventTable> {
  ProfileAnalyticsEventUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> eventType(String value) => _is.ColumnValue(
    table.eventType,
    value,
  );

  _is.ColumnValue<String, String> target(String? value) => _is.ColumnValue(
    table.target,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ProfileAnalyticsEventTable extends _is.Table<int?> {
  ProfileAnalyticsEventTable({super.tableRelation})
    : super(tableName: 'profile_analytics_event') {
    updateTable = ProfileAnalyticsEventUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    eventType = _is.ColumnString(
      'eventType',
      this,
    );
    target = _is.ColumnString(
      'target',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ProfileAnalyticsEventUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  _i1157qfm.ProfileTable? _profile;

  late final _is.ColumnString eventType;

  late final _is.ColumnString target;

  late final _is.ColumnDateTime createdAt;

  _i1157qfm.ProfileTable get profile {
    if (_profile != null) return _profile!;
    _profile = _is.createRelationTable(
      relationFieldName: 'profile',
      field: ProfileAnalyticsEvent.t.profileId,
      foreignField: _i1157qfm.Profile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i1157qfm.ProfileTable(tableRelation: foreignTableRelation),
    );
    return _profile!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    profileId,
    eventType,
    target,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'profile') {
      return profile;
    }
    return null;
  }
}

class ProfileAnalyticsEventInclude extends _is.IncludeObject {
  ProfileAnalyticsEventInclude._({_i1157qfm.ProfileInclude? profile}) {
    _profile = profile;
  }

  _i1157qfm.ProfileInclude? _profile;

  @override
  Map<String, _is.Include?> get includes => {'profile': _profile};

  @override
  _is.Table<int?> get table => ProfileAnalyticsEvent.t;
}

class ProfileAnalyticsEventIncludeList extends _is.IncludeList {
  ProfileAnalyticsEventIncludeList._({
    _is.WhereExpressionBuilder<ProfileAnalyticsEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProfileAnalyticsEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ProfileAnalyticsEvent.t;
}

class ProfileAnalyticsEventRepository {
  const ProfileAnalyticsEventRepository._();

  final attachRow = const ProfileAnalyticsEventAttachRowRepository._();

  /// Returns a list of [ProfileAnalyticsEvent]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ProfileAnalyticsEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileAnalyticsEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileAnalyticsEventTable>? orderBy,
    _is.OrderByListBuilder<ProfileAnalyticsEventTable>? orderByList,
    _is.Transaction? transaction,
    ProfileAnalyticsEventInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProfileAnalyticsEvent>(
      where: where?.call(ProfileAnalyticsEvent.t),
      orderBy: orderBy?.call(ProfileAnalyticsEvent.t),
      orderByList: orderByList?.call(ProfileAnalyticsEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProfileAnalyticsEvent] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ProfileAnalyticsEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileAnalyticsEventTable>? where,
    int? offset,
    _is.OrderByBuilder<ProfileAnalyticsEventTable>? orderBy,
    _is.OrderByListBuilder<ProfileAnalyticsEventTable>? orderByList,
    _is.Transaction? transaction,
    ProfileAnalyticsEventInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProfileAnalyticsEvent>(
      where: where?.call(ProfileAnalyticsEvent.t),
      orderBy: orderBy?.call(ProfileAnalyticsEvent.t),
      orderByList: orderByList?.call(ProfileAnalyticsEvent.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProfileAnalyticsEvent] by its [id] or null if no such row exists.
  Future<ProfileAnalyticsEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ProfileAnalyticsEventInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProfileAnalyticsEvent>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProfileAnalyticsEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [ProfileAnalyticsEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileAnalyticsEvent>> insert(
    _is.DatabaseSession session,
    List<ProfileAnalyticsEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ProfileAnalyticsEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ProfileAnalyticsEvent] and returns the inserted row.
  ///
  /// The returned [ProfileAnalyticsEvent] will have its `id` field set.
  Future<ProfileAnalyticsEvent> insertRow(
    _is.DatabaseSession session,
    ProfileAnalyticsEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProfileAnalyticsEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ProfileAnalyticsEvent]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ProfileAnalyticsEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileAnalyticsEvent>> upsert(
    _is.DatabaseSession session,
    List<ProfileAnalyticsEvent> rows, {
    required _is.ColumnSelections<ProfileAnalyticsEventTable> conflictColumns,
    _is.ColumnSelections<ProfileAnalyticsEventTable>? updateColumns,
    _is.WhereExpressionBuilder<ProfileAnalyticsEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ProfileAnalyticsEvent>(
      rows,
      conflictColumns: conflictColumns(ProfileAnalyticsEvent.t),
      updateColumns: updateColumns?.call(ProfileAnalyticsEvent.t),
      updateWhere: updateWhere?.call(ProfileAnalyticsEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ProfileAnalyticsEvent] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ProfileAnalyticsEvent] will have its `id` field set.
  Future<ProfileAnalyticsEvent?> upsertRow(
    _is.DatabaseSession session,
    ProfileAnalyticsEvent row, {
    required _is.ColumnSelections<ProfileAnalyticsEventTable> conflictColumns,
    _is.ColumnSelections<ProfileAnalyticsEventTable>? updateColumns,
    _is.WhereExpressionBuilder<ProfileAnalyticsEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ProfileAnalyticsEvent>(
      row,
      conflictColumns: conflictColumns(ProfileAnalyticsEvent.t),
      updateColumns: updateColumns?.call(ProfileAnalyticsEvent.t),
      updateWhere: updateWhere?.call(ProfileAnalyticsEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [ProfileAnalyticsEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileAnalyticsEvent>> update(
    _is.DatabaseSession session,
    List<ProfileAnalyticsEvent> rows, {
    _is.ColumnSelections<ProfileAnalyticsEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ProfileAnalyticsEvent>(
      rows,
      columns: columns?.call(ProfileAnalyticsEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ProfileAnalyticsEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProfileAnalyticsEvent> updateRow(
    _is.DatabaseSession session,
    ProfileAnalyticsEvent row, {
    _is.ColumnSelections<ProfileAnalyticsEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProfileAnalyticsEvent>(
      row,
      columns: columns?.call(ProfileAnalyticsEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProfileAnalyticsEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProfileAnalyticsEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProfileAnalyticsEventUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ProfileAnalyticsEvent>(
      id,
      columnValues: columnValues(ProfileAnalyticsEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProfileAnalyticsEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileAnalyticsEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProfileAnalyticsEventUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ProfileAnalyticsEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileAnalyticsEventTable>? orderBy,
    _is.OrderByListBuilder<ProfileAnalyticsEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ProfileAnalyticsEvent>(
      columnValues: columnValues(ProfileAnalyticsEvent.t.updateTable),
      where: where(ProfileAnalyticsEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProfileAnalyticsEvent.t),
      orderByList: orderByList?.call(ProfileAnalyticsEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ProfileAnalyticsEvent]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileAnalyticsEvent>> delete(
    _is.DatabaseSession session,
    List<ProfileAnalyticsEvent> rows, {
    _is.OrderByBuilder<ProfileAnalyticsEventTable>? orderBy,
    _is.OrderByListBuilder<ProfileAnalyticsEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ProfileAnalyticsEvent>(
      rows,
      orderBy: orderBy?.call(ProfileAnalyticsEvent.t),
      orderByList: orderByList?.call(ProfileAnalyticsEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ProfileAnalyticsEvent].
  Future<ProfileAnalyticsEvent> deleteRow(
    _is.DatabaseSession session,
    ProfileAnalyticsEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProfileAnalyticsEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileAnalyticsEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProfileAnalyticsEventTable> where,
    _is.OrderByBuilder<ProfileAnalyticsEventTable>? orderBy,
    _is.OrderByListBuilder<ProfileAnalyticsEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ProfileAnalyticsEvent>(
      where: where(ProfileAnalyticsEvent.t),
      orderBy: orderBy?.call(ProfileAnalyticsEvent.t),
      orderByList: orderByList?.call(ProfileAnalyticsEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileAnalyticsEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ProfileAnalyticsEvent>(
      where: where?.call(ProfileAnalyticsEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProfileAnalyticsEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProfileAnalyticsEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProfileAnalyticsEvent>(
      where: where(ProfileAnalyticsEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ProfileAnalyticsEventAttachRowRepository {
  const ProfileAnalyticsEventAttachRowRepository._();

  /// Creates a relation between the given [ProfileAnalyticsEvent] and [Profile]
  /// by setting the [ProfileAnalyticsEvent]'s foreign key `profileId` to refer to the [Profile].
  Future<void> profile(
    _is.DatabaseSession session,
    ProfileAnalyticsEvent profileAnalyticsEvent,
    _i1157qfm.Profile profile, {
    _is.Transaction? transaction,
  }) async {
    if (profileAnalyticsEvent.id == null) {
      throw ArgumentError.notNull('profileAnalyticsEvent.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $profileAnalyticsEvent = profileAnalyticsEvent.copyWith(
      profileId: profile.id,
    );
    await session.db.updateRow<ProfileAnalyticsEvent>(
      $profileAnalyticsEvent,
      columns: [ProfileAnalyticsEvent.t.profileId],
      transaction: transaction,
    );
  }
}
