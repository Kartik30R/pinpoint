// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) => AuthRequest(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      jwt: json['jwt'] as String?,
      statusCode: json['statusCode'] as String?,
      error: json['error'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AuthRequestToJson(AuthRequest instance) =>
    <String, dynamic>{
      if (instance.email case final value?) 'email': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.password case final value?) 'password': value,
      if (instance.role case final value?) 'role': value,
      if (instance.jwt case final value?) 'jwt': value,
      if (instance.statusCode case final value?) 'statusCode': value,
      if (instance.error case final value?) 'error': value,
      if (instance.message case final value?) 'message': value,
    };
