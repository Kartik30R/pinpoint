import 'package:json_annotation/json_annotation.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/batch/batch_list_response.dart';

part 'update_user_dto.g.dart';

@JsonSerializable()
class UpdateUserDto {
  final String name;
  final String phone;
  final bool isVerified;
  final Address address;
  final BatchListResponse? batch;
  final String? adminId;

  UpdateUserDto({
    required this.name,
    required this.phone,
    required this.isVerified,
    required this.address,
    this.batch,
    this.adminId,
  });

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);
}
