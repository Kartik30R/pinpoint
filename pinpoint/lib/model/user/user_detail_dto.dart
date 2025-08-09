import 'package:json_annotation/json_annotation.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/batch/batch_list_response.dart';

part 'user_detail_dto.g.dart';

@JsonSerializable()
class UserDetailDto {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final Address? address;
  final BatchListResponse? batch;
  final String? instituteId;
  final String? adminId;
  final String? adminName;
  final String createdAt;
  final String updatedAt;

  UserDetailDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    this.address,
    this.batch,
    this.instituteId,
    this.adminId,
    this.adminName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetailDto.fromJson(Map<String, dynamic> json) =>
      _$UserDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailDtoToJson(this);
}
