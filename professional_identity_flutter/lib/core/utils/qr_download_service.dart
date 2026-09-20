import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'qr_download_helper.dart'
    if (dart.library.html) 'qr_download_helper_web.dart';

class QrDownloadService {
  QrDownloadService._();

  /// Renders a QR code to PNG bytes and triggers a download / save dialog.
  static Future<bool> downloadQrImage({
    required String data,
    required String handle,
    double size = 600,
  }) async {
    try {
      final painter = QrPainter(
        data: data,
        version: QrVersions.auto,
        gapless: true,
        color: const Color(0xFF0F172A),
        emptyColor: const Color(0xFFFFFFFF),
      );

      final byteData = await painter.toImageData(
        size,
        format: ui.ImageByteFormat.png,
      );
      if (byteData == null) return false;

      final bytes = byteData.buffer.asUint8List();
      final cleanHandle = handle.replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '');
      final fileName = 'qr-$cleanHandle.png';

      return await saveOrDownloadQrFile(bytes, fileName);
    } catch (_) {
      return false;
    }
  }
}
