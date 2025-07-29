import 'package:dio/dio.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/message_response.dart';
import 'package:pinpoint/resources/constant/string/appString.dart';
import 'package:retrofit/retrofit.dart';

part 'address_service.g.dart';

@RestApi(baseUrl: "${AppString.baseUrl}/api/addresses")
abstract class AddressService {
  factory AddressService(Dio dio, {String baseUrl}) = _AddressService;

  @POST("/{instituteId}")
  Future<HttpResponse<Address>> createAddress(
    @Path("instituteId") String instituteId,
    @Body() Address address,
  );

  @GET("/{instituteId}")
  Future<HttpResponse<Address>> getAddress(@Path("instituteId") String instituteId);

  @PUT("")
  Future<HttpResponse<MessageResponse>> updateAddress(@Body() Address address);

  @DELETE("/{id}")
  Future<HttpResponse<MessageResponse>> deleteAddress(@Path("id") String id);
}
