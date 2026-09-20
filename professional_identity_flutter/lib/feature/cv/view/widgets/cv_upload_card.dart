import 'package:flutter/material.dart';

class CvUploadCard extends StatelessWidget {
  final bool isUploading;
  final VoidCallback onUpload;

  const CvUploadCard({
    super.key,
    required this.isUploading,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.description_outlined,
                size: 52,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No CV uploaded yet.',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Upload your CV as a PDF (maximum 5 MB).',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: isUploading ? null : onUpload,
              icon: isUploading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.upload_file_rounded),
              label: const Text('Upload CV'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
