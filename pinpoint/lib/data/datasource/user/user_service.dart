import 'package:dio/dio.dart';
import 'package:pinpoint/model/user/user_detail_dto.dart';
import 'package:pinpoint/model/user/user_list_dto.dart';


class UserApiService {
  final Dio _dio;

  UserApiService(this._dio);

  Future<List<UserListDto>> getAllUsers(String token, String instituteOrAdminId) async {
    final response = await _dio.get(
      '/api/users/all/$instituteOrAdminId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data as List)
        .map((json) => UserListDto.fromJson(json))
        .toList();
  }

  Future<UserDetailDto> getUserById(String token, String userId) async {
    final response = await _dio.get(
      '/api/users/$userId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return UserDetailDto.fromJson(response.data);
  }

  Future<void> deleteUser(String token, String userId) async {
    await _dio.delete(
      '/api/users/$userId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<void> updateUser(String token, String userId, Map<String, dynamic> body) async {
    await _dio.put(
      '/api/users/$userId',
      data: body,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
