import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable(includeIfNull: false)
class AuthRequest {
  final String? email;
  final String? phone;
  final String? password;
  final String? role; // Role as a string: "USER", "ADMIN", "INSTITUTE"
  final String? jwt;
  final String? statusCode;
  final String? error;
  final String? message;

  AuthRequest({
    this.email,
    this.phone,
    this.password,
    this.role,
    this.jwt,
    this.statusCode,
    this.error,
    this.message,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) => _$AuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
