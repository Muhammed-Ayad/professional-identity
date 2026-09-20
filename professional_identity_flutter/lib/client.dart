import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

const String _productionServerUrl =
    'https://professional-identity.api.serverpod.space/';

Future<String> resolveServerUrl() async {
  const envUrl = String.fromEnvironment('SERVER_URL');
  if (envUrl.isNotEmpty) {
    return envUrl.endsWith('/') ? envUrl : '$envUrl/';
  }

  // In release mode on non-web (like Android APK), connect to the production cloud server
  if (kReleaseMode && !kIsWeb) {
    return _productionServerUrl;
  }

  try {
    final configuredUrl = await getServerUrl();
    if (kReleaseMode &&
        (configuredUrl.contains('localhost') ||
            configuredUrl.contains('127.0.0.1'))) {
      return _productionServerUrl;
    }
    return configuredUrl;
  } catch (_) {
    return _productionServerUrl;
  }
}

final serverUrl = resolveServerUrl();

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app.
late final Client client;

Future<void> initializeClient() async {
  client = Client(await serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  unawaited(client.auth.initialize());
}
