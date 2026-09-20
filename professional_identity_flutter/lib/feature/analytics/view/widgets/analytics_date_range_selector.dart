import 'package:flutter/material.dart';
import '../../logic/providers/analytics_providers.dart';

class AnalyticsDateRangeSelector extends StatelessWidget {
  final AnalyticsDateRange selectedRange;
  final ValueChanged<AnalyticsDateRange> onRangeChanged;

  const AnalyticsDateRangeSelector({
    super.key,
    required this.selectedRange,
    required this.onRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<AnalyticsDateRange>(
        segments: const [
          ButtonSegment(
            value: AnalyticsDateRange.last7Days,
            label: Text('Last 7 Days'),
          ),
          ButtonSegment(
            value: AnalyticsDateRange.last30Days,
            label: Text('Last 30 Days'),
          ),
          ButtonSegment(
            value: AnalyticsDateRange.last90Days,
            label: Text('Last 90 Days'),
          ),
          ButtonSegment(
            value: AnalyticsDateRange.last12Months,
            label: Text('Last 12 Months'),
          ),
        ],
        selected: {selectedRange},
        onSelectionChanged: (newSelection) {
          if (newSelection.isNotEmpty) {
            onRangeChanged(newSelection.first);
          }
        },
      ),
    );
  }
}
