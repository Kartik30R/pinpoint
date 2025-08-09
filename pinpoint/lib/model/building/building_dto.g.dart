// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingDto _$BuildingDtoFromJson(Map<String, dynamic> json) => BuildingDto(
      id: json['id'] as String,
      name: json['name'] as String?,
      baseAltitude: (json['baseAltitude'] as num?)?.toInt(),
      ceilHeight: (json['ceilHeight'] as num?)?.toInt(),
      floors: (json['floors'] as List<dynamic>?)
          ?.map((e) => FloorDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingDtoToJson(BuildingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseAltitude': instance.baseAltitude,
      'ceilHeight': instance.ceilHeight,
      'floors': instance.floors,
    };
