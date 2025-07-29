import 'package:dio/dio.dart';
import 'package:pinpoint/model/message_response.dart';
import 'package:pinpoint/model/period/period.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pinpoint/resources/constant/string/appString.dart';

part 'period_service.g.dart';

@RestApi(baseUrl: "${AppString.baseUrl}/api/periods")
abstract class PeriodService {
  factory PeriodService(Dio dio, {String baseUrl}) = _PeriodService;

  @POST("")
  Future<HttpResponse<MessageResponse>> createPeriod(
    @Body() PeriodRequest request,
  );

  @GET("/batch/{batchId}")
  Future<HttpResponse<List<PeriodResponse>>> getPeriodsByBatch(
    @Path("batchId") String batchId,
  );

  @PUT("/{periodId}")
  Future<HttpResponse<MessageResponse>> updatePeriod(
    @Path("periodId") String periodId,
    @Body() PeriodRequest request,
  );

  @DELETE("/{periodId}")
  Future<HttpResponse<MessageResponse>> deletePeriod(
    @Path("periodId") String periodId,
  );
}
