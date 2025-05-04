import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:pinpoint/model/location/localLocationRecord.dart';
import 'package:pinpoint/repository/location_services/location_services.dart';
import 'package:pinpoint/viewModel/services/Storage/appStorage.dart';
import 'package:pinpoint/viewModel/services/Storage/localStorage.dart';

class LocationController with ChangeNotifier {
 LocationController(this._service) {
  Future.microtask(() async {
    await init();
  });
}


  double currentBase = 0;
  List<LocalLocationRecord>  locationHistory= [];
  LocationData? _currentLocation;
  bool _isTracking = false;

  final LocationService _service;
  AppStorage appStorage = AppStorage();
  LocalStorage localStorage = LocalStorage();

  bool get isTracking => _isTracking;
  LocationData? get currentLocation => _currentLocation;

  Future<void> init() async {
  await  getBase();
    notifyListeners();
  }

 Future<void> setBase(String base) async {
  currentBase = double.parse(base);  
    notifyListeners();  
  await localStorage.setValue("base", base);
  print("altitude base set: " + base);

}
Future<void> getBase() async {
  final storedBase = await localStorage.readValue("base");
  if (storedBase != null) {
    currentBase = double.tryParse(storedBase) ?? 0; // Ensure fallback value
  } else {
    currentBase = 0; // Default value if no base is stored
  }
  notifyListeners(); // Ensure UI updates
}


  Future<void> startTracking() async {
    print(_isTracking);
    _isTracking = true;
    notifyListeners();
  await appStorage.initDatabase();  // Initialize before use
    await _service.startLocationUpdates(
        onLocationUpdate: (LocationData location) {
      print("latitude " "${location.latitude}");
      print("longitude " "${location.longitude}");
      print("altitude " "${location.altitude}");
      _currentLocation = location;
      int formattedDate = DateTime.now().millisecondsSinceEpoch;
      Map<String, dynamic> locationNow = {
        "latitude": location.latitude,
        "longitude": location.longitude,
        "altitude": location.altitude,
        "timestamp": formattedDate,
      };
      appStorage.insertLocation(location.latitude!,location.longitude!,location.altitude!);
      notifyListeners();
    });
  }

  Future<void> stopTracking() async {
    _isTracking = false;
    notifyListeners();
    await _service.stopLocationUpdates();
  }

  // Future<void> syncOfflineData() async {
  //   await _service.syncLocalData();
  // }

Future<void> getLocationHistory() async { 
  List<Map<String, dynamic>> locations = await appStorage.getAllLocations();

  locationHistory = locations.map((location) {
    return LocalLocationRecord.fromMap(location);
  }).toList();

  print(locationHistory);  // Debugging purpose
  notifyListeners();
}
}
