import 'package:flutter/foundation.dart';

/// Centralized utility to build full public profile URLs.
class PublicProfileUrlBuilder {
  PublicProfileUrlBuilder._();

  /// Default production / custom base URL fallback if not on web or configured otherwise.
  static String? _configuredBaseUrl;

  /// Allows setting a custom base URL (e.g. for testing or staging).
  static void setBaseUrl(String? url) {
    if (url == null || url.trim().isEmpty) {
      _configuredBaseUrl = null;
    } else {
      var trimmed = url.trim();
      if (trimmed.endsWith('/')) {
        trimmed = trimmed.substring(0, trimmed.length - 1);
      }
      _configuredBaseUrl = trimmed;
    }
  }

  /// Resolves the base origin / domain for the application.
  /// Defaults to configured base URL, or 'https://professional-identity.serverpod.space'
  static String get baseUrl {
    if (_configuredBaseUrl != null && _configuredBaseUrl!.isNotEmpty) {
      return _configuredBaseUrl!;
    }
    const envUrl = String.fromEnvironment('PUBLIC_BASE_URL');
    if (envUrl.isNotEmpty) {
      return envUrl;
    }
    if (kIsWeb) {
      final base = Uri.base;
      final portPart = (base.port == 80 || base.port == 443 || base.port == 0)
          ? ''
          : ':${base.port}';
      return '${base.scheme}://${base.host}$portPart';
    }
    return 'https://professional-identity.serverpod.space';
  }

  /// Builds the complete public profile URL for a given handle:
  /// e.g. `https://app.professionalidentity.dev/u/mohamed-ayad`
  static String buildUrl(String handle) {
    final cleanHandle = cleanHandleString(handle);
    return '$baseUrl/u/$cleanHandle';
  }

  /// Extracts and cleans the handle: trims leading/trailing spaces and leading '/u/'.
  static String cleanHandleString(String handle) {
    var trimmed = handle.trim();
    if (trimmed.startsWith('/u/')) {
      trimmed = trimmed.substring('/u/'.length);
    } else if (trimmed.startsWith('u/')) {
      trimmed = trimmed.substring('u/'.length);
    }
    return trimmed;
  }
}
