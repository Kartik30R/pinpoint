import 'package:pinpoint/resources/constant/string/userEnum.dart';

class BaseUser {
  String id;
  String email;
  String firstName;
  String lastName;
  UserType userType;

  BaseUser({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'userType': userType.toString().split('.').last,
  };

  factory BaseUser.fromJson(Map<String, dynamic> json) => BaseUser(
    id: json['id'],
    email: json['email'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    userType: UserType.values.firstWhere((e) => e.toString().split('.').last == json['userType']),
  );
}
