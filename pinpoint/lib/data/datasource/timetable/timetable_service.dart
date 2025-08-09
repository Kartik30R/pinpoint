import 'package:pinpoint/model/timetable/day_schedule.dart';
import 'package:pinpoint/model/timetable/period.dart';
import 'package:pinpoint/model/timetable/timetable_detail.dart';
import 'package:pinpoint/model/timetable/timetable_summary.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';


part 'timetable_service.g.dart';

@RestApi(baseUrl: "https://your.api.url/api")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/timetables")
  Future<List<TimetableSummary>> getTimetables(@Header("Authorization") String token);

  @GET("/timetables/{id}")
  Future<TimetableDetail> getTimetableDetail(@Path("id") String id, @Header("Authorization") String token);

  // DaySchedule Endpoints
  @GET("/day-schedules/{id}")
  Future<DaySchedule> getDaySchedule(@Path("id") String id, @Header("Authorization") String token);

  @PUT("/day-schedules/{id}")
  Future<DaySchedule> updateDaySchedule(
    @Path("id") String id,
    @Body() DaySchedule schedule,
    @Header("Authorization") String token,
  );

  // Period Endpoints
  @GET("/periods/{id}")
  Future<Period> getPeriod(@Path("id") String id, @Header("Authorization") String token);

  @PUT("/periods/{id}")
  Future<Period> updatePeriod(
    @Path("id") String id,
    @Body() Period period,
    @Header("Authorization") String token,
  );
}

