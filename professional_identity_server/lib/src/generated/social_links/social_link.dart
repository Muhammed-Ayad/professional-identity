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

abstract class SocialLink
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SocialLink._({
    this.id,
    required this.profileId,
    this.profile,
    required this.platform,
    required this.url,
    this.label,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SocialLink({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String platform,
    required String url,
    String? label,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SocialLinkImpl;

  factory SocialLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return SocialLink(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      platform: jsonSerialization['platform'] as String,
      url: jsonSerialization['url'] as String,
      label: jsonSerialization['label'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SocialLinkTable();

  static const db = SocialLinkRepository._();

  @override
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String platform;

  String url;

  String? label;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SocialLink]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SocialLink copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? platform,
    String? url,
    String? label,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SocialLink',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'platform': platform,
      'url': url,
      if (label != null) 'label': label,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SocialLink',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'platform': platform,
      'url': url,
      if (label != null) 'label': label,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SocialLinkInclude include({_i1157qfm.ProfileInclude? profile}) {
    return SocialLinkInclude._(profile: profile);
  }

  static SocialLinkIncludeList includeList({
    _is.WhereExpressionBuilder<SocialLinkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocialLinkTable>? orderBy,
    _is.OrderByListBuilder<SocialLinkTable>? orderByList,
    SocialLinkInclude? include,
  }) {
    return SocialLinkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SocialLink.t),
      orderByList: orderByList?.call(SocialLink.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocialLinkImpl extends SocialLink {
  _SocialLinkImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String platform,
    required String url,
    String? label,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         platform: platform,
         url: url,
         label: label,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SocialLink]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SocialLink copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? platform,
    String? url,
    Object? label = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SocialLink(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      platform: platform ?? this.platform,
      url: url ?? this.url,
      label: label is String? ? label : this.label,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SocialLinkUpdateTable extends _is.UpdateTable<SocialLinkTable> {
  SocialLinkUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> platform(String value) => _is.ColumnValue(
    table.platform,
    value,
  );

  _is.ColumnValue<String, String> url(String value) => _is.ColumnValue(
    table.url,
    value,
  );

  _is.ColumnValue<String, String> label(String? value) => _is.ColumnValue(
    table.label,
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

class SocialLinkTable extends _is.Table<int?> {
  SocialLinkTable({super.tableRelation}) : super(tableName: 'social_link') {
    updateTable = SocialLinkUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    platform = _is.ColumnString(
      'platform',
      this,
    );
    url = _is.ColumnString(
      'url',
      this,
    );
    label = _is.ColumnString(
      'label',
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

  late final SocialLinkUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  _i1157qfm.ProfileTable? _profile;

  late final _is.ColumnString platform;

  late final _is.ColumnString url;

  late final _is.ColumnString label;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _i1157qfm.ProfileTable get profile {
    if (_profile != null) return _profile!;
    _profile = _is.createRelationTable(
      relationFieldName: 'profile',
      field: SocialLink.t.profileId,
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
    platform,
    url,
    label,
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

class SocialLinkInclude extends _is.IncludeObject {
  SocialLinkInclude._({_i1157qfm.ProfileInclude? profile}) {
    _profile = profile;
  }

  _i1157qfm.ProfileInclude? _profile;

  @override
  Map<String, _is.Include?> get includes => {'profile': _profile};

  @override
  _is.Table<int?> get table => SocialLink.t;
}

class SocialLinkIncludeList extends _is.IncludeList {
  SocialLinkIncludeList._({
    _is.WhereExpressionBuilder<SocialLinkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SocialLink.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SocialLink.t;
}

class SocialLinkRepository {
  const SocialLinkRepository._();

  final attachRow = const SocialLinkAttachRowRepository._();

  /// Returns a list of [SocialLink]s matching the given query parameters.
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
  Future<List<SocialLink>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocialLinkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocialLinkTable>? orderBy,
    _is.OrderByListBuilder<SocialLinkTable>? orderByList,
    _is.Transaction? transaction,
    SocialLinkInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SocialLink>(
      where: where?.call(SocialLink.t),
      orderBy: orderBy?.call(SocialLink.t),
      orderByList: orderByList?.call(SocialLink.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SocialLink] matching the given query parameters.
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
  Future<SocialLink?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocialLinkTable>? where,
    int? offset,
    _is.OrderByBuilder<SocialLinkTable>? orderBy,
    _is.OrderByListBuilder<SocialLinkTable>? orderByList,
    _is.Transaction? transaction,
    SocialLinkInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SocialLink>(
      where: where?.call(SocialLink.t),
      orderBy: orderBy?.call(SocialLink.t),
      orderByList: orderByList?.call(SocialLink.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SocialLink] by its [id] or null if no such row exists.
  Future<SocialLink?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    SocialLinkInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SocialLink>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SocialLink]s in the list and returns the inserted rows.
  ///
  /// The returned [SocialLink]s will have their `id` fields set.
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
  Future<List<SocialLink>> insert(
    _is.DatabaseSession session,
    List<SocialLink> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SocialLink>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SocialLink] and returns the inserted row.
  ///
  /// The returned [SocialLink] will have its `id` field set.
  Future<SocialLink> insertRow(
    _is.DatabaseSession session,
    SocialLink row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SocialLink>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SocialLink]s in the list and returns the resulting rows.
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
  /// The returned [SocialLink]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocialLink>> upsert(
    _is.DatabaseSession session,
    List<SocialLink> rows, {
    required _is.ColumnSelections<SocialLinkTable> conflictColumns,
    _is.ColumnSelections<SocialLinkTable>? updateColumns,
    _is.WhereExpressionBuilder<SocialLinkTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SocialLink>(
      rows,
      conflictColumns: conflictColumns(SocialLink.t),
      updateColumns: updateColumns?.call(SocialLink.t),
      updateWhere: updateWhere?.call(SocialLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SocialLink] and returns the resulting row.
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
  /// The returned [SocialLink] will have its `id` field set.
  Future<SocialLink?> upsertRow(
    _is.DatabaseSession session,
    SocialLink row, {
    required _is.ColumnSelections<SocialLinkTable> conflictColumns,
    _is.ColumnSelections<SocialLinkTable>? updateColumns,
    _is.WhereExpressionBuilder<SocialLinkTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SocialLink>(
      row,
      conflictColumns: conflictColumns(SocialLink.t),
      updateColumns: updateColumns?.call(SocialLink.t),
      updateWhere: updateWhere?.call(SocialLink.t),
      transaction: transaction,
    );
  }

  /// Updates all [SocialLink]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocialLink>> update(
    _is.DatabaseSession session,
    List<SocialLink> rows, {
    _is.ColumnSelections<SocialLinkTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SocialLink>(
      rows,
      columns: columns?.call(SocialLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SocialLink]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SocialLink> updateRow(
    _is.DatabaseSession session,
    SocialLink row, {
    _is.ColumnSelections<SocialLinkTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SocialLink>(
      row,
      columns: columns?.call(SocialLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SocialLink] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SocialLink?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SocialLinkUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SocialLink>(
      id,
      columnValues: columnValues(SocialLink.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SocialLink]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SocialLink>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SocialLinkUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SocialLinkTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SocialLinkTable>? orderBy,
    _is.OrderByListBuilder<SocialLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SocialLink>(
      columnValues: columnValues(SocialLink.t.updateTable),
      where: where(SocialLink.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SocialLink.t),
      orderByList: orderByList?.call(SocialLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SocialLink]s in the list and returns the deleted rows.
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
  Future<List<SocialLink>> delete(
    _is.DatabaseSession session,
    List<SocialLink> rows, {
    _is.OrderByBuilder<SocialLinkTable>? orderBy,
    _is.OrderByListBuilder<SocialLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SocialLink>(
      rows,
      orderBy: orderBy?.call(SocialLink.t),
      orderByList: orderByList?.call(SocialLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SocialLink].
  Future<SocialLink> deleteRow(
    _is.DatabaseSession session,
    SocialLink row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SocialLink>(
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
  Future<List<SocialLink>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SocialLinkTable> where,
    _is.OrderByBuilder<SocialLinkTable>? orderBy,
    _is.OrderByListBuilder<SocialLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SocialLink>(
      where: where(SocialLink.t),
      orderBy: orderBy?.call(SocialLink.t),
      orderByList: orderByList?.call(SocialLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SocialLinkTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SocialLink>(
      where: where?.call(SocialLink.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SocialLink] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SocialLinkTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SocialLink>(
      where: where(SocialLink.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SocialLinkAttachRowRepository {
  const SocialLinkAttachRowRepository._();

  /// Creates a relation between the given [SocialLink] and [Profile]
  /// by setting the [SocialLink]'s foreign key `profileId` to refer to the [Profile].
  Future<void> profile(
    _is.DatabaseSession session,
    SocialLink socialLink,
    _i1157qfm.Profile profile, {
    _is.Transaction? transaction,
  }) async {
    if (socialLink.id == null) {
      throw ArgumentError.notNull('socialLink.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $socialLink = socialLink.copyWith(profileId: profile.id);
    await session.db.updateRow<SocialLink>(
      $socialLink,
      columns: [SocialLink.t.profileId],
      transaction: transaction,
    );
  }
}
