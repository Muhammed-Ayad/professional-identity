import 'dart:typed_data';
import 'package:professional_identity_client/professional_identity_client.dart';

class CvRepository {
  final Client _client;

  CvRepository(this._client);

  Future<String?> getMyCv() async {
    return await _client.cv.getMyCv();
  }

  Future<String> uploadCv(String fileName, ByteData fileBytes) async {
    return await _client.cv.uploadCv(fileName, fileBytes);
  }

  Future<void> deleteCv() async {
    await _client.cv.deleteCv();
  }
}
