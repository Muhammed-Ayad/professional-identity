import 'package:flutter/material.dart';

Widget getPublicSocialIcon(String platform) {
  switch (platform.toLowerCase()) {
    case 'github':
      return const Icon(Icons.code_rounded, size: 16);
    case 'linkedin':
      return const Icon(Icons.business_center_rounded, size: 16);
    case 'twitter':
    case 'x':
      return const Icon(Icons.tag_rounded, size: 16);
    case 'website':
    case 'portfolio':
      return const Icon(Icons.language_rounded, size: 16);
    case 'youtube':
      return const Icon(Icons.video_collection_rounded, size: 16);
    default:
      return const Icon(Icons.link_rounded, size: 16);
  }
}

String formatPublicDate(DateTime d) {
  return '${d.year}-${d.month.toString().padLeft(2, '0')}';
}
