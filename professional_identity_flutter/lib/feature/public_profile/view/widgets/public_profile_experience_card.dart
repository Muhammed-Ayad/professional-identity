import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'public_profile_helpers.dart';

class PublicProfileExperienceCard extends StatelessWidget {
  final List<Experience> experiences;

  const PublicProfileExperienceCard({
    super.key,
    required this.experiences,
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
                const Icon(Icons.work_outline_rounded, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Work Experience',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...experiences.asMap().entries.map((entry) {
              final index = entry.key;
              final exp = entry.value;
              final isLast = index == experiences.length - 1;

              final dateRange = exp.isCurrent
                  ? '${formatPublicDate(exp.startDate)} — Present'
                  : '${formatPublicDate(exp.startDate)} — ${exp.endDate != null ? formatPublicDate(exp.endDate!) : 'N/A'}';

              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              Text(
                                exp.jobTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              if (exp.isCurrent)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Current',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            exp.company,
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dateRange,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          if (exp.description != null &&
                              exp.description!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              exp.description!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.5,
                              ),
                            ),
                          ],
                          if (!isLast) ...[
                            const SizedBox(height: 16),
                            const Divider(),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
