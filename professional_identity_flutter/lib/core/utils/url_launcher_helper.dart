import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper utility to reliably launch web URLs and email links,
/// with a graceful fallback to clipboard copying.
class UrlLauncherHelper {
  UrlLauncherHelper._();

  static Future<void> openUrl(BuildContext context, String rawUrl) async {
    var url = rawUrl.trim();
    if (url.isEmpty) return;

    // Normalize email addresses
    if (url.contains('@') &&
        !url.contains('://') &&
        !url.startsWith('mailto:')) {
      url = 'mailto:$url';
    } else if (!url.startsWith('http://') &&
        !url.startsWith('https://') &&
        !url.startsWith('mailto:')) {
      url = 'https://$url';
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      if (context.mounted) {
        _fallbackCopy(context, rawUrl);
      }
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _fallbackCopy(context, rawUrl);
      }
    } catch (_) {
      if (context.mounted) {
        _fallbackCopy(context, rawUrl);
      }
    }
  }

  static void _fallbackCopy(BuildContext context, String rawUrl) {
    Clipboard.setData(ClipboardData(text: rawUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $rawUrl to clipboard'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
