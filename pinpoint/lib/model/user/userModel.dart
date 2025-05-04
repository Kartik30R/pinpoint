import 'package:pinpoint/model/user/baseUser.dart';
import 'package:pinpoint/resources/constant/string/userEnum.dart';

class UserModel extends BaseUser {
  List<String> notices;         // Notices from admin
  List<String> notes;           // Personal notes

  UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required this.notices,
    required this.notes,
  }) : super(
    id: id,
    email: email,
    firstName: firstName,
    lastName: lastName,
    userType: UserType.user,
  );

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'notices': notices,
      'notes': notes,
    });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    notices: List<String>.from(json['notices']),
    notes: List<String>.from(json['notes']),
  );
}
