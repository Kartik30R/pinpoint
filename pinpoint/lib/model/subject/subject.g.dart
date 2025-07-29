// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectRequest _$SubjectRequestFromJson(Map<String, dynamic> json) =>
    SubjectRequest(
      name: json['name'] as String,
      code: json['code'] as String,
      instituteId: json['instituteId'] as String,
    );

Map<String, dynamic> _$SubjectRequestToJson(SubjectRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'instituteId': instance.instituteId,
    };

SubjectResponse _$SubjectResponseFromJson(Map<String, dynamic> json) =>
    SubjectResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      instituteId: json['instituteId'] as String,
    );

Map<String, dynamic> _$SubjectResponseToJson(SubjectResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'instituteId': instance.instituteId,
    };
