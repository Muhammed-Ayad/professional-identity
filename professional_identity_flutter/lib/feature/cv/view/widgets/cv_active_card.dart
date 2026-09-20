import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/url_launcher_helper.dart';

class CvActiveCard extends StatelessWidget {
  final String cvUrl;
  final bool isUploading;
  final VoidCallback onReplace;
  final VoidCallback onDelete;

  const CvActiveCard({
    super.key,
    required this.cvUrl,
    required this.isUploading,
    required this.onReplace,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CV Available',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Verified PDF document linked to your profile.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.picture_as_pdf_rounded,
                    color: Colors.redAccent,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      cvUrl,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy_rounded, size: 16),
                    tooltip: 'Copy CV Link',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: cvUrl));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('CV URL copied to clipboard'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: isUploading ? null : onReplace,
                  icon: isUploading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.file_upload_outlined),
                  label: const Text('Replace CV'),
                ),
                OutlinedButton.icon(
                  onPressed: () => UrlLauncherHelper.openUrl(context, cvUrl),
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: const Text('Open CV Link'),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                  onPressed: isUploading ? null : onDelete,
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: const Text('Remove'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
