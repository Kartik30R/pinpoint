
import 'dart:async';
import 'package:location/location.dart';
import 'package:location/location.dart' as location;
import 'package:http/http.dart' as http;

class LocationService {
  Timer? _debounce;
  LocationData? _lastLocation;
  final Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;

  

 
  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location service is disabled.');
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission denied.');
      }
    }
  }

  ///**Enable High-Precision Location**
  Future<void> startLocationUpdates({required Function(LocationData) onLocationUpdate}) async {
    await _checkPermissions();
    _location.enableBackgroundMode(enable: true);
    _location.changeSettings(
      accuracy: location.LocationAccuracy.navigation,
      interval: 2, 
      distanceFilter: 3,
    );

    _locationSubscription = _location.onLocationChanged.listen((LocationData currentLocation) async {
      onLocationUpdate(currentLocation);
      //!
      // await _handleLocationUpdate(currentLocation);
    });
  }

  Future<void> stopLocationUpdates() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  ///  **Check GPS Accuracy**
  Future<bool> isPreciseLocationEnabled() async {
    LocationData locationData = await _location.getLocation();
    return locationData.accuracy != null && locationData.accuracy! <= 1.0; // Ensure accuracy <= 1m
  }


//!
  // Future<void> _handleLocationUpdate(LocationData currentLocation) async {
  //   bool isOnline = await _isDeviceOnline();
  //   final locationMap = {
  //     'latitude': currentLocation.latitude,
  //     'longitude': currentLocation.longitude,
  //     'timestamp': DateTime.now().millisecondsSinceEpoch,
  //   };

  //   if (isOnline) {
  //     bool success = await _sendLocationToServer(locationMap);
  //     if (!success) {
  //       await _saveLocationToLocalDatabase(locationMap);
  //     }
  //   } else {
  //     await _saveLocationToLocalDatabase(locationMap);
  //   }
  // }

// ! for future use

  Future<bool> _sendLocationToServer(Map<String, dynamic> location) async {
    // try {
    //   final response = await http.post(
    //     Uri.parse('https://your-api-endpoint.com/location'),
    //     body: {
    //       'latitude': location['latitude'].toString(),
    //       'longitude': location['longitude'].toString(),
    //       'timestamp': location['timestamp'].toString(),
    //     },
    //   );
    //   return response.statusCode == 200;
    // } catch (e) {
    //   print('Failed to send location: $e');
      return false;
    // }
  }


// !


  // Future<void> _saveLocationToLocalDatabase(Map<String, dynamic> location) async {
  //   await _database.insert('LocationData', location);
  // }

  // Future<void> syncLocalData() async {
  //   List<Map<String, dynamic>> storedLocations = await _database.query('LocationData', orderBy: 'timestamp ASC');

  //   for (var location in storedLocations) {
  //     bool success = await _sendLocationToServer(location);
  //     if (success) {
  //       await _database.delete('LocationData', where: 'id = ?', whereArgs: [location['id']]);
  //     } else {
  //       break;
  //     }
  //   }
  // }

  // bool _shouldUpdateLocation(LocationData lastLocation, LocationData currentLocation) {
  //   double distance = Geolocator.distanceBetween(
  //     lastLocation.latitude!, lastLocation.longitude!,
  //     currentLocation.latitude!, currentLocation.longitude!,
  //   );
  //   return distance >= _minDistance;
  // }

  /// ✅ **Helper function to check network status**
  Future<bool> _isDeviceOnline() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com'));
      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
