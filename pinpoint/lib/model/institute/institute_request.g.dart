// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institute_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstituteRequest _$InstituteRequestFromJson(Map<String, dynamic> json) =>
    InstituteRequest(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      baseAltitude: json['baseAltitude'] as String,
    );

Map<String, dynamic> _$InstituteRequestToJson(InstituteRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'baseAltitude': instance.baseAltitude,
    };
