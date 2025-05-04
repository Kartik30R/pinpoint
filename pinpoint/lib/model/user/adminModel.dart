import 'package:pinpoint/model/user/baseUser.dart';
import 'package:pinpoint/resources/constant/string/userEnum.dart';

class AdminModel extends BaseUser {
  List<String> managedUsers;    // User IDs managed by the admin
  List<String> notices;         // Notices sent by admin
  Map<String, List<String>> locationHistory;  // User ID → Location history

  AdminModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required this.managedUsers,
    required this.notices,
    required this.locationHistory,
  }) : super(
    id: id,
    email: email,
    firstName: firstName,
    lastName: lastName,
    userType: UserType.admin,
  );

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'managedUsers': managedUsers,
      'notices': notices,
      'locationHistory': locationHistory,
    });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    id: json['id'],
    email: json['email'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    managedUsers: List<String>.from(json['managedUsers']),
    notices: List<String>.from(json['notices']),
    locationHistory: Map<String, List<String>>.from(json['locationHistory']),
  );
}
