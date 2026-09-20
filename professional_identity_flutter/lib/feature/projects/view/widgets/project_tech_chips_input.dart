import 'package:flutter/material.dart';

class ProjectTechChipsInput extends StatelessWidget {
  final TextEditingController controller;
  final List<String> technologies;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;

  const ProjectTechChipsInput({
    super.key,
    required this.controller,
    required this.technologies,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technologies & Tools *',
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Add tech (e.g. Flutter, PostgreSQL)',
                  isDense: true,
                ),
                onSubmitted: (_) => onAdd(),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              icon: const Icon(Icons.add_rounded),
              onPressed: onAdd,
              tooltip: 'Add Tech',
            ),
          ],
        ),
        if (technologies.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: technologies.map((tech) {
              return Chip(
                label: Text(tech),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => onRemove(tech),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
