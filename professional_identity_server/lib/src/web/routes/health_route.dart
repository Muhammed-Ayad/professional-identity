import 'dart:convert';
import 'package:serverpod/serverpod.dart';

/// Minimal production health-check route for reverse proxies and uptime monitors.
/// Returns simple JSON status without exposing sensitive server or environment data.
class HealthRoute extends Route {
  HealthRoute() : super(methods: {Method.get});

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final response = {
      'status': 'healthy',
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    };

    return Response.ok(
      body: Body.fromString(
        jsonEncode(response),
        mimeType: MimeType.json,
      ),
    );
  }
}
