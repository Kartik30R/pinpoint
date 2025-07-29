
import 'package:pinpoint/data/network/network_api_response.dart';
import 'package:pinpoint/model/address.dart';

class AddressService {
  final  _apiService=NetworkApiService();


  Future<Address> createAddress(String instituteId, Address address) async {
    final response = await _apiService.getPostApiResponse(
      '${_apiService.baseUrl}/api/addresses/$instituteId',
      address.toJson(),
    );
    return Address.fromJson(response);
  }

  Future<Address> getAddress(String instituteId) async {
    final response = await _apiService.getGetApiResponse(
      '${_apiService.baseUrl}/api/addresses/$instituteId',
    );
    return Address.fromJson(response);
  }

  Future<String> updateAddress(Address address) async {
    final response = await _apiService.getPostApiResponse(
      '${_apiService.baseUrl}/api/addresses',
      address.toJson(),
    );
    return response['message'] ?? 'Updated';
  }

  Future<String> deleteAddress(String id) async {
    final response = await _apiService.getGetApiResponse(
      '${_apiService.baseUrl}/api/addresses/$id',
    );
    return response['message'] ?? 'Deleted';
  }
}