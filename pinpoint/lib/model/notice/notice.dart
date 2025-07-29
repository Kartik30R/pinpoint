import 'package:json_annotation/json_annotation.dart';

part 'notice.g.dart';

@JsonSerializable()
class NoticeDto {
  final String? id;
  final String title;
  final String message;
  final String? validUntil;
  final String? createdAt;

  NoticeDto({
    this.id,
    required this.title,
    required this.message,
    this.validUntil,
    this.createdAt,
  });

  factory NoticeDto.fromJson(Map<String, dynamic> json) =>
      _$NoticeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeDtoToJson(this);
}
