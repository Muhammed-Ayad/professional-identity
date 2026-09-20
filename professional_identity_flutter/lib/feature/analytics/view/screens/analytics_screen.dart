import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../logic/providers/analytics_providers.dart';
import '../widgets/analytics_breakdown_card.dart';
import '../widgets/analytics_date_range_selector.dart';
import '../widgets/analytics_metric_grid.dart';
import '../widgets/profile_views_chart.dart';

/// Full-featured, privacy-conscious SaaS analytics dashboard for the professional profile.
class AnalyticsScreen extends HookConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedRange = ref.watch(analyticsDateRangeProvider);
    final summaryAsync = ref.watch(analyticsSummaryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh Analytics',
            onPressed: () =>
                ref.read(analyticsSummaryNotifierProvider.notifier).refresh(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Section
                  Text(
                    'Profile Analytics',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Understand how people interact with your professional identity. All metrics are aggregated and privacy-friendly.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Date Range Filter
                  AnalyticsDateRangeSelector(
                    selectedRange: selectedRange,
                    onRangeChanged: (newRange) {
                      ref.read(analyticsDateRangeProvider.notifier).state =
                          newRange;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Content Body
                  summaryAsync.when(
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(48.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (err, stack) => Card(
                      color: theme.colorScheme.errorContainer.withValues(
                        alpha: 0.4,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              color: theme.colorScheme.error,
                              size: 36,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Failed to load analytics',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              err.toString(),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => ref
                                  .read(
                                    analyticsSummaryNotifierProvider.notifier,
                                  )
                                  .refresh(),
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    data: (summary) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Metric Summary Cards Grid
                          AnalyticsMetricGrid(summary: summary),

                          const SizedBox(height: 24),

                          // 2. Trend Chart: Profile Views Over Time
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: theme.colorScheme.outlineVariant
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timeline_rounded,
                                        size: 20,
                                        color: theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Profile Views Over Time',
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  ProfileViewsChart(
                                    dailyViews: summary.dailyProfileViews,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // 3. Bottom Breakdowns: Top Social & Top Projects
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isCompact = constraints.maxWidth < 700;
                              final colWidth = isCompact
                                  ? constraints.maxWidth
                                  : (constraints.maxWidth - 16) / 2;

                              return Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: [
                                  SizedBox(
                                    width: colWidth,
                                    child: AnalyticsBreakdownCard(
                                      title: 'Top Social Links',
                                      icon: Icons.link_rounded,
                                      items: summary.socialLinkClicksByPlatform,
                                      emptyMessage: 'No social link clicks yet',
                                    ),
                                  ),
                                  SizedBox(
                                    width: colWidth,
                                    child: AnalyticsBreakdownCard(
                                      title: 'Top Projects',
                                      icon: Icons.laptop_chromebook_rounded,
                                      items: summary.projectClicksByProject,
                                      emptyMessage: 'No project clicks yet',
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
