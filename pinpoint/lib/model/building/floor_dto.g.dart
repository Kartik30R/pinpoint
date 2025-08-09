// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorDto _$FloorDtoFromJson(Map<String, dynamic> json) => FloorDto(
      id: json['id'] as String,
      level: (json['level'] as num).toInt(),
      rooms: (json['rooms'] as List<dynamic>?)
          ?.map((e) => RoomDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FloorDtoToJson(FloorDto instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'rooms': instance.rooms,
    };
