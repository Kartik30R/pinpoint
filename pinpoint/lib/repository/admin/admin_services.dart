import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pinpoint/model/user/adminModel.dart';
import 'package:pinpoint/repository/Storage/secure_storage_service.dart';

class AdminService {
  final SecureStorageService storage;

  AdminService(this.storage);

  Future<String?> _getToken() async => await storage.jwt;

  Future<List<Admin>> getAdminsByInstitute(String instituteId) async {
    final token = await _getToken();
    final res = await http.get(
      Uri.parse('http://your-api-url/api/admins/institute/$instituteId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) {
      return Admin.fromJsonList(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load admins');
    }
  }

  Future<Admin> getAdminById(String adminId) async {
    final token = await _getToken();
    final res = await http.get(
      Uri.parse('http://your-api-url/api/admins/$adminId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (res.statusCode == 200) {
      return Admin.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to fetch admin');
    }
  }

  Future<void> createAdmin({
    required String email,
    required String phone,
    required String password,
  }) async {
    final token = await _getToken();
    final body = jsonEncode({
      "email": email,
      "phone": phone,
      "password": password,
      "role": "ADMIN"
    });
    final res = await http.post(
      Uri.parse('http://your-api-url/api/admins'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to create admin: ${res.body}');
    }
  }

  Future<void> updateAdmin(String adminId, Map<String, dynamic> updates) async {
    final token = await _getToken();
    final res = await http.put(
      Uri.parse('http://your-api-url/api/admins/$adminId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updates),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to update admin');
    }
  }

  Future<void> deleteAdmin(String adminId) async {
    final token = await _getToken();
    final res = await http.delete(
      Uri.parse('http://your-api-url/api/admins/$adminId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to delete admin');
    }
  }
}
