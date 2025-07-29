import 'dart:convert';

class Admin {
  final String id;
  final String email;
  final String phone;
  final String? name;
  final String? otp;
  final String? createdAt;
  final String? updatedAt;
  final bool? isVerified;

  Admin({
    required this.id,
    required this.email,
    required this.phone,
    this.name,
    this.otp,
    this.createdAt,
    this.updatedAt,
    this.isVerified,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      otp: json['otp'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isVerified: json['verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "phone": phone,
      if (name != null) "name": name,
    };
  }

  static List<Admin> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Admin.fromJson(json)).toList();
  }
}
