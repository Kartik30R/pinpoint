import 'package:json_annotation/json_annotation.dart';
import 'package:pinpoint/model/address/address.dart';

part 'admin_request.g.dart';

@JsonSerializable(includeIfNull: false)
class AdminRequest {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final Address? address;
  final String? instituteId;

  AdminRequest({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.address,
    this.instituteId,
  });

  factory AdminRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRequestToJson(this);
}
