import 'package:json_annotation/json_annotation.dart';

part 'period.g.dart';


@JsonSerializable()
class Period {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final String subject;
  final String subjectId;
  final String teacher;
  final String roomName;
  final String roomId;
  final String scheduleDayId;

  Period({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.subjectId,
    required this.teacher,
    required this.roomName,
    required this.roomId,
    required this.scheduleDayId,
  });

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodToJson(this);
}
