import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:pinpoint/repository/Storage/secure_storage_service.dart';

class GeoJsonUploadService {
  final SecureStorageService storage;

  GeoJsonUploadService(this.storage);

  Future<bool> uploadGeoJsonFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['geojson'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final jwt = await storage.jwt;

      final uri = Uri.parse('https://your.api.url/api/sites/upload');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $jwt'
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final response = await request.send();
      return response.statusCode == 200;
    } else {
      return false;
    }
  }
}
