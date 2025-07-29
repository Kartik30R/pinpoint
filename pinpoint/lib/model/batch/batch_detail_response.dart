import 'package:json_annotation/json_annotation.dart';

part 'batch_detail_response.g.dart';

@JsonSerializable()
class BatchDetailResponse {
  final String id;
  final String name;
  final String code;
  final List<BatchUser> students;
  final List<BatchAdmin> admins;
  final String? timetableId;

  BatchDetailResponse({
    required this.id,
    required this.name,
    required this.code,
    required this.students,
    required this.admins,
    this.timetableId,
  });

  factory BatchDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchDetailResponseToJson(this);
}

@JsonSerializable()
class BatchUser {
  final String id;
  final String name;
  final String phone;

  BatchUser({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory BatchUser.fromJson(Map<String, dynamic> json) =>
      _$BatchUserFromJson(json);

  Map<String, dynamic> toJson() => _$BatchUserToJson(this);
}

@JsonSerializable()
class BatchAdmin {
  final String id;
  final String name;

  BatchAdmin({
    required this.id,
    required this.name,
  });

  factory BatchAdmin.fromJson(Map<String, dynamic> json) =>
      _$BatchAdminFromJson(json);

  Map<String, dynamic> toJson() => _$BatchAdminToJson(this);
}
