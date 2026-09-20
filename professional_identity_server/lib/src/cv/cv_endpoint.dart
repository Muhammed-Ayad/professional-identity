import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../common/auth_profile_helper.dart';
import '../generated/protocol.dart';

class CvEndpoint extends Endpoint {
  static const int maxCvSizeBytes = 5 * 1024 * 1024; // 5 MB

  Future<String?> getMyCv(Session session) async {
    final profile = await getAuthenticatedProfile(session);
    return profile.cvUrl;
  }

  Future<String> uploadCv(
    Session session,
    String fileName,
    ByteData fileBytes,
  ) async {
    final profile = await getAuthenticatedProfile(session);

    // Validate file name and extension
    final trimmedName = fileName.trim().toLowerCase();
    if (!trimmedName.endsWith('.pdf')) {
      throw ProfileException(message: 'Only PDF documents (.pdf) are allowed.');
    }

    // Validate file size
    if (fileBytes.lengthInBytes <= 0) {
      throw ProfileException(message: 'Uploaded file cannot be empty.');
    }
    if (fileBytes.lengthInBytes > maxCvSizeBytes) {
      throw ProfileException(
        message: 'File size exceeds the maximum allowed limit of 5 MB.',
      );
    }

    // Validate PDF magic bytes (%PDF-)
    if (fileBytes.lengthInBytes < 5) {
      throw ProfileException(
        message: 'File is too small to be a valid PDF document.',
      );
    }
    final isPdfMagic =
        fileBytes.getUint8(0) == 0x25 &&
        fileBytes.getUint8(1) == 0x50 &&
        fileBytes.getUint8(2) == 0x44 &&
        fileBytes.getUint8(3) == 0x46 &&
        fileBytes.getUint8(4) == 0x2D;
    if (!isPdfMagic) {
      throw ProfileException(
        message: 'Invalid file format: file must be a valid PDF document.',
      );
    }

    // Scoped storage path
    final storagePath = 'cv/${profile.id}/cv.pdf';

    // Store in Serverpod cloud storage (DatabaseCloudStorage / ServerpodCloudProvider)
    await session.storage.storeFile(
      storageId: 'public',
      path: storagePath,
      byteData: fileBytes,
    );

    // Obtain public download URL
    final downloadUri = await session.storage.publicDownloadUrl(
      storageId: 'public',
      path: storagePath,
    );
    final cvUrl = downloadUri.toString();

    // Update profile record
    profile.cvUrl = cvUrl;
    profile.updatedAt = DateTime.now();
    await Profile.db.updateRow(session, profile);

    return cvUrl;
  }

  Future<void> deleteCv(Session session) async {
    final profile = await getAuthenticatedProfile(session);
    final storagePath = 'cv/${profile.id}/cv.pdf';

    try {
      await session.storage.deleteFile(
        storageId: 'public',
        path: storagePath,
      );
    } catch (_) {
      // Storage file might not exist, proceed to clear profile field
    }

    profile.cvUrl = null;
    profile.updatedAt = DateTime.now();
    await Profile.db.updateRow(session, profile);
  }
}
