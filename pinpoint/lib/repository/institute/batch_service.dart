
import 'package:pinpoint/data/network/network_api_response.dart';
import 'package:pinpoint/model/batch.dart';
import 'package:pinpoint/repository/Storage/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BatchService {
  final NetworkApiService _apiService;
  final SecureStorageService storage;

  BatchService(this._apiService, this.storage);

  Future<List<BatchModel>> getAllBatches() async {
    final jwt = await storage.jwt;
    final response = await _apiService.getGetApiResponse(
      '${_apiService.baseUrl}/api/batches',
      headers: {'Authorization': 'Bearer $jwt'},
    );
    return List<BatchModel>.from(response.map((b) => BatchModel.fromJson(b)));
  }

  Future<BatchModel> createBatch(BatchModel batch) async {
    final jwt = await storage.jwt;
    final response = await _apiService.getPostApiResponse(
      '${_apiService.baseUrl}/api/batches',
      batch.toJson(),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    return BatchModel.fromJson(response);
  }

  Future<void> deleteBatch(String id) async {
    final jwt = await storage.jwt;
    await _apiService.getDeleteApiResponse(
      '${_apiService.baseUrl}/api/batches/$id',
      headers: {'Authorization': 'Bearer $jwt'},
    );
  }
}
