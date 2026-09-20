import 'package:flutter/material.dart';

class ExperienceDateRangeFields extends StatelessWidget {
  final bool isCurrent;
  final ValueChanged<bool> onCurrentChanged;
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback onPickStartDate;
  final VoidCallback onPickEndDate;
  final bool enabled;

  const ExperienceDateRangeFields({
    super.key,
    required this.isCurrent,
    required this.onCurrentChanged,
    required this.startDate,
    required this.endDate,
    required this.onPickStartDate,
    required this.onPickEndDate,
    this.enabled = true,
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
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('I currently work in this role'),
          value: isCurrent,
          onChanged: enabled ? (val) => onCurrentChanged(val ?? false) : null,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: enabled ? onPickStartDate : null,
                icon: const Icon(
                  Icons.calendar_today,
                  size: 16,
                ),
                label: Text(
                  'Start: ${_formatDate(startDate)}',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: (!enabled || isCurrent) ? null : onPickEndDate,
                icon: const Icon(
                  Icons.calendar_today,
                  size: 16,
                ),
                label: Text(
                  isCurrent ? 'Present' : 'End: ${_formatDate(endDate)}',
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
