import 'package:flutter/material.dart';
import '../../logic/models/profile_customization_theme.dart';

class ColorSelector extends StatelessWidget {
  final String? selectedHex;
  final ValueChanged<String> onSelected;

  const ColorSelector({
    super.key,
    required this.selectedHex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeHex = selectedHex?.toUpperCase() ?? '#2563EB';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.color_lens_rounded,
              size: 20,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Primary Accent Color',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Select an accent color used for buttons, links, icons, and highlights.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: ProfileCustomizationTheme.colorPalette.map((opt) {
            final isSelected = opt.hex.toUpperCase() == activeHex;

            return InkWell(
              onTap: () => onSelected(opt.hex),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? opt.color.withValues(alpha: 0.12)
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? opt.color
                        : theme.colorScheme.outlineVariant.withValues(
                            alpha: 0.6,
                          ),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: opt.color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: opt.color.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      opt.label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected ? opt.color : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
