// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Period _$PeriodFromJson(Map<String, dynamic> json) => Period(
      id: json['id'] as String,
      name: json['name'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      subject: json['subject'] as String,
      subjectId: json['subjectId'] as String,
      teacher: json['teacher'] as String,
      roomName: json['roomName'] as String,
      roomId: json['roomId'] as String,
      scheduleDayId: json['scheduleDayId'] as String,
    );

Map<String, dynamic> _$PeriodToJson(Period instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'subject': instance.subject,
      'subjectId': instance.subjectId,
      'teacher': instance.teacher,
      'roomName': instance.roomName,
      'roomId': instance.roomId,
      'scheduleDayId': instance.scheduleDayId,
    };
