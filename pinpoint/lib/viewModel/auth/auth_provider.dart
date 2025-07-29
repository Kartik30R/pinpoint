import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/DTO/auth.dart';
import 'package:pinpoint/repository/Storage/secure_storage_service.dart';
import 'package:pinpoint/repository/auth_services/auth_service.dart';
import 'package:pinpoint/viewModel/storage/secure_storage_provider.dart';

final authProvider = Provider<AuthController>((ref) {
  return AuthController(
    authServices: AuthServices(),
    storageService: ref.read(secureStorageProvider),
  );
});

class AuthController {
  final AuthServices authServices;
  final SecureStorageService storageService;

  AuthController({
    required this.authServices,
    required this.storageService,
  });

  /// Login and persist JWT
  Future<String?> login(String email, String password) async {
    final authReq = AuthRequest.forLogin(email: email, password: password);
    final response = await authServices.login(authReq);

    if (response.statusCode == "200" && response.jwt != null) {
      await storageService.saveAuthData(
        jwt: response.jwt!,
        role: response.role ?? '',
        userId: response.email ?? '', // Ideally should be user ID, not email
      );
      return null;
    } else {
      return response.message ?? response.error ?? "Login failed";
    }
  }

  /// Register a new user
  Future<String?> register(AuthRequest request) async {
    final response = await authServices.register(request);

    if (response.statusCode == "200") {
      // You could auto-login or return success
      return null;
    } else {
      return response.message ?? response.error ?? "Registration failed";
    }
  }

  /// Clear stored data
  Future<void> logout() async {
    await storageService.clearAll();
  }

  /// Check login state
  Future<bool> isLoggedIn() async {
    return await storageService.isLoggedIn();
  }
}
