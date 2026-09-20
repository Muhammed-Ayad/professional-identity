import 'dart:html' as html;
import 'dart:typed_data';

/// Web implementation triggering a direct browser file download for the QR image.
Future<bool> saveOrDownloadQrFile(Uint8List bytes, String fileName) async {
  try {
    final blob = html.Blob([bytes], 'image/png');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..style.display = 'none';
    html.document.body?.children.add(anchor);
    anchor.click();
    anchor.remove();
    html.Url.revokeObjectUrl(url);
    return true;
  } catch (_) {
    return false;
  }
}
