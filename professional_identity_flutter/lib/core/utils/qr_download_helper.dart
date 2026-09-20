import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

/// Non-web fallback for saving or sharing the QR code image.
Future<bool> saveOrDownloadQrFile(Uint8List bytes, String fileName) async {
  try {
    final file = XFile.fromData(
      bytes,
      mimeType: 'image/png',
      name: fileName,
    );
    await SharePlus.instance.share(
      ShareParams(
        files: [file],
        subject: fileName,
      ),
    );
    return true;
  } catch (_) {
    return false;
  }
}
