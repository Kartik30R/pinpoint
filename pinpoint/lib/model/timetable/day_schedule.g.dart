// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DaySchedule _$DayScheduleFromJson(Map<String, dynamic> json) => DaySchedule(
      id: json['id'] as String,
      day: json['day'] as String,
      periods: (json['periods'] as List<dynamic>)
          .map((e) => Period.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayScheduleToJson(DaySchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'periods': instance.periods,
    };
