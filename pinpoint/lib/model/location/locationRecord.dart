class LocationRecord {
  double latitude;
  double longitude;
  DateTime timestamp;

  LocationRecord({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'timestamp': timestamp.toIso8601String(),
  };

  factory LocationRecord.fromJson(Map<String, dynamic> json) => LocationRecord(
    latitude: json['latitude'],
    longitude: json['longitude'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}
