// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodRequest _$PeriodRequestFromJson(Map<String, dynamic> json) =>
    PeriodRequest(
      subjectId: json['subjectId'] as String,
      batchId: json['batchId'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$PeriodRequestToJson(PeriodRequest instance) =>
    <String, dynamic>{
      'subjectId': instance.subjectId,
      'batchId': instance.batchId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };

PeriodResponse _$PeriodResponseFromJson(Map<String, dynamic> json) =>
    PeriodResponse(
      id: json['id'] as String,
      subjectId: json['subjectId'] as String,
      batchId: json['batchId'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$PeriodResponseToJson(PeriodResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectId': instance.subjectId,
      'batchId': instance.batchId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
