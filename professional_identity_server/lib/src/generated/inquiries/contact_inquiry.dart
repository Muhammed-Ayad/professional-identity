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

abstract class ContactInquiry
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ContactInquiry._({
    this.id,
    required this.profileId,
    this.profile,
    required this.senderName,
    required this.senderEmail,
    required this.subject,
    required this.message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  }) : inquiryType = inquiryType ?? 'general',
       isRead = isRead ?? false,
       isArchived = isArchived ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory ContactInquiry({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  }) = _ContactInquiryImpl;

  factory ContactInquiry.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContactInquiry(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      senderName: jsonSerialization['senderName'] as String,
      senderEmail: jsonSerialization['senderEmail'] as String,
      subject: jsonSerialization['subject'] as String,
      message: jsonSerialization['message'] as String,
      inquiryType: jsonSerialization['inquiryType'] as String?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      isArchived: jsonSerialization['isArchived'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isArchived']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ContactInquiryTable();

  static const db = ContactInquiryRepository._();

  @override
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String senderName;

  String senderEmail;

  String subject;

  String message;

  String inquiryType;

  bool isRead;

  bool isArchived;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ContactInquiry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ContactInquiry copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? senderName,
    String? senderEmail,
    String? subject,
    String? message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContactInquiry',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'subject': subject,
      'message': message,
      'inquiryType': inquiryType,
      'isRead': isRead,
      'isArchived': isArchived,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContactInquiry',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'subject': subject,
      'message': message,
      'inquiryType': inquiryType,
      'isRead': isRead,
      'isArchived': isArchived,
      'createdAt': createdAt.toJson(),
    };
  }

  static ContactInquiryInclude include({_i1157qfm.ProfileInclude? profile}) {
    return ContactInquiryInclude._(profile: profile);
  }

  static ContactInquiryIncludeList includeList({
    _is.WhereExpressionBuilder<ContactInquiryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactInquiryTable>? orderBy,
    _is.OrderByListBuilder<ContactInquiryTable>? orderByList,
    ContactInquiryInclude? include,
  }) {
    return ContactInquiryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ContactInquiry.t),
      orderByList: orderByList?.call(ContactInquiry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContactInquiryImpl extends ContactInquiry {
  _ContactInquiryImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         senderName: senderName,
         senderEmail: senderEmail,
         subject: subject,
         message: message,
         inquiryType: inquiryType,
         isRead: isRead,
         isArchived: isArchived,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ContactInquiry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ContactInquiry copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? senderName,
    String? senderEmail,
    String? subject,
    String? message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  }) {
    return ContactInquiry(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      senderName: senderName ?? this.senderName,
      senderEmail: senderEmail ?? this.senderEmail,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      inquiryType: inquiryType ?? this.inquiryType,
      isRead: isRead ?? this.isRead,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ContactInquiryUpdateTable extends _is.UpdateTable<ContactInquiryTable> {
  ContactInquiryUpdateTable(super.table);

  _is.ColumnValue<int, int> profileId(int value) => _is.ColumnValue(
    table.profileId,
    value,
  );

  _is.ColumnValue<String, String> senderName(String value) => _is.ColumnValue(
    table.senderName,
    value,
  );

  _is.ColumnValue<String, String> senderEmail(String value) => _is.ColumnValue(
    table.senderEmail,
    value,
  );

  _is.ColumnValue<String, String> subject(String value) => _is.ColumnValue(
    table.subject,
    value,
  );

  _is.ColumnValue<String, String> message(String value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<String, String> inquiryType(String value) => _is.ColumnValue(
    table.inquiryType,
    value,
  );

  _is.ColumnValue<bool, bool> isRead(bool value) => _is.ColumnValue(
    table.isRead,
    value,
  );

  _is.ColumnValue<bool, bool> isArchived(bool value) => _is.ColumnValue(
    table.isArchived,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ContactInquiryTable extends _is.Table<int?> {
  ContactInquiryTable({super.tableRelation})
    : super(tableName: 'contact_inquiry') {
    updateTable = ContactInquiryUpdateTable(this);
    profileId = _is.ColumnInt(
      'profileId',
      this,
    );
    senderName = _is.ColumnString(
      'senderName',
      this,
    );
    senderEmail = _is.ColumnString(
      'senderEmail',
      this,
    );
    subject = _is.ColumnString(
      'subject',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    inquiryType = _is.ColumnString(
      'inquiryType',
      this,
      hasDefault: true,
    );
    isRead = _is.ColumnBool(
      'isRead',
      this,
      hasDefault: true,
    );
    isArchived = _is.ColumnBool(
      'isArchived',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ContactInquiryUpdateTable updateTable;

  late final _is.ColumnInt profileId;

  _i1157qfm.ProfileTable? _profile;

  late final _is.ColumnString senderName;

  late final _is.ColumnString senderEmail;

  late final _is.ColumnString subject;

  late final _is.ColumnString message;

  late final _is.ColumnString inquiryType;

  late final _is.ColumnBool isRead;

  late final _is.ColumnBool isArchived;

  late final _is.ColumnDateTime createdAt;

  _i1157qfm.ProfileTable get profile {
    if (_profile != null) return _profile!;
    _profile = _is.createRelationTable(
      relationFieldName: 'profile',
      field: ContactInquiry.t.profileId,
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
    senderName,
    senderEmail,
    subject,
    message,
    inquiryType,
    isRead,
    isArchived,
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

class ContactInquiryInclude extends _is.IncludeObject {
  ContactInquiryInclude._({_i1157qfm.ProfileInclude? profile}) {
    _profile = profile;
  }

  _i1157qfm.ProfileInclude? _profile;

  @override
  Map<String, _is.Include?> get includes => {'profile': _profile};

  @override
  _is.Table<int?> get table => ContactInquiry.t;
}

class ContactInquiryIncludeList extends _is.IncludeList {
  ContactInquiryIncludeList._({
    _is.WhereExpressionBuilder<ContactInquiryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ContactInquiry.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ContactInquiry.t;
}

class ContactInquiryRepository {
  const ContactInquiryRepository._();

  final attachRow = const ContactInquiryAttachRowRepository._();

  /// Returns a list of [ContactInquiry]s matching the given query parameters.
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
  Future<List<ContactInquiry>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactInquiryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactInquiryTable>? orderBy,
    _is.OrderByListBuilder<ContactInquiryTable>? orderByList,
    _is.Transaction? transaction,
    ContactInquiryInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ContactInquiry>(
      where: where?.call(ContactInquiry.t),
      orderBy: orderBy?.call(ContactInquiry.t),
      orderByList: orderByList?.call(ContactInquiry.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ContactInquiry] matching the given query parameters.
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
  Future<ContactInquiry?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactInquiryTable>? where,
    int? offset,
    _is.OrderByBuilder<ContactInquiryTable>? orderBy,
    _is.OrderByListBuilder<ContactInquiryTable>? orderByList,
    _is.Transaction? transaction,
    ContactInquiryInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ContactInquiry>(
      where: where?.call(ContactInquiry.t),
      orderBy: orderBy?.call(ContactInquiry.t),
      orderByList: orderByList?.call(ContactInquiry.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ContactInquiry] by its [id] or null if no such row exists.
  Future<ContactInquiry?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ContactInquiryInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ContactInquiry>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ContactInquiry]s in the list and returns the inserted rows.
  ///
  /// The returned [ContactInquiry]s will have their `id` fields set.
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
  Future<List<ContactInquiry>> insert(
    _is.DatabaseSession session,
    List<ContactInquiry> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ContactInquiry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ContactInquiry] and returns the inserted row.
  ///
  /// The returned [ContactInquiry] will have its `id` field set.
  Future<ContactInquiry> insertRow(
    _is.DatabaseSession session,
    ContactInquiry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ContactInquiry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ContactInquiry]s in the list and returns the resulting rows.
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
  /// The returned [ContactInquiry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ContactInquiry>> upsert(
    _is.DatabaseSession session,
    List<ContactInquiry> rows, {
    required _is.ColumnSelections<ContactInquiryTable> conflictColumns,
    _is.ColumnSelections<ContactInquiryTable>? updateColumns,
    _is.WhereExpressionBuilder<ContactInquiryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ContactInquiry>(
      rows,
      conflictColumns: conflictColumns(ContactInquiry.t),
      updateColumns: updateColumns?.call(ContactInquiry.t),
      updateWhere: updateWhere?.call(ContactInquiry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ContactInquiry] and returns the resulting row.
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
  /// The returned [ContactInquiry] will have its `id` field set.
  Future<ContactInquiry?> upsertRow(
    _is.DatabaseSession session,
    ContactInquiry row, {
    required _is.ColumnSelections<ContactInquiryTable> conflictColumns,
    _is.ColumnSelections<ContactInquiryTable>? updateColumns,
    _is.WhereExpressionBuilder<ContactInquiryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ContactInquiry>(
      row,
      conflictColumns: conflictColumns(ContactInquiry.t),
      updateColumns: updateColumns?.call(ContactInquiry.t),
      updateWhere: updateWhere?.call(ContactInquiry.t),
      transaction: transaction,
    );
  }

  /// Updates all [ContactInquiry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ContactInquiry>> update(
    _is.DatabaseSession session,
    List<ContactInquiry> rows, {
    _is.ColumnSelections<ContactInquiryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ContactInquiry>(
      rows,
      columns: columns?.call(ContactInquiry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ContactInquiry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ContactInquiry> updateRow(
    _is.DatabaseSession session,
    ContactInquiry row, {
    _is.ColumnSelections<ContactInquiryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ContactInquiry>(
      row,
      columns: columns?.call(ContactInquiry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ContactInquiry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ContactInquiry?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ContactInquiryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ContactInquiry>(
      id,
      columnValues: columnValues(ContactInquiry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ContactInquiry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ContactInquiry>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ContactInquiryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ContactInquiryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ContactInquiryTable>? orderBy,
    _is.OrderByListBuilder<ContactInquiryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ContactInquiry>(
      columnValues: columnValues(ContactInquiry.t.updateTable),
      where: where(ContactInquiry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ContactInquiry.t),
      orderByList: orderByList?.call(ContactInquiry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ContactInquiry]s in the list and returns the deleted rows.
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
  Future<List<ContactInquiry>> delete(
    _is.DatabaseSession session,
    List<ContactInquiry> rows, {
    _is.OrderByBuilder<ContactInquiryTable>? orderBy,
    _is.OrderByListBuilder<ContactInquiryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ContactInquiry>(
      rows,
      orderBy: orderBy?.call(ContactInquiry.t),
      orderByList: orderByList?.call(ContactInquiry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ContactInquiry].
  Future<ContactInquiry> deleteRow(
    _is.DatabaseSession session,
    ContactInquiry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ContactInquiry>(
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
  Future<List<ContactInquiry>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ContactInquiryTable> where,
    _is.OrderByBuilder<ContactInquiryTable>? orderBy,
    _is.OrderByListBuilder<ContactInquiryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ContactInquiry>(
      where: where(ContactInquiry.t),
      orderBy: orderBy?.call(ContactInquiry.t),
      orderByList: orderByList?.call(ContactInquiry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ContactInquiryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ContactInquiry>(
      where: where?.call(ContactInquiry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ContactInquiry] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ContactInquiryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ContactInquiry>(
      where: where(ContactInquiry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ContactInquiryAttachRowRepository {
  const ContactInquiryAttachRowRepository._();

  /// Creates a relation between the given [ContactInquiry] and [Profile]
  /// by setting the [ContactInquiry]'s foreign key `profileId` to refer to the [Profile].
  Future<void> profile(
    _is.DatabaseSession session,
    ContactInquiry contactInquiry,
    _i1157qfm.Profile profile, {
    _is.Transaction? transaction,
  }) async {
    if (contactInquiry.id == null) {
      throw ArgumentError.notNull('contactInquiry.id');
    }
    if (profile.id == null) {
      throw ArgumentError.notNull('profile.id');
    }

    var $contactInquiry = contactInquiry.copyWith(profileId: profile.id);
    await session.db.updateRow<ContactInquiry>(
      $contactInquiry,
      columns: [ContactInquiry.t.profileId],
      transaction: transaction,
    );
  }
}
