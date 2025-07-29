import 'package:uuid/uuid.dart';

class Address {
  final String id;
  final String streetAddress;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  Address({
    required this.id,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'] ?? const Uuid().v4(),
        streetAddress: json['streetAddress'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'streetAddress': streetAddress,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
      };
}
