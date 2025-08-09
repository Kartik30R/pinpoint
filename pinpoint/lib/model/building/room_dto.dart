import 'package:json_annotation/json_annotation.dart';

part 'room_dto.g.dart';

@JsonSerializable()
class RoomDto {
  final String id;
  final String name;
  final String type;
  final int floorLevel;

  final List<List<List<double>>> geometry;

  RoomDto({
    required this.id,
    required this.name,
    required this.type,
    required this.floorLevel,
    required this.geometry,
  });

  factory RoomDto.fromJson(Map<String, dynamic> json) => _$RoomDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RoomDtoToJson(this);
}
