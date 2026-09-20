enum InquiryFilter {
  all,
  unread,
  archived;

  String get label {
    switch (this) {
      case InquiryFilter.all:
        return 'All';
      case InquiryFilter.unread:
        return 'Unread';
      case InquiryFilter.archived:
        return 'Archived';
    }
  }
}
