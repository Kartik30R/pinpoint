import 'package:json_annotation/json_annotation.dart';
import 'room_dto.dart';

part 'floor_dto.g.dart';

@JsonSerializable()
class FloorDto {
  final String id;
  final int level;
  final List<RoomDto>? rooms;

  FloorDto({
    required this.id,
    required this.level,
    this.rooms,
  });

  factory FloorDto.fromJson(Map<String, dynamic> json) => _$FloorDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FloorDtoToJson(this);
}
