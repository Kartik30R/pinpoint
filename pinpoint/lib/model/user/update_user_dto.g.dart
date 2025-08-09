// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserDto _$UpdateUserDtoFromJson(Map<String, dynamic> json) =>
    UpdateUserDto(
      name: json['name'] as String,
      phone: json['phone'] as String,
      isVerified: json['isVerified'] as bool,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      batch: json['batch'] == null
          ? null
          : BatchListResponse.fromJson(json['batch'] as Map<String, dynamic>),
      adminId: json['adminId'] as String?,
    );

Map<String, dynamic> _$UpdateUserDtoToJson(UpdateUserDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'isVerified': instance.isVerified,
      'address': instance.address,
      'batch': instance.batch,
      'adminId': instance.adminId,
    };
