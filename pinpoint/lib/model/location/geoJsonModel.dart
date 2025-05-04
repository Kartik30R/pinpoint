
import 'package:latlong2/latlong.dart';


class GeoJsonModel {
  final String type;
  final String name;
  final Crs crs;
  final List<Feature> features;

  GeoJsonModel({
    required this.type,
    required this.name,
    required this.crs,
    required this.features,
  });

  factory GeoJsonModel.fromJson(Map<String, dynamic> json) {
    return GeoJsonModel(
      type: json['type'],
      name: json['name'],
      crs: Crs.fromJson(json['crs']),
      features: (json['features'] as List)
          .map((f) => Feature.fromJson(f))
          .toList(),
    );
  }
}

class Crs {
  final String type;
  final Map<String, String> properties;

  Crs({
    required this.type,
    required this.properties,
  });

  factory Crs.fromJson(Map<String, dynamic> json) {
    return Crs(
      type: json['type'],
      properties: Map<String, String>.from(json['properties']),
    );
  }
}

class Feature {
  final String type;
  final Properties properties;
  final Geometry geometry;

  Feature({
    required this.type,
    required this.properties,
    required this.geometry,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      type: json['type'],
      properties: Properties.fromJson(json['properties']),
      geometry: Geometry.fromJson(json['geometry']),
    );
  }
}

class Properties {
  final int id;
  final String type;
  final String name;
  final int floor;

  Properties({
    required this.id,
    required this.type,
    required this.name,
    required this.floor,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      floor: json['floor'],
    );
  }
}


class Geometry {
  final String type;
  final List<List<List<List<double>>>> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

   List<LatLng> toLatLngList() {
    return coordinates
        .expand((multiPoly) => multiPoly)   // Flatten multi-polygons
        .expand((poly) => poly)             // Flatten polygons
        .map((point) => LatLng(point[1], point[0])) // Map to LatLng
        .toList();
  }

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      type: json['type'],
      coordinates: (json['coordinates'] as List)
          .map((multiPoly) => (multiPoly as List)
              .map((poly) => (poly as List)
                  .map((point) => List<double>.from(point))
                  .toList())
              .toList())
          .toList(),
    );
  }
}

