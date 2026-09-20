import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:share_plus/share_plus.dart';

import 'package:professional_identity_flutter/core/utils/qr_download_service.dart';
import 'package:professional_identity_flutter/core/utils/url_builder.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/providers/analytics_providers.dart';
import '../../../profile/logic/providers/profile_providers.dart';
import '../widgets/public_profile_qr.dart';

/// Screen dedicated to viewing and sharing the user's professional identity
/// via scannable QR code, copying URL, or native share sheet.
class ShareIdentityScreen extends HookConsumerWidget {
  final Profile? initialProfile;

  const ShareIdentityScreen({super.key, this.initialProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileNotifierProvider);
    final profile = initialProfile ?? profileAsync.valueOrNull;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Identity'),
      ),
      body: SafeArea(
        child: profile == null
            ? (profileAsync.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'No profile found. Please create your profile first.',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ))
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Privacy Alert Banner (if private)
                        if (!profile.isPublic) ...[
                          Container(
                            padding: const EdgeInsets.all(14),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.amber.shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.amber.shade900,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Your profile is currently Private. Others visiting this URL will see a Profile Not Found notice.',
                                    style: TextStyle(
                                      color: Colors.amber.shade900,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Main Identity Card
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: theme.colorScheme.outlineVariant
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                // Avatar & Name
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor:
                                      theme.colorScheme.primaryContainer,
                                  child: Text(
                                    profile.fullName.isNotEmpty
                                        ? profile.fullName.characters.first
                                              .toUpperCase()
                                        : '?',
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                          color: theme
                                              .colorScheme
                                              .onPrimaryContainer,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  profile.fullName,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                if (profile.headline != null &&
                                    profile.headline!.trim().isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    profile.headline!,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 20),

                                // Scannable QR Code
                                PublicProfileQr(
                                  url: PublicProfileUrlBuilder.buildUrl(
                                    profile.handle,
                                  ),
                                  size: 210,
                                  showUrlSubtitle: true,
                                ),

                                const SizedBox(height: 16),
                                Text(
                                  'Scan this QR code with any camera or QR scanner to view this verified professional profile.',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  ref
                                      .read(analyticsRepositoryProvider)
                                      .recordPublicEvent(
                                        handle: profile.handle,
                                        eventType: 'profile_link_copy',
                                      );
                                  final fullUrl =
                                      PublicProfileUrlBuilder.buildUrl(
                                        profile.handle,
                                      );
                                  Clipboard.setData(
                                    ClipboardData(text: fullUrl),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Copied link $fullUrl to clipboard',
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.copy_rounded, size: 18),
                                label: const Text('Copy Link'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ref
                                      .read(analyticsRepositoryProvider)
                                      .recordPublicEvent(
                                        handle: profile.handle,
                                        eventType: 'profile_share',
                                      );
                                  final fullUrl =
                                      PublicProfileUrlBuilder.buildUrl(
                                        profile.handle,
                                      );
                                  SharePlus.instance.share(
                                    ShareParams(
                                      text:
                                          'Check out my verified professional identity: $fullUrl',
                                      subject:
                                          '${profile.fullName} - Professional Profile',
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.share_rounded, size: 18),
                                label: const Text('Share Profile'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Save / Download QR Code Button
                        OutlinedButton.icon(
                          onPressed: () {
                            ref
                                .read(analyticsRepositoryProvider)
                                .recordPublicEvent(
                                  handle: profile.handle,
                                  eventType: 'profile_qr_download',
                                );
                            final fullUrl = PublicProfileUrlBuilder.buildUrl(
                              profile.handle,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'QR code saved for /u/${profile.handle}',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                            QrDownloadService.downloadQrImage(
                              data: fullUrl,
                              handle: profile.handle,
                            );
                          },
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text('Save QR Code'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Preview Public Profile Button
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed('/u/${profile.handle}');
                          },
                          icon: const Icon(Icons.open_in_new_rounded, size: 16),
                          label: const Text('Open Public Profile View'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
