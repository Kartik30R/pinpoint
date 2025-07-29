import 'package:dio/dio.dart';
import 'package:pinpoint/DTO/auth.dart';
import 'package:pinpoint/resources/constant/string/appString.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';


@RestApi(baseUrl: "${AppString.baseUrl}/api/auth") 

abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST("/login")
  Future<HttpResponse<AuthRequest>> login(@Body() AuthRequest request);

  @POST("/register")
  Future<HttpResponse<AuthRequest>> register(@Body() AuthRequest request);
}
