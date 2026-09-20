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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class ProfileException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  ProfileException._({required this.message});

  factory ProfileException({required String message}) = _ProfileExceptionImpl;

  factory ProfileException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfileException(message: jsonSerialization['message'] as String);
  }

  String message;

  /// Returns a shallow copy of this [ProfileException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProfileException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileException',
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileException',
      'message': message,
    };
  }

  @override
  String toString() {
    return 'ProfileException(message: $message)';
  }
}

class _ProfileExceptionImpl extends ProfileException {
  _ProfileExceptionImpl({required String message}) : super._(message: message);

  /// Returns a shallow copy of this [ProfileException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProfileException copyWith({String? message}) {
    return ProfileException(message: message ?? this.message);
  }
}
