import 'package:flutter/foundation.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class AuthRepository {
  final Client _client;

  AuthRepository(this._client);

  bool get isAuthenticated => _client.auth.isAuthenticated;

  ValueListenable<AuthSuccess?> get authInfoListenable =>
      _client.auth.authInfoListenable;

  Future<void> signOut() async {
    await _client.auth.signOutDevice();
  }
}
