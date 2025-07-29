import 'package:pinpoint/model/institute/institute.dart';
import 'package:pinpoint/model/institute/institute_request.dart';
import 'package:pinpoint/model/message_response.dart';
import 'package:pinpoint/resources/constant/string/appString.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'institute_service.g.dart';

@RestApi(baseUrl: AppString.baseUrl)
abstract class InstituteApi {
  factory InstituteApi(Dio dio, {String baseUrl}) = _InstituteApi;

  @GET("/api/institute")
  Future<InstituteResponse> getInstitute();

  @PUT("/api/institute")
  Future<MessageResponse> updateInstitute(
    @Body() InstituteRequest request,
  );

  @DELETE("/api/institute")
  Future<MessageResponse> deleteInstitute(
  );
}
