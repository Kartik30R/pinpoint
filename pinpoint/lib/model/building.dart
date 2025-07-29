import 'dart:convert';

class Building {
  final String id;
  final String? name;
  final int? baseAltitude;
  final String? instituteId;

  Building({
    required this.id,
    this.name,
    this.baseAltitude,
    this.instituteId,
  });

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      id: json['id'],
      name: json['name'],
      baseAltitude: json['baseAltitude'],
      instituteId: json['institute']?['id'],
    );
  }

  static List<Building> listFromJson(String response) {
    final decoded = jsonDecode(response) as List;
    return decoded.map((e) => Building.fromJson(e)).toList();
  }
}
