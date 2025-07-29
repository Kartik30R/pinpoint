import 'package:pinpoint/DTO/auth.dart';
import 'package:pinpoint/data/network/network_api_response.dart';

class AuthServices {
  final NetworkApiService service = NetworkApiService();

  Future<AuthRequest> register(AuthRequest user) async {
    final body = user.toJson();
    final response = await service.getPostApiResponse('${service.baseUrl}/api/auth/register', body);
    return AuthRequest.fromJson(response);
  }

  Future<AuthRequest> login(AuthRequest user) async {
    final body = user.toJson();
    final response = await service.getPostApiResponse('${service.baseUrl}/api/auth/login', body);
    return AuthRequest.fromJson(response);
  }
}
