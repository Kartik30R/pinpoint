import 'package:pinpoint/model/address/address.dart';

import 'package:json_annotation/json_annotation.dart';

part 'institute_request.g.dart';

@JsonSerializable()
class InstituteRequest {
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final Address? address;
    final String baseAltitude;


  InstituteRequest({
    this.name,
    this.phone,
    this.email,
    this.password,
    this.address,
    required this.baseAltitude,

  });

  factory InstituteRequest.fromJson(Map<String, dynamic> json) =>
      _$InstituteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InstituteRequestToJson(this);
}
