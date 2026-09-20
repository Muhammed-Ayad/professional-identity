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

abstract class Experience
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Experience._({
    this.id,
    required this.profileId,
    this.profile,
    required this.company,
    required this.jobTitle,
    required this.startDate,
    this.endDate,
    bool? isCurrent,
    this.description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isCurrent = isCurrent ?? false,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Experience({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String company,
    required String jobTitle,
    required DateTime startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ExperienceImpl;

  factory Experience.fromJson(Map<String, dynamic> jsonSerialization) {
    return Experience(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      company: jsonSerialization['company'] as String,
      jobTitle: jsonSerialization['jobTitle'] as String,
      startDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      isCurrent: jsonSerialization['isCurrent'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isCurrent']),
      description: jsonSerialization['description'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ExperienceTable();

  static const db = ExperienceRepository._();

  @override
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String company;

  String jobTitle;

  DateTime startDate;

  DateTime? endDate;

  bool isCurrent;

  String? description;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Experience copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? company,
    String? jobTitle,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Experience',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'company': company,
      'jobTitle': jobTitle,
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'isCurrent': isCurrent,
      if (description != null) 'description': description,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Experience',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'company': company,
      'jobTitle': jobTitle,
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'isCurrent': isCurrent,
      if (description != null) 'description': description,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ExperienceInclude include({_i1157qfm.ProfileInclude? profile}) {
    return ExperienceInclude._(profile: profile);
  }

  static ExperienceIncludeList includeList({
    _is.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExperienceTable>? orderBy,
    _is.OrderByListBuilder<ExperienceTable>? orderByList,
    ExperienceInclude? include,
  }) {
    return ExperienceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExperienceImpl extends Experience {
  _ExperienceImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String company,
    required String jobTitle,
    required DateTime startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         company: company,
         jobTitle: jobTitle,
         startDate: startDate,
         endDate: endDate,
         isCurrent: isCurrent,
         description: description,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Experience copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? company,
    String? jobTitle,
    DateTime? startDate,
    Object? endDate = _Undefined,
    bool? isCurrent,
    Object? description = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Experience(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      company: company ?? this.company,
      jobTitle: jobTitle ?? this.jobTitle,
      startDate: startDate ?? this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      description: description is String? ? description : this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ExperienceUpdateTable extends _is.UpdateTable<ExperienceTable> {
  ExperienceUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> company(String value) => _is.ColumnValue(
    table.company,
    value,
  );

  _is.ColumnValue<String, String> jobTitle(String value) => _is.ColumnValue(
    table.jobTitle,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startDate(DateTime value) =>
      _is.ColumnValue(
        table.startDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endDate(DateTime? value) =>
      _is.ColumnValue(
        table.endDate,
        value,
      );

  _is.ColumnValue<bool, bool> isCurrent(bool value) => _is.ColumnValue(
    table.isCurrent,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ExperienceTable extends _is.Table<int?> {
  ExperienceTable({super.tableRelation}) : super(tableName: 'experience') {
    updateTable = ExperienceUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    company = _is.ColumnString(
      'company',
      this,
    );
    jobTitle = _is.ColumnString(
      'jobTitle',
      this,
    );
    startDate = _is.ColumnDateTime(
      'startDate',
      this,
    );
    endDate = _is.ColumnDateTime(
      'endDate',
      this,
    );
    isCurrent = _is.ColumnBool(
      'isCurrent',
      this,
      hasDefault: true,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    sortOrder = _is.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ExperienceUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  _i1157qfm.ProfileTable? _profile;

  late final _is.ColumnString company;

  late final _is.ColumnString jobTitle;

  late final _is.ColumnDateTime startDate;

  late final _is.ColumnDateTime endDate;

  late final _is.ColumnBool isCurrent;

  late final _is.ColumnString description;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _i1157qfm.ProfileTable get profile {
    if (_profile != null) return _profile!;
    _profile = _is.createRelationTable(
      relationFieldName: 'profile',
      field: Experience.t.profileId,
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
    company,
    jobTitle,
    startDate,
    endDate,
    isCurrent,
    description,
    sortOrder,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'profile') {
      return profile;
    }
    return null;
  }
}

class ExperienceInclude extends _is.IncludeObject {
  ExperienceInclude._({_i1157qfm.ProfileInclude? profile}) {
    _profile = profile;
  }

  _i1157qfm.ProfileInclude? _profile;

  @override
  Map<String, _is.Include?> get includes => {'profile': _profile};

  @override
  _is.Table<int?> get table => Experience.t;
}

class ExperienceIncludeList extends _is.IncludeList {
  ExperienceIncludeList._({
    _is.WhereExpressionBuilder<ExperienceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Experience.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Experience.t;
}

class ExperienceRepository {
  const ExperienceRepository._();

  final attachRow = const ExperienceAttachRowRepository._();

  /// Returns a list of [Experience]s matching the given query parameters.
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
  Future<List<Experience>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExperienceTable>? orderBy,
    _is.OrderByListBuilder<ExperienceTable>? orderByList,
    _is.Transaction? transaction,
    ExperienceInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Experience>(
      where: where?.call(Experience.t),
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Experience] matching the given query parameters.
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
  Future<Experience?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExperienceTable>? where,
    int? offset,
    _is.OrderByBuilder<ExperienceTable>? orderBy,
    _is.OrderByListBuilder<ExperienceTable>? orderByList,
    _is.Transaction? transaction,
    ExperienceInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Experience>(
      where: where?.call(Experience.t),
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Experience] by its [id] or null if no such row exists.
  Future<Experience?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ExperienceInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Experience>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Experience]s in the list and returns the inserted rows.
  ///
  /// The returned [Experience]s will have their `id` fields set.
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
  Future<List<Experience>> insert(
    _is.DatabaseSession session,
    List<Experience> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Experience>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Experience] and returns the inserted row.
  ///
  /// The returned [Experience] will have its `id` field set.
  Future<Experience> insertRow(
    _is.DatabaseSession session,
    Experience row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Experience>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Experience]s in the list and returns the resulting rows.
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
  /// The returned [Experience]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Experience>> upsert(
    _is.DatabaseSession session,
    List<Experience> rows, {
    required _is.ColumnSelections<ExperienceTable> conflictColumns,
    _is.ColumnSelections<ExperienceTable>? updateColumns,
    _is.WhereExpressionBuilder<ExperienceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Experience>(
      rows,
      conflictColumns: conflictColumns(Experience.t),
      updateColumns: updateColumns?.call(Experience.t),
      updateWhere: updateWhere?.call(Experience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Experience] and returns the resulting row.
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
  /// The returned [Experience] will have its `id` field set.
  Future<Experience?> upsertRow(
    _is.DatabaseSession session,
    Experience row, {
    required _is.ColumnSelections<ExperienceTable> conflictColumns,
    _is.ColumnSelections<ExperienceTable>? updateColumns,
    _is.WhereExpressionBuilder<ExperienceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Experience>(
      row,
      conflictColumns: conflictColumns(Experience.t),
      updateColumns: updateColumns?.call(Experience.t),
      updateWhere: updateWhere?.call(Experience.t),
      transaction: transaction,
    );
  }

  /// Updates all [Experience]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Experience>> update(
    _is.DatabaseSession session,
    List<Experience> rows, {
    _is.ColumnSelections<ExperienceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Experience>(
      rows,
      columns: columns?.call(Experience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Experience]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Experience> updateRow(
    _is.DatabaseSession session,
    Experience row, {
    _is.ColumnSelections<ExperienceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Experience>(
      row,
      columns: columns?.call(Experience.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Experience] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Experience?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ExperienceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Experience>(
      id,
      columnValues: columnValues(Experience.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Experience]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Experience>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ExperienceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ExperienceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExperienceTable>? orderBy,
    _is.OrderByListBuilder<ExperienceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Experience>(
      columnValues: columnValues(Experience.t.updateTable),
      where: where(Experience.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Experience]s in the list and returns the deleted rows.
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
  Future<List<Experience>> delete(
    _is.DatabaseSession session,
    List<Experience> rows, {
    _is.OrderByBuilder<ExperienceTable>? orderBy,
    _is.OrderByListBuilder<ExperienceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Experience>(
      rows,
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Experience].
  Future<Experience> deleteRow(
    _is.DatabaseSession session,
    Experience row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Experience>(
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
  Future<List<Experience>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExperienceTable> where,
    _is.OrderByBuilder<ExperienceTable>? orderBy,
    _is.OrderByListBuilder<ExperienceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Experience>(
      where: where(Experience.t),
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Experience>(
      where: where?.call(Experience.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Experience] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExperienceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Experience>(
      where: where(Experience.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ExperienceAttachRowRepository {
  const ExperienceAttachRowRepository._();

  /// Creates a relation between the given [Experience] and [Profile]
  /// by setting the [Experience]'s foreign key `profileId` to refer to the [Profile].
  Future<void> profile(
    _is.DatabaseSession session,
    Experience experience,
    _i1157qfm.Profile profile, {
    _is.Transaction? transaction,
  }) async {
    if (experience.id == null) {
      throw ArgumentError.notNull('experience.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $experience = experience.copyWith(profileId: profile.id);
    await session.db.updateRow<Experience>(
      $experience,
      columns: [Experience.t.profileId],
      transaction: transaction,
    );
  }
}
