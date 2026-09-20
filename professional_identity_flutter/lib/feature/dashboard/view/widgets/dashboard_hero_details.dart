import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/core/utils/url_builder.dart';
import '../../../share/view/screens/share_identity_screen.dart';

class DashboardHeroDetails extends StatelessWidget {
  final Profile profile;
  final bool includeName;

  const DashboardHeroDetails({
    super.key,
    required this.profile,
    required this.includeName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final publicUrl = '/u/${profile.handle}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (includeName) ...[
          Text(
            profile.fullName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: [
            if (profile.availability != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      profile.availability!,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: profile.isPublic
                    ? Colors.blue.withValues(alpha: 0.1)
                    : Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: profile.isPublic
                      ? Colors.blue.withValues(alpha: 0.3)
                      : Colors.amber.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                profile.isPublic ? 'Public' : 'Private',
                style: TextStyle(
                  color: profile.isPublic
                      ? Colors.blue.shade700
                      : Colors.amber.shade800,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          profile.headline ?? 'No headline specified',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(publicUrl),
                  child: Text(
                    publicUrl,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                      decorationColor: theme.colorScheme.secondary.withValues(
                        alpha: 0.4,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    final fullUrl = PublicProfileUrlBuilder.buildUrl(
                      profile.handle,
                    );
                    Clipboard.setData(ClipboardData(text: fullUrl));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Copied $fullUrl to clipboard'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.copy_rounded,
                    size: 15,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ShareIdentityScreen(
                        initialProfile: profile,
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.qr_code_rounded,
                    size: 15,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(publicUrl),
                  child: const Icon(
                    Icons.open_in_new_rounded,
                    size: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            if (profile.location != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    profile.location!,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
