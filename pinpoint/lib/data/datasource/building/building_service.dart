import 'package:dio/dio.dart';
import 'package:pinpoint/model/building/building_dto.dart';
import 'package:pinpoint/model/building/floor_dto.dart';
import 'package:pinpoint/model/building/room_dto.dart';
import 'package:pinpoint/resources/constant/string/appString.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';


part 'building_service.g.dart';

@RestApi(baseUrl: AppString.baseUrl)
abstract class BuildingService {
  factory BuildingService(Dio dio, {String baseUrl}) = _BuildingService;

  @GET("/buildings/institute/{instituteId}")
  Future<List<BuildingDto>> getBuildingsByInstitute(
    @Path("instituteId") String instituteId,
    @Header("Authorization") String token,
  );

  @GET("/buildings/{buildingId}")
  Future<BuildingDto> getBuildingById(
    @Path("buildingId") String id,
    @Header("Authorization") String token,
  );

  @GET("/floors/building/{buildingId}")
  Future<List<FloorDto>> getFloorsByBuilding(
    @Path("buildingId") String buildingId,
  );

  @GET("/rooms/building/{buildingId}")
  Future<List<RoomDto>> getRoomsByBuilding(
    @Path("buildingId") String buildingId,
    @Header("Authorization") String token,
  );

  @GET("/rooms/floor/{floorLevel}")
  Future<List<RoomDto>> getRoomsByFloor(
    @Path("floorLevel") int floorLevel,
    @Header("Authorization") String token,
  );
}
