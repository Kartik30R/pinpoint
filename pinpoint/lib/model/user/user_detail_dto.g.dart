// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailDto _$UserDetailDtoFromJson(Map<String, dynamic> json) =>
    UserDetailDto(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      isVerified: json['isVerified'] as bool,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      batch: json['batch'] == null
          ? null
          : BatchListResponse.fromJson(json['batch'] as Map<String, dynamic>),
      instituteId: json['instituteId'] as String?,
      adminId: json['adminId'] as String?,
      adminName: json['adminName'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserDetailDtoToJson(UserDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'isVerified': instance.isVerified,
      'address': instance.address,
      'batch': instance.batch,
      'instituteId': instance.instituteId,
      'adminId': instance.adminId,
      'adminName': instance.adminName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
