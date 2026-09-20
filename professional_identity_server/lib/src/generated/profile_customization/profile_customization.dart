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

abstract class ProfileCustomization
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ProfileCustomization._({
    this.id,
    required this.profileId,
    this.profile,
    String? themePreset,
    this.primaryColor,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  }) : themePreset = themePreset ?? 'minimal',
       backgroundStyle = backgroundStyle ?? 'solid',
       cardStyle = cardStyle ?? 'outlined',
       borderRadius = borderRadius ?? 'medium',
       typographyStyle = typographyStyle ?? 'modern',
       updatedAt = updatedAt ?? DateTime.now();

  factory ProfileCustomization({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    String? themePreset,
    String? primaryColor,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  }) = _ProfileCustomizationImpl;

  factory ProfileCustomization.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProfileCustomization(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      themePreset: jsonSerialization['themePreset'] as String?,
      primaryColor: jsonSerialization['primaryColor'] as String?,
      backgroundStyle: jsonSerialization['backgroundStyle'] as String?,
      cardStyle: jsonSerialization['cardStyle'] as String?,
      borderRadius: jsonSerialization['borderRadius'] as String?,
      typographyStyle: jsonSerialization['typographyStyle'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ProfileCustomizationTable();

  static const db = ProfileCustomizationRepository._();

  @override
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String themePreset;

  String? primaryColor;

  String backgroundStyle;

  String cardStyle;

  String borderRadius;

  String typographyStyle;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProfileCustomization]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProfileCustomization copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? themePreset,
    String? primaryColor,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileCustomization',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'themePreset': themePreset,
      if (primaryColor != null) 'primaryColor': primaryColor,
      'backgroundStyle': backgroundStyle,
      'cardStyle': cardStyle,
      'borderRadius': borderRadius,
      'typographyStyle': typographyStyle,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileCustomization',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'themePreset': themePreset,
      if (primaryColor != null) 'primaryColor': primaryColor,
      'backgroundStyle': backgroundStyle,
      'cardStyle': cardStyle,
      'borderRadius': borderRadius,
      'typographyStyle': typographyStyle,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProfileCustomizationInclude include({
    _i1157qfm.ProfileInclude? profile,
  }) {
    return ProfileCustomizationInclude._(profile: profile);
  }

  static ProfileCustomizationIncludeList includeList({
    _is.WhereExpressionBuilder<ProfileCustomizationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileCustomizationTable>? orderBy,
    _is.OrderByListBuilder<ProfileCustomizationTable>? orderByList,
    ProfileCustomizationInclude? include,
  }) {
    return ProfileCustomizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProfileCustomization.t),
      orderByList: orderByList?.call(ProfileCustomization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileCustomizationImpl extends ProfileCustomization {
  _ProfileCustomizationImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    String? themePreset,
    String? primaryColor,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         themePreset: themePreset,
         primaryColor: primaryColor,
         backgroundStyle: backgroundStyle,
         cardStyle: cardStyle,
         borderRadius: borderRadius,
         typographyStyle: typographyStyle,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProfileCustomization]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProfileCustomization copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? themePreset,
    Object? primaryColor = _Undefined,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  }) {
    return ProfileCustomization(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      themePreset: themePreset ?? this.themePreset,
      primaryColor: primaryColor is String? ? primaryColor : this.primaryColor,
      backgroundStyle: backgroundStyle ?? this.backgroundStyle,
      cardStyle: cardStyle ?? this.cardStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      typographyStyle: typographyStyle ?? this.typographyStyle,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProfileCustomizationUpdateTable
    extends _is.UpdateTable<ProfileCustomizationTable> {
  ProfileCustomizationUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> themePreset(String value) => _is.ColumnValue(
    table.themePreset,
    value,
  );

  _is.ColumnValue<String, String> primaryColor(String? value) =>
      _is.ColumnValue(
        table.primaryColor,
        value,
      );

  _is.ColumnValue<String, String> backgroundStyle(String value) =>
      _is.ColumnValue(
        table.backgroundStyle,
        value,
      );

  _is.ColumnValue<String, String> cardStyle(String value) => _is.ColumnValue(
    table.cardStyle,
    value,
  );

  _is.ColumnValue<String, String> borderRadius(String value) => _is.ColumnValue(
    table.borderRadius,
    value,
  );

  _is.ColumnValue<String, String> typographyStyle(String value) =>
      _is.ColumnValue(
        table.typographyStyle,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ProfileCustomizationTable extends _is.Table<int?> {
  ProfileCustomizationTable({super.tableRelation})
    : super(tableName: 'profile_customization') {
    updateTable = ProfileCustomizationUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    themePreset = _is.ColumnString(
      'themePreset',
      this,
      hasDefault: true,
    );
    primaryColor = _is.ColumnString(
      'primaryColor',
      this,
    );
    backgroundStyle = _is.ColumnString(
      'backgroundStyle',
      this,
      hasDefault: true,
    );
    cardStyle = _is.ColumnString(
      'cardStyle',
      this,
      hasDefault: true,
    );
    borderRadius = _is.ColumnString(
      'borderRadius',
      this,
      hasDefault: true,
    );
    typographyStyle = _is.ColumnString(
      'typographyStyle',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ProfileCustomizationUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  _i1157qfm.ProfileTable? _profile;

  late final _is.ColumnString themePreset;

  late final _is.ColumnString primaryColor;

  late final _is.ColumnString backgroundStyle;

  late final _is.ColumnString cardStyle;

  late final _is.ColumnString borderRadius;

  late final _is.ColumnString typographyStyle;

  late final _is.ColumnDateTime updatedAt;

  _i1157qfm.ProfileTable get profile {
    if (_profile != null) return _profile!;
    _profile = _is.createRelationTable(
      relationFieldName: 'profile',
      field: ProfileCustomization.t.profileId,
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
    themePreset,
    primaryColor,
    backgroundStyle,
    cardStyle,
    borderRadius,
    typographyStyle,
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

class ProfileCustomizationInclude extends _is.IncludeObject {
  ProfileCustomizationInclude._({_i1157qfm.ProfileInclude? profile}) {
    _profile = profile;
  }

  _i1157qfm.ProfileInclude? _profile;

  @override
  Map<String, _is.Include?> get includes => {'profile': _profile};

  @override
  _is.Table<int?> get table => ProfileCustomization.t;
}

class ProfileCustomizationIncludeList extends _is.IncludeList {
  ProfileCustomizationIncludeList._({
    _is.WhereExpressionBuilder<ProfileCustomizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProfileCustomization.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ProfileCustomization.t;
}

class ProfileCustomizationRepository {
  const ProfileCustomizationRepository._();

  final attachRow = const ProfileCustomizationAttachRowRepository._();

  /// Returns a list of [ProfileCustomization]s matching the given query parameters.
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
  Future<List<ProfileCustomization>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileCustomizationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileCustomizationTable>? orderBy,
    _is.OrderByListBuilder<ProfileCustomizationTable>? orderByList,
    _is.Transaction? transaction,
    ProfileCustomizationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProfileCustomization>(
      where: where?.call(ProfileCustomization.t),
      orderBy: orderBy?.call(ProfileCustomization.t),
      orderByList: orderByList?.call(ProfileCustomization.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProfileCustomization] matching the given query parameters.
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
  Future<ProfileCustomization?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileCustomizationTable>? where,
    int? offset,
    _is.OrderByBuilder<ProfileCustomizationTable>? orderBy,
    _is.OrderByListBuilder<ProfileCustomizationTable>? orderByList,
    _is.Transaction? transaction,
    ProfileCustomizationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProfileCustomization>(
      where: where?.call(ProfileCustomization.t),
      orderBy: orderBy?.call(ProfileCustomization.t),
      orderByList: orderByList?.call(ProfileCustomization.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProfileCustomization] by its [id] or null if no such row exists.
  Future<ProfileCustomization?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ProfileCustomizationInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProfileCustomization>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProfileCustomization]s in the list and returns the inserted rows.
  ///
  /// The returned [ProfileCustomization]s will have their `id` fields set.
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
  Future<List<ProfileCustomization>> insert(
    _is.DatabaseSession session,
    List<ProfileCustomization> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ProfileCustomization>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ProfileCustomization] and returns the inserted row.
  ///
  /// The returned [ProfileCustomization] will have its `id` field set.
  Future<ProfileCustomization> insertRow(
    _is.DatabaseSession session,
    ProfileCustomization row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProfileCustomization>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ProfileCustomization]s in the list and returns the resulting rows.
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
  /// The returned [ProfileCustomization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileCustomization>> upsert(
    _is.DatabaseSession session,
    List<ProfileCustomization> rows, {
    required _is.ColumnSelections<ProfileCustomizationTable> conflictColumns,
    _is.ColumnSelections<ProfileCustomizationTable>? updateColumns,
    _is.WhereExpressionBuilder<ProfileCustomizationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ProfileCustomization>(
      rows,
      conflictColumns: conflictColumns(ProfileCustomization.t),
      updateColumns: updateColumns?.call(ProfileCustomization.t),
      updateWhere: updateWhere?.call(ProfileCustomization.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ProfileCustomization] and returns the resulting row.
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
  /// The returned [ProfileCustomization] will have its `id` field set.
  Future<ProfileCustomization?> upsertRow(
    _is.DatabaseSession session,
    ProfileCustomization row, {
    required _is.ColumnSelections<ProfileCustomizationTable> conflictColumns,
    _is.ColumnSelections<ProfileCustomizationTable>? updateColumns,
    _is.WhereExpressionBuilder<ProfileCustomizationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ProfileCustomization>(
      row,
      conflictColumns: conflictColumns(ProfileCustomization.t),
      updateColumns: updateColumns?.call(ProfileCustomization.t),
      updateWhere: updateWhere?.call(ProfileCustomization.t),
      transaction: transaction,
    );
  }

  /// Updates all [ProfileCustomization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileCustomization>> update(
    _is.DatabaseSession session,
    List<ProfileCustomization> rows, {
    _is.ColumnSelections<ProfileCustomizationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ProfileCustomization>(
      rows,
      columns: columns?.call(ProfileCustomization.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ProfileCustomization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProfileCustomization> updateRow(
    _is.DatabaseSession session,
    ProfileCustomization row, {
    _is.ColumnSelections<ProfileCustomizationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProfileCustomization>(
      row,
      columns: columns?.call(ProfileCustomization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProfileCustomization] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProfileCustomization?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProfileCustomizationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ProfileCustomization>(
      id,
      columnValues: columnValues(ProfileCustomization.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProfileCustomization]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProfileCustomization>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProfileCustomizationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ProfileCustomizationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProfileCustomizationTable>? orderBy,
    _is.OrderByListBuilder<ProfileCustomizationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ProfileCustomization>(
      columnValues: columnValues(ProfileCustomization.t.updateTable),
      where: where(ProfileCustomization.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProfileCustomization.t),
      orderByList: orderByList?.call(ProfileCustomization.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ProfileCustomization]s in the list and returns the deleted rows.
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
  Future<List<ProfileCustomization>> delete(
    _is.DatabaseSession session,
    List<ProfileCustomization> rows, {
    _is.OrderByBuilder<ProfileCustomizationTable>? orderBy,
    _is.OrderByListBuilder<ProfileCustomizationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ProfileCustomization>(
      rows,
      orderBy: orderBy?.call(ProfileCustomization.t),
      orderByList: orderByList?.call(ProfileCustomization.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ProfileCustomization].
  Future<ProfileCustomization> deleteRow(
    _is.DatabaseSession session,
    ProfileCustomization row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProfileCustomization>(
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
  Future<List<ProfileCustomization>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProfileCustomizationTable> where,
    _is.OrderByBuilder<ProfileCustomizationTable>? orderBy,
    _is.OrderByListBuilder<ProfileCustomizationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ProfileCustomization>(
      where: where(ProfileCustomization.t),
      orderBy: orderBy?.call(ProfileCustomization.t),
      orderByList: orderByList?.call(ProfileCustomization.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProfileCustomizationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ProfileCustomization>(
      where: where?.call(ProfileCustomization.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProfileCustomization] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProfileCustomizationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProfileCustomization>(
      where: where(ProfileCustomization.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ProfileCustomizationAttachRowRepository {
  const ProfileCustomizationAttachRowRepository._();

  /// Creates a relation between the given [ProfileCustomization] and [Profile]
  /// by setting the [ProfileCustomization]'s foreign key `profileId` to refer to the [Profile].
  Future<void> profile(
    _is.DatabaseSession session,
    ProfileCustomization profileCustomization,
    _i1157qfm.Profile profile, {
    _is.Transaction? transaction,
  }) async {
    if (profileCustomization.id == null) {
      throw ArgumentError.notNull('profileCustomization.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $profileCustomization = profileCustomization.copyWith(
      profileId: profile.id,
    );
    await session.db.updateRow<ProfileCustomization>(
      $profileCustomization,
      columns: [ProfileCustomization.t.profileId],
      transaction: transaction,
    );
  }
}
