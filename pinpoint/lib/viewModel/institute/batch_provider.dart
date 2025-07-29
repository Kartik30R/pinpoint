
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/data/network/network_api_response.dart';
import 'package:pinpoint/repository/institute/batch_service.dart';
import 'package:pinpoint/viewModel/storage/secure_storage_provider.dart';

final batchServiceProvider = Provider<BatchService>((ref) {
  final api = NetworkApiService();
  final storage = ref.read(secureStorageProvider);
  return BatchService(api, storage);
});
