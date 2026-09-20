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

abstract class Project
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Project._({
    this.id,
    required this.profileId,
    this.profile,
    required this.title,
    this.description,
    this.role,
    this.url,
    this.repositoryUrl,
    this.imageUrl,
    required this.technologies,
    this.startDate,
    this.endDate,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isOngoing = isOngoing ?? false,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Project({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      role: jsonSerialization['role'] as String?,
      url: jsonSerialization['url'] as String?,
      repositoryUrl: jsonSerialization['repositoryUrl'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      technologies: _idwwx28q.Protocol().deserialize<List<String>>(
        jsonSerialization['technologies'],
      ),
      startDate: jsonSerialization['startDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      isOngoing: jsonSerialization['isOngoing'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isOngoing']),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ProjectTable();

  static const db = ProjectRepository._();

  @override
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String title;

  String? description;

  String? role;

  String? url;

  String? repositoryUrl;

  String? imageUrl;

  List<String> technologies;

  DateTime? startDate;

  DateTime? endDate;

  bool isOngoing;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Project copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'title': title,
      if (description != null) 'description': description,
      if (role != null) 'role': role,
      if (url != null) 'url': url,
      if (repositoryUrl != null) 'repositoryUrl': repositoryUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'technologies': technologies.toJson(),
      if (startDate != null) 'startDate': startDate?.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'isOngoing': isOngoing,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'title': title,
      if (description != null) 'description': description,
      if (role != null) 'role': role,
      if (url != null) 'url': url,
      if (repositoryUrl != null) 'repositoryUrl': repositoryUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'technologies': technologies.toJson(),
      if (startDate != null) 'startDate': startDate?.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'isOngoing': isOngoing,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProjectInclude include({_i1157qfm.ProfileInclude? profile}) {
    return ProjectInclude._(profile: profile);
  }

  static ProjectIncludeList includeList({
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    ProjectInclude? include,
  }) {
    return ProjectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectImpl extends Project {
  _ProjectImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         title: title,
         description: description,
         role: role,
         url: url,
         repositoryUrl: repositoryUrl,
         imageUrl: imageUrl,
         technologies: technologies,
         startDate: startDate,
         endDate: endDate,
         isOngoing: isOngoing,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Project copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? title,
    Object? description = _Undefined,
    Object? role = _Undefined,
    Object? url = _Undefined,
    Object? repositoryUrl = _Undefined,
    Object? imageUrl = _Undefined,
    List<String>? technologies,
    Object? startDate = _Undefined,
    Object? endDate = _Undefined,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Project(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      role: role is String? ? role : this.role,
      url: url is String? ? url : this.url,
      repositoryUrl: repositoryUrl is String?
          ? repositoryUrl
          : this.repositoryUrl,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      technologies: technologies ?? this.technologies.map((e0) => e0).toList(),
      startDate: startDate is DateTime? ? startDate : this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      isOngoing: isOngoing ?? this.isOngoing,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProjectUpdateTable extends _is.UpdateTable<ProjectTable> {
  ProjectUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> role(String? value) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<String, String> url(String? value) => _is.ColumnValue(
    table.url,
    value,
  );

  _is.ColumnValue<String, String> repositoryUrl(String? value) =>
      _is.ColumnValue(
        table.repositoryUrl,
        value,
      );

  _is.ColumnValue<String, String> imageUrl(String? value) => _is.ColumnValue(
    table.imageUrl,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> technologies(
    List<String> value,
  ) => _is.ColumnValue(
    table.technologies,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startDate(DateTime? value) =>
      _is.ColumnValue(
        table.startDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endDate(DateTime? value) =>
      _is.ColumnValue(
        table.endDate,
        value,
      );

  _is.ColumnValue<bool, bool> isOngoing(bool value) => _is.ColumnValue(
    table.isOngoing,
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

class ProjectTable extends _is.Table<int?> {
  ProjectTable({super.tableRelation}) : super(tableName: 'project') {
    updateTable = ProjectUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
    );
    url = _is.ColumnString(
      'url',
      this,
    );
    repositoryUrl = _is.ColumnString(
      'repositoryUrl',
      this,
    );
    imageUrl = _is.ColumnString(
      'imageUrl',
      this,
    );
    technologies = _is.ColumnSerializable<List<String>>(
      'technologies',
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
    isOngoing = _is.ColumnBool(
      'isOngoing',
      this,
      hasDefault: true,
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

  late final ProjectUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  _i1157qfm.ProfileTable? _profile;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnString role;

  late final _is.ColumnString url;

  late final _is.ColumnString repositoryUrl;

  late final _is.ColumnString imageUrl;

  late final _is.ColumnSerializable<List<String>> technologies;

  late final _is.ColumnDateTime startDate;

  late final _is.ColumnDateTime endDate;

  late final _is.ColumnBool isOngoing;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _i1157qfm.ProfileTable get profile {
    if (_profile != null) return _profile!;
    _profile = _is.createRelationTable(
      relationFieldName: 'profile',
      field: Project.t.profileId,
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
    title,
    description,
    role,
    url,
    repositoryUrl,
    imageUrl,
    technologies,
    startDate,
    endDate,
    isOngoing,
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

class ProjectInclude extends _is.IncludeObject {
  ProjectInclude._({_i1157qfm.ProfileInclude? profile}) {
    _profile = profile;
  }

  _i1157qfm.ProfileInclude? _profile;

  @override
  Map<String, _is.Include?> get includes => {'profile': _profile};

  @override
  _is.Table<int?> get table => Project.t;
}

class ProjectIncludeList extends _is.IncludeList {
  ProjectIncludeList._({
    _is.WhereExpressionBuilder<ProjectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Project.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Project.t;
}

class ProjectRepository {
  const ProjectRepository._();

  final attachRow = const ProjectAttachRowRepository._();

  /// Returns a list of [Project]s matching the given query parameters.
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
  Future<List<Project>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    ProjectInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Project>(
      where: where?.call(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Project] matching the given query parameters.
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
  Future<Project?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    ProjectInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Project>(
      where: where?.call(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Project] by its [id] or null if no such row exists.
  Future<Project?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ProjectInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Project>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Project]s in the list and returns the inserted rows.
  ///
  /// The returned [Project]s will have their `id` fields set.
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
  Future<List<Project>> insert(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Project>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Project] and returns the inserted row.
  ///
  /// The returned [Project] will have its `id` field set.
  Future<Project> insertRow(
    _is.DatabaseSession session,
    Project row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Project>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Project]s in the list and returns the resulting rows.
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
  /// The returned [Project]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> upsert(
    _is.DatabaseSession session,
    List<Project> rows, {
    required _is.ColumnSelections<ProjectTable> conflictColumns,
    _is.ColumnSelections<ProjectTable>? updateColumns,
    _is.WhereExpressionBuilder<ProjectTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Project>(
      rows,
      conflictColumns: conflictColumns(Project.t),
      updateColumns: updateColumns?.call(Project.t),
      updateWhere: updateWhere?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Project] and returns the resulting row.
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
  /// The returned [Project] will have its `id` field set.
  Future<Project?> upsertRow(
    _is.DatabaseSession session,
    Project row, {
    required _is.ColumnSelections<ProjectTable> conflictColumns,
    _is.ColumnSelections<ProjectTable>? updateColumns,
    _is.WhereExpressionBuilder<ProjectTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Project>(
      row,
      conflictColumns: conflictColumns(Project.t),
      updateColumns: updateColumns?.call(Project.t),
      updateWhere: updateWhere?.call(Project.t),
      transaction: transaction,
    );
  }

  /// Updates all [Project]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> update(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.ColumnSelections<ProjectTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Project>(
      rows,
      columns: columns?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Project]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Project> updateRow(
    _is.DatabaseSession session,
    Project row, {
    _is.ColumnSelections<ProjectTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Project>(
      row,
      columns: columns?.call(Project.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Project] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Project?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProjectUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Project>(
      id,
      columnValues: columnValues(Project.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Project]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProjectUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ProjectTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Project>(
      columnValues: columnValues(Project.t.updateTable),
      where: where(Project.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Project]s in the list and returns the deleted rows.
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
  Future<List<Project>> delete(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Project>(
      rows,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Project].
  Future<Project> deleteRow(
    _is.DatabaseSession session,
    Project row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Project>(
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
  Future<List<Project>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProjectTable> where,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Project>(
      where: where(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Project>(
      where: where?.call(Project.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Project] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProjectTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Project>(
      where: where(Project.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ProjectAttachRowRepository {
  const ProjectAttachRowRepository._();

  /// Creates a relation between the given [Project] and [Profile]
  /// by setting the [Project]'s foreign key `profileId` to refer to the [Profile].
  Future<void> profile(
    _is.DatabaseSession session,
    Project project,
    _i1157qfm.Profile profile, {
    _is.Transaction? transaction,
  }) async {
    if (project.id == null) {
      throw ArgumentError.notNull('project.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $project = project.copyWith(profileId: profile.id);
    await session.db.updateRow<Project>(
      $project,
      columns: [Project.t.profileId],
      transaction: transaction,
    );
  }
}
