import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import '../models/inquiry_filter.dart';
import '../repo/inquiry_repository.dart';
import '../repo/serverpod_inquiry_repository.dart';

final inquiryRepositoryProvider = Provider<InquiryRepository>((ref) {
  return ServerpodInquiryRepository(client);
});

final inquiryFilterProvider = StateProvider<InquiryFilter>((ref) {
  return InquiryFilter.all;
});

final inquiriesListProvider =
    AsyncNotifierProvider<InquiriesNotifier, List<ContactInquiry>>(
      InquiriesNotifier.new,
    );

class InquiriesNotifier extends AsyncNotifier<List<ContactInquiry>> {
  @override
  Future<List<ContactInquiry>> build() async {
    final repo = ref.read(inquiryRepositoryProvider);
    return await repo.getMyInquiries();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(inquiryRepositoryProvider);
      return await repo.getMyInquiries();
    });
  }

  Future<void> toggleRead(int inquiryId, bool isRead) async {
    final repo = ref.read(inquiryRepositoryProvider);
    await repo.markInquiryRead(inquiryId: inquiryId, isRead: isRead);

    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncValue.data(
        current.map((item) {
          if (item.id == inquiryId) {
            return item.copyWith(isRead: isRead);
          }
          return item;
        }).toList(),
      );
    }
  }

  Future<void> toggleArchive(int inquiryId, bool isArchived) async {
    final repo = ref.read(inquiryRepositoryProvider);
    await repo.archiveInquiry(inquiryId: inquiryId, isArchived: isArchived);

    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncValue.data(
        current.map((item) {
          if (item.id == inquiryId) {
            return item.copyWith(isArchived: isArchived);
          }
          return item;
        }).toList(),
      );
    }
  }

  Future<void> deleteInquiry(int inquiryId) async {
    final repo = ref.read(inquiryRepositoryProvider);
    await repo.deleteInquiry(inquiryId: inquiryId);

    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncValue.data(
        current.where((item) => item.id != inquiryId).toList(),
      );
    }
  }
}

final filteredInquiriesProvider = Provider<List<ContactInquiry>>((ref) {
  final inquiries = ref.watch(inquiriesListProvider).valueOrNull ?? [];
  final filter = ref.watch(inquiryFilterProvider);

  switch (filter) {
    case InquiryFilter.all:
      return inquiries.where((i) => !i.isArchived).toList();
    case InquiryFilter.unread:
      return inquiries.where((i) => !i.isRead && !i.isArchived).toList();
    case InquiryFilter.archived:
      return inquiries.where((i) => i.isArchived).toList();
  }
});

final unreadInquiriesCountProvider = Provider<int>((ref) {
  final inquiries = ref.watch(inquiriesListProvider).valueOrNull ?? [];
  return inquiries.where((i) => !i.isRead && !i.isArchived).length;
});
