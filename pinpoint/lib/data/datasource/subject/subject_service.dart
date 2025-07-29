import 'package:dio/dio.dart';
import 'package:pinpoint/model/subject/subject.dart';
import 'package:pinpoint/resources/constant/string/appString.dart';
import 'package:retrofit/retrofit.dart';

part 'subject_service.g.dart';

@RestApi(baseUrl: "${AppString.baseUrl}/api/subjects")
abstract class SubjectService {
  factory SubjectService(Dio dio, {String baseUrl}) = _SubjectService;

  @GET("/{id}")
  Future<HttpResponse<SubjectResponse>> getSubjectById(@Path("id") String id);

  @GET("/institute/{instituteId}")
  Future<HttpResponse<List<SubjectResponse>>> getSubjectsByInstitute(
      @Path("instituteId") String instituteId);

  @POST("")
  Future<HttpResponse<SubjectResponse>> createSubject(
      @Body() SubjectRequest subject);

  @PUT("/{id}")
  Future<HttpResponse<SubjectResponse>> updateSubject(
      @Path("id") String id, @Body() SubjectRequest subject);

  @DELETE("/{id}")
  Future<HttpResponse<void>> deleteSubject(@Path("id") String id);
}
