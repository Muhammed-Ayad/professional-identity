import 'package:flutter/material.dart';

class DashboardCompletionCard extends StatelessWidget {
  final int completionScore;
  final bool hasHeadlineAndBio;
  final bool hasSkills;
  final bool hasExperience;
  final bool hasProject;
  final bool hasSocialLink;
  final bool hasCv;

  const DashboardCompletionCard({
    super.key,
    required this.completionScore,
    required this.hasHeadlineAndBio,
    required this.hasSkills,
    required this.hasExperience,
    required this.hasProject,
    required this.hasSocialLink,
    required this.hasCv,
  });

  Widget _buildCriterionItem(
    ThemeData theme, {
    required String label,
    required bool isMet,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isMet ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          size: 16,
          color: isMet
              ? Colors.green
              : theme.colorScheme.onSurface.withValues(alpha: 0.35),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isMet
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressColor = completionScore == 100
        ? Colors.green
        : completionScore >= 60
        ? theme.colorScheme.primary
        : Colors.orange;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  completionScore == 100
                      ? Icons.verified_rounded
                      : Icons.speed_rounded,
                  color: progressColor,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Profile Completion',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: progressColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$completionScore% Complete',
                    style: TextStyle(
                      color: progressColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: completionScore / 100.0,
                minHeight: 8,
                backgroundColor: theme.colorScheme.onSurface.withValues(
                  alpha: 0.08,
                ),
                valueColor: AlwaysStoppedAnimation(progressColor),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildCriterionItem(
                  theme,
                  label: 'Headline & Bio (15%)',
                  isMet: hasHeadlineAndBio,
                ),
                _buildCriterionItem(
                  theme,
                  label: '3+ Skills (20%)',
                  isMet: hasSkills,
                ),
                _buildCriterionItem(
                  theme,
                  label: '1+ Experience (20%)',
                  isMet: hasExperience,
                ),
                _buildCriterionItem(
                  theme,
                  label: '1+ Project (20%)',
                  isMet: hasProject,
                ),
                _buildCriterionItem(
                  theme,
                  label: '1+ Social Link (15%)',
                  isMet: hasSocialLink,
                ),
                _buildCriterionItem(
                  theme,
                  label: 'CV Uploaded (10%)',
                  isMet: hasCv,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
