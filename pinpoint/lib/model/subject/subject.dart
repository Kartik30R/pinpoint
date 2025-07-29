import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
class SubjectRequest {
  final String name;
  final String code;
  final String instituteId;

  SubjectRequest({
    required this.name,
    required this.code,
    required this.instituteId,
  });

  factory SubjectRequest.fromJson(Map<String, dynamic> json) =>
      _$SubjectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectRequestToJson(this);
}

@JsonSerializable()
class SubjectResponse {
  final String id;
  final String name;
  final String code;
  final String instituteId;

  SubjectResponse({
    required this.id,
    required this.name,
    required this.code,
    required this.instituteId,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) =>
      _$SubjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectResponseToJson(this);
}
