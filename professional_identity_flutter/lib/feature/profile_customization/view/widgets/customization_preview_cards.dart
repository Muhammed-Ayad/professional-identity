import 'package:flutter/material.dart';

class CustomizationPreviewSkillsCard extends StatelessWidget {
  final Color cardBgColor;
  final double cardElevation;
  final ShapeBorder cardShape;
  final Color primary;
  final Color textColor;
  final TextTheme textTheme;

  const CustomizationPreviewSkillsCard({
    super.key,
    required this.cardBgColor,
    required this.cardElevation,
    required this.cardShape,
    required this.primary,
    required this.textColor,
    required this.textTheme,
  });

  Widget _buildSkillChip(String label, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardBgColor,
      elevation: cardElevation,
      shape: cardShape,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.psychology_rounded,
                  size: 18,
                  color: primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Verified Skills',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _buildSkillChip('Flutter & Dart', primary),
                _buildSkillChip('Serverpod 4', primary),
                _buildSkillChip('PostgreSQL', primary),
                _buildSkillChip('Riverpod', primary),
                _buildSkillChip('Cloud Architecture', primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomizationPreviewProjectCard extends StatelessWidget {
  final Color cardBgColor;
  final double cardElevation;
  final ShapeBorder cardShape;
  final Color primary;
  final Color textColor;
  final Color textSubColor;
  final TextTheme textTheme;

  const CustomizationPreviewProjectCard({
    super.key,
    required this.cardBgColor,
    required this.cardElevation,
    required this.cardShape,
    required this.primary,
    required this.textColor,
    required this.textSubColor,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardBgColor,
      elevation: cardElevation,
      shape: cardShape,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.laptop_chromebook_rounded,
                  size: 18,
                  color: primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Featured Project',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Professional Identity Platform',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Full-stack digital identity and portfolio with privacy-conscious analytics and customizable branding.',
              style: textTheme.bodySmall?.copyWith(
                color: textSubColor,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
