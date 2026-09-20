import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/models/profile_customization_theme.dart';
import '../../logic/providers/profile_customization_providers.dart';
import 'color_selector.dart';
import 'theme_preset_selector.dart';

class CustomizationControlsSection extends StatelessWidget {
  final WidgetRef ref;
  final ProfileCustomization customization;

  const CustomizationControlsSection({
    super.key,
    required this.ref,
    required this.customization,
  });

  Widget _buildSectionHeader(
    ThemeData theme, {
    required String title,
    required IconData icon,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notifier = ref.read(profileCustomizationNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Theme Presets
        ThemePresetSelector(
          selectedPresetId: customization.themePreset,
          onSelected: (id) => notifier.setThemePreset(id),
        ),
        const SizedBox(height: 24),

        // 2. Primary Color Palette
        ColorSelector(
          selectedHex: customization.primaryColor,
          onSelected: (hex) => notifier.setPrimaryColor(hex),
        ),
        const SizedBox(height: 24),

        // 3. Background Style
        _buildSectionHeader(
          theme,
          title: 'Background Style',
          icon: Icons.wallpaper_rounded,
          description:
              'Choose a minimalist solid background or a subtle color-tinted gradient.',
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'solid', label: Text('Solid')),
              ButtonSegment(
                value: 'subtle_gradient',
                label: Text('Subtle Gradient'),
              ),
            ],
            selected: {customization.backgroundStyle},
            onSelectionChanged: (set) {
              if (set.isNotEmpty) notifier.setBackgroundStyle(set.first);
            },
          ),
        ),
        const SizedBox(height: 24),

        // 4. Card Style
        _buildSectionHeader(
          theme,
          title: 'Card Style',
          icon: Icons.layers_rounded,
          description:
              'Control the borders, elevation, and depth of profile content cards.',
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'outlined', label: Text('Outlined')),
              ButtonSegment(value: 'elevated', label: Text('Elevated')),
              ButtonSegment(value: 'flat', label: Text('Flat')),
            ],
            selected: {customization.cardStyle},
            onSelectionChanged: (set) {
              if (set.isNotEmpty) notifier.setCardStyle(set.first);
            },
          ),
        ),
        const SizedBox(height: 24),

        // 5. Border Radius Style
        _buildSectionHeader(
          theme,
          title: 'Border Radius',
          icon: Icons.rounded_corner_rounded,
          description:
              'Adjust the curvature of cards, buttons, badges, and chips.',
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'small', label: Text('Small (8px)')),
              ButtonSegment(value: 'medium', label: Text('Medium (16px)')),
              ButtonSegment(value: 'large', label: Text('Large (24px)')),
            ],
            selected: {customization.borderRadius},
            onSelectionChanged: (set) {
              if (set.isNotEmpty) notifier.setBorderRadius(set.first);
            },
          ),
        ),
        const SizedBox(height: 24),

        // 6. Typography Style
        _buildSectionHeader(
          theme,
          title: 'Typography Style',
          icon: Icons.text_fields_rounded,
          description:
              'Tailor the typographic personality of your landing page.',
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'modern', label: Text('Modern (Inter)')),
              ButtonSegment(value: 'classic', label: Text('Classic (Serif)')),
              ButtonSegment(value: 'compact', label: Text('Compact')),
            ],
            selected: {customization.typographyStyle},
            onSelectionChanged: (set) {
              if (set.isNotEmpty) notifier.setTypographyStyle(set.first);
            },
          ),
        ),
        const SizedBox(height: 32),

        // 7. Save Customization Button
        ElevatedButton.icon(
          onPressed: () async {
            try {
              await notifier.saveCustomization();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile appearance saved successfully!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            } catch (err) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to save appearance: $err'),
                    backgroundColor: theme.colorScheme.error,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          },
          icon: const Icon(Icons.check_rounded, size: 18),
          label: const Text('Save Appearance Changes'),
          style: ElevatedButton.styleFrom(
            backgroundColor: ProfileCustomizationTheme.parseColor(
              customization.primaryColor,
            ),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
