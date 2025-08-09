import 'package:json_annotation/json_annotation.dart';
import 'package:pinpoint/model/timetable/period.dart';
import 'day_schedule.dart';

part 'timetable_detail.g.dart';

@JsonSerializable()
class TimetableDetail {
  final String id;
  final String name;
  final List<DaySchedule> schedules;

  TimetableDetail({
    required this.id,
    required this.name,
    required this.schedules,
  });

  factory TimetableDetail.fromJson(Map<String, dynamic> json) =>
      _$TimetableDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableDetailToJson(this);

  
  /// The missing static method to generate mock data.
  static TimetableDetail getMockData() {
    return TimetableDetail(
      id: 'tt-cs-2024',
      name: 'CS 2024 Weekly Timetable',
      schedules: [
        DaySchedule(
          id: 'day-mon',
          day: 'Monday',
          periods: [
            Period(id: 'p1', name: 'Period 1', startTime: '09:00 AM', endTime: '10:00 AM', subject: 'Data Structures', subjectId: 'sub-ds', teacher: 'Dr. Alan Grant', roomName: 'Room 101', roomId: 'r-101', scheduleDayId: 'day-mon'),
            Period(id: 'p2', name: 'Period 2', startTime: '10:00 AM', endTime: '11:00 AM', subject: 'Algorithms', subjectId: 'sub-algo', teacher: 'Dr. Ellie Sattler', roomName: 'Room 102', roomId: 'r-102', scheduleDayId: 'day-mon'),
          ],
        ),
        DaySchedule(
          id: 'day-tue',
          day: 'Tuesday',
          periods: [
            Period(id: 'p3', name: 'Period 1', startTime: '09:00 AM', endTime: '10:00 AM', subject: 'Operating Systems', subjectId: 'sub-os', teacher: 'Dr. Ian Malcolm', roomName: 'Room 201', roomId: 'r-201', scheduleDayId: 'day-tue'),
          ],
        ),
        DaySchedule(
          id: 'day-wed',
          day: 'Wednesday',
          periods: [
            Period(id: 'p4', name: 'Period 1', startTime: '09:00 AM', endTime: '10:00 AM', subject: 'Data Structures', subjectId: 'sub-ds', teacher: 'Dr. Alan Grant', roomName: 'Room 101', roomId: 'r-101', scheduleDayId: 'day-wed'),
            Period(id: 'p5', name: 'Period 2', startTime: '10:00 AM', endTime: '11:00 AM', subject: 'Database Systems', subjectId: 'sub-db', teacher: 'Dr. John Hammond', roomName: 'Room 205', roomId: 'r-205', scheduleDayId: 'day-wed'),
          ],
        ),
        DaySchedule(
          id: 'day-thu',
          day: 'Thursday',
          periods: [], // No classes
        ),
        DaySchedule(
          id: 'day-fri',
          day: 'Friday',
          periods: [
            Period(id: 'p6', name: 'Period 1', startTime: '10:00 AM', endTime: '11:00 AM', subject: 'Algorithms', subjectId: 'sub-algo', teacher: 'Dr. Ellie Sattler', roomName: 'Room 102', roomId: 'r-102', scheduleDayId: 'day-fri'),
          ],
        ),
      ],
    );
  }
}
