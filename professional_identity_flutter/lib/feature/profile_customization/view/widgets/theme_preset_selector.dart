import 'package:flutter/material.dart';
import '../../logic/models/profile_customization_theme.dart';

class ThemePresetSelector extends StatelessWidget {
  final String selectedPresetId;
  final ValueChanged<String> onSelected;

  const ThemePresetSelector({
    super.key,
    required this.selectedPresetId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.palette_rounded,
              size: 20,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Theme Presets',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Quickly apply a cohesive design style across your entire public profile.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 450;
            final cardWidth = isCompact
                ? (constraints.maxWidth - 12) / 2
                : (constraints.maxWidth - 36) / 4;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ProfileCustomizationTheme.presets.map((preset) {
                final isSelected = preset.id == selectedPresetId;
                final presetColor = ProfileCustomizationTheme.parseColor(
                  preset.defaultColor,
                );

                return SizedBox(
                  width: cardWidth,
                  child: InkWell(
                    onTap: () => onSelected(preset.id),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? presetColor.withValues(alpha: 0.08)
                            : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? presetColor
                              : theme.colorScheme.outlineVariant.withValues(
                                  alpha: 0.6,
                                ),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: presetColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  preset.icon,
                                  size: 20,
                                  color: presetColor,
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 18,
                                  color: presetColor,
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            preset.name,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isSelected ? presetColor : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            preset.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
