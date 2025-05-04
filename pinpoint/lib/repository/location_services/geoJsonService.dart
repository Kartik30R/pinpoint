
import 'package:pinpoint/model/location/geoJsonModel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pinpoint/resources/constant/string/featureEnum.dart';

class GeoJsonService {


  Future<GeoJsonModel> parseGeoJson(String path) async {
    final String data = await rootBundle.loadString(path);
    final Map<String, dynamic> json = jsonDecode(data);
    return GeoJsonModel.fromJson(json);
  }


List<Feature> filterFeatures(List<Feature> features, PropertyKey key, dynamic value) {
  return features.where((feature) {
    final properties = feature.properties;
    switch (key) {
      case PropertyKey.id:
        return properties.id == value;
      case PropertyKey.type:
        return properties.type == value;
      case PropertyKey.name:
        return properties.name == value;
      case PropertyKey.floor:
        return properties.floor == value;
    }
  }).toList();
}
//?  another way to filter features
// List<Feature>  features = geoJson.features.where((feature) {
      //   return feature.properties.floor == 1; // Filter by floor number
      // }).toList();

  // List<Map<String, dynamic>> extractData(List<Feature> features) {
  //   return features.map((feature) {
  //     return {
  //       'id': feature.properties.id,
  //       'name': feature.properties.name,
  //       'type': feature.properties.type,
  //       'floor': feature.properties.floor,
  //       'coordinates': feature.geometry.coordinates,
  //     };
  //   }).toList();
  // }
}
