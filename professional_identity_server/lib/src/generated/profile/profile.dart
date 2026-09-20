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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;

abstract class Profile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Profile._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.handle,
    required this.fullName,
    this.headline,
    this.bio,
    this.location,
    this.currentRole,
    this.yearsOfExperience,
    this.availability,
    this.contactEmail,
    this.websiteUrl,
    this.avatarUrl,
    this.cvUrl,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isPublic = isPublic ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Profile({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String handle,
    required String fullName,
    String? headline,
    String? bio,
    String? location,
    String? currentRole,
    int? yearsOfExperience,
    String? availability,
    String? contactEmail,
    String? websiteUrl,
    String? avatarUrl,
    String? cvUrl,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProfileImpl;

  factory Profile.fromJson(Map<String, dynamic> jsonSerialization) {
    return Profile(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      handle: jsonSerialization['handle'] as String,
      fullName: jsonSerialization['fullName'] as String,
      headline: jsonSerialization['headline'] as String?,
      bio: jsonSerialization['bio'] as String?,
      location: jsonSerialization['location'] as String?,
      currentRole: jsonSerialization['currentRole'] as String?,
      yearsOfExperience: jsonSerialization['yearsOfExperience'] as int?,
      availability: jsonSerialization['availability'] as String?,
      contactEmail: jsonSerialization['contactEmail'] as String?,
      websiteUrl: jsonSerialization['websiteUrl'] as String?,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      cvUrl: jsonSerialization['cvUrl'] as String?,
      isPublic: jsonSerialization['isPublic'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ProfileTable();

  static const db = ProfileRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  String handle;

  String fullName;

  String? headline;

  String? bio;

  String? location;

  String? currentRole;

  int? yearsOfExperience;

  String? availability;

  String? contactEmail;

  String? websiteUrl;

  String? avatarUrl;

  String? cvUrl;

  bool isPublic;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Profile copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? handle,
    String? fullName,
    String? headline,
    String? bio,
    String? location,
    String? currentRole,
    int? yearsOfExperience,
    String? availability,
    String? contactEmail,
    String? websiteUrl,
    String? avatarUrl,
    String? cvUrl,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'handle': handle,
      'fullName': fullName,
      if (headline != null) 'headline': headline,
      if (bio != null) 'bio': bio,
      if (location != null) 'location': location,
      if (currentRole != null) 'currentRole': currentRole,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      if (availability != null) 'availability': availability,
      if (contactEmail != null) 'contactEmail': contactEmail,
      if (websiteUrl != null) 'websiteUrl': websiteUrl,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (cvUrl != null) 'cvUrl': cvUrl,
      'isPublic': isPublic,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'handle': handle,
      'fullName': fullName,
      if (headline != null) 'headline': headline,
      if (bio != null) 'bio': bio,
      if (location != null) 'location': location,
      if (currentRole != null) 'currentRole': currentRole,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      if (availability != null) 'availability': availability,
      if (contactEmail != null) 'contactEmail': contactEmail,
      if (websiteUrl != null) 'websiteUrl': websiteUrl,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (cvUrl != null) 'cvUrl': cvUrl,
      'isPublic': isPublic,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProfileInclude include({_iacs.AuthUserInclude? authUser}) {
    return ProfileInclude._(authUser: authUser);
  }

  static ProfileIncludeList includeList({
    _is.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileTable>? orderBy,
    _is.OrderByListBuilder<ProfileTable>? orderByList,
    ProfileInclude? include,
  }) {
    return ProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileImpl extends Profile {
  _ProfileImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String handle,
    required String fullName,
    String? headline,
    String? bio,
    String? location,
    String? currentRole,
    int? yearsOfExperience,
    String? availability,
    String? contactEmail,
    String? websiteUrl,
    String? avatarUrl,
    String? cvUrl,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         handle: handle,
         fullName: fullName,
         headline: headline,
         bio: bio,
         location: location,
         currentRole: currentRole,
         yearsOfExperience: yearsOfExperience,
         availability: availability,
         contactEmail: contactEmail,
         websiteUrl: websiteUrl,
         avatarUrl: avatarUrl,
         cvUrl: cvUrl,
         isPublic: isPublic,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Profile copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? handle,
    String? fullName,
    Object? headline = _Undefined,
    Object? bio = _Undefined,
    Object? location = _Undefined,
    Object? currentRole = _Undefined,
    Object? yearsOfExperience = _Undefined,
    Object? availability = _Undefined,
    Object? contactEmail = _Undefined,
    Object? websiteUrl = _Undefined,
    Object? avatarUrl = _Undefined,
    Object? cvUrl = _Undefined,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      handle: handle ?? this.handle,
      fullName: fullName ?? this.fullName,
      headline: headline is String? ? headline : this.headline,
      bio: bio is String? ? bio : this.bio,
      location: location is String? ? location : this.location,
      currentRole: currentRole is String? ? currentRole : this.currentRole,
      yearsOfExperience: yearsOfExperience is int?
          ? yearsOfExperience
          : this.yearsOfExperience,
      availability: availability is String? ? availability : this.availability,
      contactEmail: contactEmail is String? ? contactEmail : this.contactEmail,
      websiteUrl: websiteUrl is String? ? websiteUrl : this.websiteUrl,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      cvUrl: cvUrl is String? ? cvUrl : this.cvUrl,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProfileUpdateTable extends _is.UpdateTable<ProfileTable> {
  ProfileUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> handle(String value) => _is.ColumnValue(
    table.handle,
    value,
  );

  _is.ColumnValue<String, String> fullName(String value) => _is.ColumnValue(
    table.fullName,
    value,
  );

  _is.ColumnValue<String, String> headline(String? value) => _is.ColumnValue(
    table.headline,
    value,
  );

  _is.ColumnValue<String, String> bio(String? value) => _is.ColumnValue(
    table.bio,
    value,
  );

  _is.ColumnValue<String, String> location(String? value) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<String, String> currentRole(String? value) => _is.ColumnValue(
    table.currentRole,
    value,
  );

  _is.ColumnValue<int, int> yearsOfExperience(int? value) => _is.ColumnValue(
    table.yearsOfExperience,
    value,
  );

  _is.ColumnValue<String, String> availability(String? value) =>
      _is.ColumnValue(
        table.availability,
        value,
      );

  _is.ColumnValue<String, String> contactEmail(String? value) =>
      _is.ColumnValue(
        table.contactEmail,
        value,
      );

  _is.ColumnValue<String, String> websiteUrl(String? value) => _is.ColumnValue(
    table.websiteUrl,
    value,
  );

  _is.ColumnValue<String, String> avatarUrl(String? value) => _is.ColumnValue(
    table.avatarUrl,
    value,
  );

  _is.ColumnValue<String, String> cvUrl(String? value) => _is.ColumnValue(
    table.cvUrl,
    value,
  );

  _is.ColumnValue<bool, bool> isPublic(bool value) => _is.ColumnValue(
    table.isPublic,
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

class ProfileTable extends _is.Table<int?> {
  ProfileTable({super.tableRelation}) : super(tableName: 'profile') {
    updateTable = ProfileUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    handle = _is.ColumnString(
      'handle',
      this,
    );
    fullName = _is.ColumnString(
      'fullName',
      this,
    );
    headline = _is.ColumnString(
      'headline',
      this,
    );
    bio = _is.ColumnString(
      'bio',
      this,
    );
    location = _is.ColumnString(
      'location',
      this,
    );
    currentRole = _is.ColumnString(
      'currentRole',
      this,
    );
    yearsOfExperience = _is.ColumnInt(
      'yearsOfExperience',
      this,
    );
    availability = _is.ColumnString(
      'availability',
      this,
    );
    contactEmail = _is.ColumnString(
      'contactEmail',
      this,
    );
    websiteUrl = _is.ColumnString(
      'websiteUrl',
      this,
    );
    avatarUrl = _is.ColumnString(
      'avatarUrl',
      this,
    );
    cvUrl = _is.ColumnString(
      'cvUrl',
      this,
    );
    isPublic = _is.ColumnBool(
      'isPublic',
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

  late final ProfileUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString handle;

  late final _is.ColumnString fullName;

  late final _is.ColumnString headline;

  late final _is.ColumnString bio;

  late final _is.ColumnString location;

  late final _is.ColumnString currentRole;

  late final _is.ColumnInt yearsOfExperience;

  late final _is.ColumnString availability;

  late final _is.ColumnString contactEmail;

  late final _is.ColumnString websiteUrl;

  late final _is.ColumnString avatarUrl;

  late final _is.ColumnString cvUrl;

  late final _is.ColumnBool isPublic;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: Profile.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    handle,
    fullName,
    headline,
    bio,
    location,
    currentRole,
    yearsOfExperience,
    availability,
    contactEmail,
    websiteUrl,
    avatarUrl,
    cvUrl,
    isPublic,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class ProfileInclude extends _is.IncludeObject {
  ProfileInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => Profile.t;
}

class ProfileIncludeList extends _is.IncludeList {
  ProfileIncludeList._({
    _is.WhereExpressionBuilder<ProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Profile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Profile.t;
}

class ProfileRepository {
  const ProfileRepository._();

  final attachRow = const ProfileAttachRowRepository._();

  /// Returns a list of [Profile]s matching the given query parameters.
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
  Future<List<Profile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileTable>? orderBy,
    _is.OrderByListBuilder<ProfileTable>? orderByList,
    _is.Transaction? transaction,
    ProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Profile>(
      where: where?.call(Profile.t),
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Profile] matching the given query parameters.
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
  Future<Profile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<ProfileTable>? orderBy,
    _is.OrderByListBuilder<ProfileTable>? orderByList,
    _is.Transaction? transaction,
    ProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Profile>(
      where: where?.call(Profile.t),
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Profile] by its [id] or null if no such row exists.
  Future<Profile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Profile>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Profile]s in the list and returns the inserted rows.
  ///
  /// The returned [Profile]s will have their `id` fields set.
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
  Future<List<Profile>> insert(
    _is.DatabaseSession session,
    List<Profile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Profile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Profile] and returns the inserted row.
  ///
  /// The returned [Profile] will have its `id` field set.
  Future<Profile> insertRow(
    _is.DatabaseSession session,
    Profile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Profile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Profile]s in the list and returns the resulting rows.
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
  /// The returned [Profile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Profile>> upsert(
    _is.DatabaseSession session,
    List<Profile> rows, {
    required _is.ColumnSelections<ProfileTable> conflictColumns,
    _is.ColumnSelections<ProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<ProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Profile>(
      rows,
      conflictColumns: conflictColumns(Profile.t),
      updateColumns: updateColumns?.call(Profile.t),
      updateWhere: updateWhere?.call(Profile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Profile] and returns the resulting row.
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
  /// The returned [Profile] will have its `id` field set.
  Future<Profile?> upsertRow(
    _is.DatabaseSession session,
    Profile row, {
    required _is.ColumnSelections<ProfileTable> conflictColumns,
    _is.ColumnSelections<ProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<ProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Profile>(
      row,
      conflictColumns: conflictColumns(Profile.t),
      updateColumns: updateColumns?.call(Profile.t),
      updateWhere: updateWhere?.call(Profile.t),
      transaction: transaction,
    );
  }

  /// Updates all [Profile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Profile>> update(
    _is.DatabaseSession session,
    List<Profile> rows, {
    _is.ColumnSelections<ProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Profile>(
      rows,
      columns: columns?.call(Profile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Profile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Profile> updateRow(
    _is.DatabaseSession session,
    Profile row, {
    _is.ColumnSelections<ProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Profile>(
      row,
      columns: columns?.call(Profile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Profile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Profile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProfileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Profile>(
      id,
      columnValues: columnValues(Profile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Profile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Profile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProfileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileTable>? orderBy,
    _is.OrderByListBuilder<ProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Profile>(
      columnValues: columnValues(Profile.t.updateTable),
      where: where(Profile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Profile]s in the list and returns the deleted rows.
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
  Future<List<Profile>> delete(
    _is.DatabaseSession session,
    List<Profile> rows, {
    _is.OrderByBuilder<ProfileTable>? orderBy,
    _is.OrderByListBuilder<ProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Profile>(
      rows,
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Profile].
  Future<Profile> deleteRow(
    _is.DatabaseSession session,
    Profile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Profile>(
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
  Future<List<Profile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProfileTable> where,
    _is.OrderByBuilder<ProfileTable>? orderBy,
    _is.OrderByListBuilder<ProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Profile>(
      where: where(Profile.t),
      orderBy: orderBy?.call(Profile.t),
      orderByList: orderByList?.call(Profile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Profile>(
      where: where?.call(Profile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Profile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Profile>(
      where: where(Profile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ProfileAttachRowRepository {
  const ProfileAttachRowRepository._();

  /// Creates a relation between the given [Profile] and [AuthUser]
  /// by setting the [Profile]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    Profile profile,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $profile = profile.copyWith(authUserId: authUser.id);
    await session.db.updateRow<Profile>(
      $profile,
      columns: [Profile.t.authUserId],
      transaction: transaction,
    );
  }
}
