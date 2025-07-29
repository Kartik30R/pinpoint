import 'package:flutter_riverpod/flutter_riverpod.dart';
 import 'package:pinpoint/repository/location_services/geoJsonService.dart';
import 'package:pinpoint/viewModel/storage/secure_storage_provider.dart';

final geoJsonUploadProvider = Provider<GeoJsonUploadService>((ref) {
  final storage = ref.read(secureStorageProvider);
  return GeoJsonUploadService(storage);
});
