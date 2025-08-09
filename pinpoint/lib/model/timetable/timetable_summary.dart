import 'package:json_annotation/json_annotation.dart';

part 'timetable_summary.g.dart';

@JsonSerializable()
class TimetableSummary {
  final String id;
  final String name;

  TimetableSummary({
    required this.id,
    required this.name,
  });

  factory TimetableSummary.fromJson(Map<String, dynamic> json) =>
      _$TimetableSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableSummaryToJson(this);
}
