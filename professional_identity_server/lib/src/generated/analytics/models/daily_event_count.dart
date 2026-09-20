/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class DailyEventCount
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DailyEventCount._({
    required this.date,
    required this.count,
  });

  factory DailyEventCount({
    required DateTime date,
    required int count,
  }) = _DailyEventCountImpl;

  factory DailyEventCount.fromJson(Map<String, dynamic> jsonSerialization) {
    return DailyEventCount(
      date: _is.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
      count: jsonSerialization['count'] as int,
    );
  }

  DateTime date;

  int count;

  /// Returns a shallow copy of this [DailyEventCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DailyEventCount copyWith({
    DateTime? date,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DailyEventCount',
      'date': date.toJson(),
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DailyEventCount',
      'date': date.toJson(),
      'count': count,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DailyEventCountImpl extends DailyEventCount {
  _DailyEventCountImpl({
    required DateTime date,
    required int count,
  }) : super._(
         date: date,
         count: count,
       );

  /// Returns a shallow copy of this [DailyEventCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DailyEventCount copyWith({
    DateTime? date,
    int? count,
  }) {
    return DailyEventCount(
      date: date ?? this.date,
      count: count ?? this.count,
    );
  }
}
