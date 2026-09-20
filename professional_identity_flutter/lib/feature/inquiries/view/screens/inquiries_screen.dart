import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../logic/models/inquiry_filter.dart';
import '../../logic/providers/inquiry_providers.dart';
import '../widgets/inquiry_empty_state.dart';
import '../widgets/inquiry_item_card.dart';

class InquiriesScreen extends ConsumerWidget {
  const InquiriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inquiriesAsync = ref.watch(inquiriesListProvider);
    final filteredList = ref.watch(filteredInquiriesProvider);
    final currentFilter = ref.watch(inquiryFilterProvider);
    final unreadCount = ref.watch(unreadInquiriesCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: Text(
                'Contact Inquiries',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh Inquiries',
            onPressed: () => ref.read(inquiriesListProvider.notifier).refresh(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Selector Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: InquiryFilter.values.map((filter) {
                    final isSelected = currentFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filter.label),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            ref.read(inquiryFilterProvider.notifier).state =
                                filter;
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Inquiries List Content
            Expanded(
              child: inquiriesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 40,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 12),
                      Text('Failed to load inquiries: $err'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            ref.read(inquiriesListProvider.notifier).refresh(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
                data: (_) {
                  if (filteredList.isEmpty) {
                    return InquiryEmptyState(filter: currentFilter);
                  }

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final item = filteredList[index];
                          return InquiryItemCard(inquiry: item);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
