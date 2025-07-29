import 'package:dio/dio.dart';
import 'package:pinpoint/model/message_response.dart';
import 'package:pinpoint/model/notice/notice.dart';
import 'package:pinpoint/resources/constant/string/appString.dart';
import 'package:retrofit/retrofit.dart';

part 'notice_service.g.dart';

@RestApi(baseUrl: "${AppString.baseUrl}")
abstract class NoticeService {
  factory NoticeService(Dio dio, {String baseUrl}) = _NoticeService;

  @POST('/api/notices')
  Future<NoticeDto> createNotice(@Body() NoticeDto notice);

  @PUT('/api/notices')
  Future<MessageResponse> updateNotice(@Body() NoticeDto notice);

  @DELETE('/api/notices/{id}')
  Future<MessageResponse> deleteNotice(@Path('id') String id);

  @GET('/api/notices/{adminId}')
  Future<List<NoticeDto>> getAllNoticesByAdmin(@Path('adminId') String adminId);
}
