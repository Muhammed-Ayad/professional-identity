import 'package:flutter/material.dart';

class ExperienceDialogHeader extends StatelessWidget {
  final bool isEdit;
  final VoidCallback onClose;

  const ExperienceDialogHeader({
    super.key,
    required this.isEdit,
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
            Icons.work_outline_rounded,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            isEdit ? 'Edit Work Experience' : 'Add Work Experience',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: onClose,
        ),
      ],
    );
  }
}
