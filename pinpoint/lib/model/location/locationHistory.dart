import 'package:pinpoint/model/location/locationRecord.dart';

class LocationHistory {
  String userId;                  // Reference to the user
  List<LocationRecord> history;   // List of location records

  LocationHistory({
    required this.userId,
    required this.history,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'history': history.map((e) => e.toJson()).toList(),
  };

  factory LocationHistory.fromJson(Map<String, dynamic> json) => LocationHistory(
    userId: json['userId'],
    history: (json['history'] as List)
        .map((e) => LocationRecord.fromJson(e))
        .toList(),
  );
}
