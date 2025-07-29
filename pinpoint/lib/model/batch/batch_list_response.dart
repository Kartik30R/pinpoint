import 'package:json_annotation/json_annotation.dart';

part 'batch_list_response.g.dart';

@JsonSerializable()
class BatchListResponse {
  final String id;
  final String name;
  final String code;

  BatchListResponse({
    required this.id,
    required this.name,
    required this.code,
  });

  factory BatchListResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchListResponseToJson(this);
}
