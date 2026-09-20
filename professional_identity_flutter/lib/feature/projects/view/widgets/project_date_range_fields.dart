import 'package:flutter/material.dart';

class ProjectDateRangeFields extends StatelessWidget {
  final bool isOngoing;
  final ValueChanged<bool> onOngoingChanged;
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback onPickStartDate;
  final VoidCallback onPickEndDate;

  const ProjectDateRangeFields({
    super.key,
    required this.isOngoing,
    required this.onOngoingChanged,
    required this.startDate,
    required this.endDate,
    required this.onPickStartDate,
    required this.onPickEndDate,
  });

  String _formatDate(DateTime? d) {
    if (d == null) return 'Select Date';
    return '${d.year}-${d.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          title: const Text('Ongoing project'),
          subtitle: const Text('Currently actively developing'),
          value: isOngoing,
          onChanged: (val) => onOngoingChanged(val),
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onPickStartDate,
                icon: const Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                ),
                label: Text(
                  startDate == null ? 'Start Date' : _formatDate(startDate),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isOngoing ? null : onPickEndDate,
                icon: const Icon(
                  Icons.event_available_rounded,
                  size: 16,
                ),
                label: Text(
                  isOngoing
                      ? 'Present'
                      : (endDate == null ? 'End Date' : _formatDate(endDate)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
