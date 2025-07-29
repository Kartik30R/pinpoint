// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeDto _$NoticeDtoFromJson(Map<String, dynamic> json) => NoticeDto(
      id: json['id'] as String?,
      title: json['title'] as String,
      message: json['message'] as String,
      validUntil: json['validUntil'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$NoticeDtoToJson(NoticeDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'validUntil': instance.validUntil,
      'createdAt': instance.createdAt,
    };
