import 'package:json_annotation/json_annotation.dart';

part 'period.g.dart';

@JsonSerializable()
class PeriodRequest {
  final String subjectId;
  final String batchId;
  final String startTime;
  final String endTime;

  PeriodRequest({
    required this.subjectId,
    required this.batchId,
    required this.startTime,
    required this.endTime,
  });

  factory PeriodRequest.fromJson(Map<String, dynamic> json) =>
      _$PeriodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodRequestToJson(this);
}

@JsonSerializable()
class PeriodResponse {
  final String id;
  final String subjectId;
  final String batchId;
  final String startTime;
  final String endTime;

  PeriodResponse({
    required this.id,
    required this.subjectId,
    required this.batchId,
    required this.startTime,
    required this.endTime,
  });

  factory PeriodResponse.fromJson(Map<String, dynamic> json) =>
      _$PeriodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodResponseToJson(this);
}
