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

abstract class Skill implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Skill._({
    this.id,
    required this.profileId,
    this.profile,
    required this.name,
    this.category,
    this.yearsOfExperience,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Skill({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String name,
    String? category,
    int? yearsOfExperience,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SkillImpl;

  factory Skill.fromJson(Map<String, dynamic> jsonSerialization) {
    return Skill(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] as String?,
      yearsOfExperience: jsonSerialization['yearsOfExperience'] as int?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SkillTable();

  static const db = SkillRepository._();

  @override
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String name;

  String? category;

  int? yearsOfExperience;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Skill]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Skill copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? name,
    String? category,
    int? yearsOfExperience,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Skill',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'name': name,
      if (category != null) 'category': category,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Skill',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'name': name,
      if (category != null) 'category': category,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SkillInclude include({_i1157qfm.ProfileInclude? profile}) {
    return SkillInclude._(profile: profile);
  }

  static SkillIncludeList includeList({
    _is.WhereExpressionBuilder<SkillTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SkillTable>? orderBy,
    _is.OrderByListBuilder<SkillTable>? orderByList,
    SkillInclude? include,
  }) {
    return SkillIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SkillImpl extends Skill {
  _SkillImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String name,
    String? category,
    int? yearsOfExperience,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         name: name,
         category: category,
         yearsOfExperience: yearsOfExperience,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Skill]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Skill copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? name,
    Object? category = _Undefined,
    Object? yearsOfExperience = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Skill(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      name: name ?? this.name,
      category: category is String? ? category : this.category,
      yearsOfExperience: yearsOfExperience is int?
          ? yearsOfExperience
          : this.yearsOfExperience,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SkillUpdateTable extends _is.UpdateTable<SkillTable> {
  SkillUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> category(String? value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<int, int> yearsOfExperience(int? value) => _is.ColumnValue(
    table.yearsOfExperience,
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

class SkillTable extends _is.Table<int?> {
  SkillTable({super.tableRelation}) : super(tableName: 'skill') {
    updateTable = SkillUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    yearsOfExperience = _is.ColumnInt(
      'yearsOfExperience',
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

  late final SkillUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  _i1157qfm.ProfileTable? _profile;

  late final _is.ColumnString name;

  late final _is.ColumnString category;

  late final _is.ColumnInt yearsOfExperience;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _i1157qfm.ProfileTable get profile {
    if (_profile != null) return _profile!;
    _profile = _is.createRelationTable(
      relationFieldName: 'profile',
      field: Skill.t.profileId,
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
    name,
    category,
    yearsOfExperience,
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

class SkillInclude extends _is.IncludeObject {
  SkillInclude._({_i1157qfm.ProfileInclude? profile}) {
    _profile = profile;
  }

  _i1157qfm.ProfileInclude? _profile;

  @override
  Map<String, _is.Include?> get includes => {'profile': _profile};

  @override
  _is.Table<int?> get table => Skill.t;
}

class SkillIncludeList extends _is.IncludeList {
  SkillIncludeList._({
    _is.WhereExpressionBuilder<SkillTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Skill.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Skill.t;
}

class SkillRepository {
  const SkillRepository._();

  final attachRow = const SkillAttachRowRepository._();

  /// Returns a list of [Skill]s matching the given query parameters.
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
  Future<List<Skill>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SkillTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SkillTable>? orderBy,
    _is.OrderByListBuilder<SkillTable>? orderByList,
    _is.Transaction? transaction,
    SkillInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Skill>(
      where: where?.call(Skill.t),
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Skill] matching the given query parameters.
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
  Future<Skill?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SkillTable>? where,
    int? offset,
    _is.OrderByBuilder<SkillTable>? orderBy,
    _is.OrderByListBuilder<SkillTable>? orderByList,
    _is.Transaction? transaction,
    SkillInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Skill>(
      where: where?.call(Skill.t),
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Skill] by its [id] or null if no such row exists.
  Future<Skill?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    SkillInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Skill>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Skill]s in the list and returns the inserted rows.
  ///
  /// The returned [Skill]s will have their `id` fields set.
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
  Future<List<Skill>> insert(
    _is.DatabaseSession session,
    List<Skill> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Skill>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Skill] and returns the inserted row.
  ///
  /// The returned [Skill] will have its `id` field set.
  Future<Skill> insertRow(
    _is.DatabaseSession session,
    Skill row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Skill>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Skill]s in the list and returns the resulting rows.
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
  /// The returned [Skill]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Skill>> upsert(
    _is.DatabaseSession session,
    List<Skill> rows, {
    required _is.ColumnSelections<SkillTable> conflictColumns,
    _is.ColumnSelections<SkillTable>? updateColumns,
    _is.WhereExpressionBuilder<SkillTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Skill>(
      rows,
      conflictColumns: conflictColumns(Skill.t),
      updateColumns: updateColumns?.call(Skill.t),
      updateWhere: updateWhere?.call(Skill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Skill] and returns the resulting row.
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
  /// The returned [Skill] will have its `id` field set.
  Future<Skill?> upsertRow(
    _is.DatabaseSession session,
    Skill row, {
    required _is.ColumnSelections<SkillTable> conflictColumns,
    _is.ColumnSelections<SkillTable>? updateColumns,
    _is.WhereExpressionBuilder<SkillTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Skill>(
      row,
      conflictColumns: conflictColumns(Skill.t),
      updateColumns: updateColumns?.call(Skill.t),
      updateWhere: updateWhere?.call(Skill.t),
      transaction: transaction,
    );
  }

  /// Updates all [Skill]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Skill>> update(
    _is.DatabaseSession session,
    List<Skill> rows, {
    _is.ColumnSelections<SkillTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Skill>(
      rows,
      columns: columns?.call(Skill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Skill]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Skill> updateRow(
    _is.DatabaseSession session,
    Skill row, {
    _is.ColumnSelections<SkillTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Skill>(
      row,
      columns: columns?.call(Skill.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Skill] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Skill?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SkillUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Skill>(
      id,
      columnValues: columnValues(Skill.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Skill]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Skill>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SkillUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SkillTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SkillTable>? orderBy,
    _is.OrderByListBuilder<SkillTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Skill>(
      columnValues: columnValues(Skill.t.updateTable),
      where: where(Skill.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Skill]s in the list and returns the deleted rows.
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
  Future<List<Skill>> delete(
    _is.DatabaseSession session,
    List<Skill> rows, {
    _is.OrderByBuilder<SkillTable>? orderBy,
    _is.OrderByListBuilder<SkillTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Skill>(
      rows,
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Skill].
  Future<Skill> deleteRow(
    _is.DatabaseSession session,
    Skill row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Skill>(
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
  Future<List<Skill>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SkillTable> where,
    _is.OrderByBuilder<SkillTable>? orderBy,
    _is.OrderByListBuilder<SkillTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Skill>(
      where: where(Skill.t),
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SkillTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Skill>(
      where: where?.call(Skill.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Skill] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SkillTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Skill>(
      where: where(Skill.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SkillAttachRowRepository {
  const SkillAttachRowRepository._();

  /// Creates a relation between the given [Skill] and [Profile]
  /// by setting the [Skill]'s foreign key `profileId` to refer to the [Profile].
  Future<void> profile(
    _is.DatabaseSession session,
    Skill skill,
    _i1157qfm.Profile profile, {
    _is.Transaction? transaction,
  }) async {
    if (skill.id == null) {
      throw ArgumentError.notNull('skill.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $skill = skill.copyWith(profileId: profile.id);
    await session.db.updateRow<Skill>(
      $skill,
      columns: [Skill.t.profileId],
      transaction: transaction,
    );
  }
}
