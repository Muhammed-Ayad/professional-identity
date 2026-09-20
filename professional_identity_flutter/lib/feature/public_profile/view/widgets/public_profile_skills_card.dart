import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';

class PublicProfileSkillsCard extends StatelessWidget {
  final List<Skill> skills;

  const PublicProfileSkillsCard({
    super.key,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: theme.cardTheme.elevation ?? 0,
      shape: theme.cardTheme.shape,
      color: theme.cardTheme.color,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bolt_rounded, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Skills & Expertise',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${skills.length} skills',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) {
                final hasExp =
                    skill.yearsOfExperience != null &&
                    skill.yearsOfExperience! > 0;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          skill.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasExp) ...[
                        const SizedBox(width: 6),
                        Text(
                          '${skill.yearsOfExperience}y',
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
