// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchListResponse _$BatchListResponseFromJson(Map<String, dynamic> json) =>
    BatchListResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$BatchListResponseToJson(BatchListResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
