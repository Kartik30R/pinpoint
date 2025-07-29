// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminRequest _$AdminRequestFromJson(Map<String, dynamic> json) => AdminRequest(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      instituteId: json['instituteId'] as String?,
    );

Map<String, dynamic> _$AdminRequestToJson(AdminRequest instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.email case final value?) 'email': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.password case final value?) 'password': value,
      if (instance.address case final value?) 'address': value,
      if (instance.instituteId case final value?) 'instituteId': value,
    };
