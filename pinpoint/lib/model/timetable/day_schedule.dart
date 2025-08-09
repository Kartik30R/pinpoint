import 'package:json_annotation/json_annotation.dart';
import 'period.dart';

part 'day_schedule.g.dart';

@JsonSerializable()
class DaySchedule {
  final String id;
  final String day;
  final List<Period> periods;

  DaySchedule({
    required this.id,
    required this.day,
    required this.periods,
  });

  factory DaySchedule.fromJson(Map<String, dynamic> json) =>
      _$DayScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$DayScheduleToJson(this);
}
