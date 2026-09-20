import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../logic/providers/cv_providers.dart';
import '../widgets/cv_active_card.dart';
import '../widgets/cv_upload_card.dart';

class CvScreen extends HookConsumerWidget {
  const CvScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cvAsync = ref.watch(cvNotifierProvider);
    final theme = Theme.of(context);
    final isUploading = useState(false);
    final errorMessage = useState<String?>(null);

    Future<void> pickAndUploadCv() async {
      errorMessage.value = null;
      try {
        final file = await FilePicker.pickFile(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (file == null) {
          return;
        }

        if (file.extension?.toLowerCase() != 'pdf') {
          errorMessage.value = 'Only PDF documents (.pdf) are supported.';
          return;
        }

        const maxSizeBytes = 5 * 1024 * 1024;
        final fileSize = await file.length();
        if (fileSize == null || fileSize > maxSizeBytes) {
          errorMessage.value =
              'Selected file exceeds the maximum allowed limit of 5 MB.';
          return;
        }

        final bytes = await file.readAsBytes();
        if (bytes.isEmpty) {
          errorMessage.value = 'Could not read the selected file data.';
          return;
        }

        isUploading.value = true;
        final byteData = ByteData.sublistView(bytes);

        await ref
            .read(cvNotifierProvider.notifier)
            .uploadCv(
              file.name,
              byteData,
            );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('CV uploaded successfully!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        errorMessage.value = e.toString().replaceAll('Exception: ', '');
      } finally {
        isUploading.value = false;
      }
    }

    Future<void> confirmDelete() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Remove CV'),
          content: const Text(
            'Are you sure you want to remove your CV from your profile? This cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Remove'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        isUploading.value = true;
        try {
          await ref.read(cvNotifierProvider.notifier).deleteCv();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('CV removed from profile'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        } catch (e) {
          errorMessage.value = e.toString().replaceAll('Exception: ', '');
        } finally {
          isUploading.value = false;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('CV & Resume Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
            onPressed: () => ref.read(cvNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: SafeArea(
        child: cvAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: theme.colorScheme.error,
                  size: 44,
                ),
                const SizedBox(height: 12),
                Text('Failed to load CV status: $err'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(cvNotifierProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (cvUrl) {
            final hasCv = cvUrl != null && cvUrl.isNotEmpty;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (errorMessage.value != null) ...[
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: theme.colorScheme.error.withValues(
                                alpha: 0.3,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: theme.colorScheme.error,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  errorMessage.value!,
                                  style: TextStyle(
                                    color: theme.colorScheme.error,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                onPressed: () => errorMessage.value = null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (!hasCv)
                        CvUploadCard(
                          isUploading: isUploading.value,
                          onUpload: pickAndUploadCv,
                        )
                      else
                        CvActiveCard(
                          cvUrl: cvUrl,
                          isUploading: isUploading.value,
                          onReplace: pickAndUploadCv,
                          onDelete: confirmDelete,
                        ),
                      const SizedBox(height: 24),
                      Card(
                        color: theme.colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    size: 18,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Guidelines for CV Upload',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '• Allowed format: PDF (.pdf) only.\n'
                                '• Maximum file size: 5 MB.\n'
                                '• Uploading a new CV replaces the existing document.\n'
                                '• Having a CV uploaded increases your profile completion rate by 10%.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  height: 1.6,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
