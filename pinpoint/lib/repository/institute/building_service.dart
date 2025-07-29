 import 'package:pinpoint/data/network/network_api_response.dart';
import 'package:pinpoint/model/building.dart';
  import 'package:pinpoint/repository/Storage/secure_storage_service.dart';

class BuildingService {
  final NetworkApiService _apiService = NetworkApiService();
  final SecureStorageService _storage = SecureStorageService();


  Future<List<Building>> getBuildingsByInstitute(String instituteId) async {
    final token = await _storage.jwt;
    final headers = {'Authorization': 'Bearer $token'};

    final response = await _apiService.getGetApiResponse(
      '${_apiService.baseUrl}/institute/$instituteId',
      headers: headers,
    );

    return (response as List).map((e) => Building.fromJson(e)).toList();
  }

  Future<Building> getBuildingById(String id) async {
    final token = await _storage.jwt;
    final headers = {'Authorization': 'Bearer $token'};

    final response = await _apiService.getGetApiResponse(
      '${_apiService.baseUrl}/$id',
      headers: headers,
    );

    return Building.fromJson(response);
  }

  Future<String> updateAltitude(String buildingId, int altitude) async {
    final token = await _storage.jwt;
    final headers = {'Authorization': 'Bearer $token'};

    final response = await _apiService.getPostApiResponse(
      '${_apiService.baseUrl}/$buildingId/altitude?baseAltitude=$altitude',
      null,
      headers: headers,
    );

    return response['message'];
  }
}
