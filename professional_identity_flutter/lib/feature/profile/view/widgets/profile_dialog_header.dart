import 'package:flutter/material.dart';

class ProfileDialogHeader extends StatelessWidget {
  final bool isEdit;
  final bool isSubmitting;
  final VoidCallback onClose;

  const ProfileDialogHeader({
    super.key,
    required this.isEdit,
    required this.isSubmitting,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isEdit ? Icons.edit_note_rounded : Icons.person_add_rounded,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEdit
                    ? 'Edit Professional Profile'
                    : 'Create Your Professional Profile',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Your public identity starts with your unique handle',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: isSubmitting ? null : onClose,
        ),
      ],
    );
  }
}
