class LocalLocationRecord {
  final int id;          // Auto-generated primary key for each record
  final double latitude; // Latitude of the location
  final double longitude; // Longitude of the location
  final DateTime timestamp; // Timestamp of the location record

  LocalLocationRecord({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  // Convert LocationRecord to a map, suitable for saving in SQLite
Map<String, dynamic> toMap() {
  return {
    'id': id,
    'latitude': latitude,
    'longitude': longitude,
    'timestamp': timestamp.millisecondsSinceEpoch, // ✅ Store as int instead of String
  };
}

  // Create a LocationRecord from a map (usually when fetching from SQLite)
  factory LocalLocationRecord.fromMap(Map<String, dynamic> map) {
    return LocalLocationRecord(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  // Convert LocationRecord to JSON (for APIs or other external purposes)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create a LocationRecord from JSON (useful for deserialization from APIs)
  factory LocalLocationRecord.fromJson(Map<String, dynamic> json) {
    return LocalLocationRecord(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
