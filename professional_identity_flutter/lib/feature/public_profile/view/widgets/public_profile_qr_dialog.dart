import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_flutter/core/utils/qr_download_service.dart';
import 'package:professional_identity_flutter/core/utils/url_builder.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/providers/analytics_providers.dart';
import 'package:professional_identity_flutter/feature/share/view/widgets/public_profile_qr.dart';

Future<void> showPublicProfileQrDialog(
  BuildContext context,
  WidgetRef ref,
  String handle,
) async {
  ref
      .read(analyticsRepositoryProvider)
      .recordPublicEvent(
        handle: handle,
        eventType: 'profile_qr_view',
      );
  final fullUrl = PublicProfileUrlBuilder.buildUrl(handle);

  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text(
        'Profile QR Code',
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: 260,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PublicProfileQr(
              url: fullUrl,
              size: 200,
              showUrlSubtitle: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Close'),
        ),
        OutlinedButton.icon(
          onPressed: () async {
            ref
                .read(analyticsRepositoryProvider)
                .recordPublicEvent(
                  handle: handle,
                  eventType: 'profile_qr_download',
                );
            Navigator.of(ctx).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('QR code saved for /u/$handle'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            QrDownloadService.downloadQrImage(
              data: fullUrl,
              handle: handle,
            );
          },
          icon: const Icon(Icons.download_rounded, size: 16),
          label: const Text('Save QR'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            ref
                .read(analyticsRepositoryProvider)
                .recordPublicEvent(
                  handle: handle,
                  eventType: 'profile_link_copy',
                );
            Clipboard.setData(ClipboardData(text: fullUrl));
            Navigator.of(ctx).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Copied link $fullUrl to clipboard'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.copy_rounded, size: 16),
          label: const Text('Copy Link'),
        ),
      ],
    ),
  );
}
