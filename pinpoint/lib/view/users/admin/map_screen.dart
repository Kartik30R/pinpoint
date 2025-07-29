// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_geojson/flutter_map_geojson.dart';
// // import 'package:flutter_map_polywidget/flutter_map_polywidget.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
// import 'package:pinpoint/model/location/geoJsonModel.dart';
// import 'package:pinpoint/repository/location_services/geoJsonService.dart';
// import 'package:pinpoint/resources/constant/string/appString.dart';
// import 'package:pinpoint/resources/constant/string/featureEnum.dart';
// import 'package:pinpoint/viewModel/location/locationController.dart';
// import 'package:provider/provider.dart';


// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GeoJsonService geoJsonService= GeoJsonService();
//   GeoJsonParser geoJsonParser = GeoJsonParser(
//     defaultMarkerColor: Colors.red,
//     defaultPolygonBorderColor: Colors.red,
//     defaultPolygonFillColor: Colors.red.withOpacity(0.1),
//     defaultCircleMarkerColor: Colors.red.withOpacity(0.25),
//   );
// late GeoJsonModel geoJsonModel;
//   bool loadingData = false;

//   bool myFilterFunction(Map<String, dynamic> properties) {
//     return !properties['section'].toString().contains('Point M-4');
//   }

//   void onTapMarkerFunction(Map<String, dynamic> map) {
//     print('onTapMarkerFunction: $map');
//   }
  
// Future<void> processData() async {
//   try {
//     geoJsonModel = await geoJsonService.parseGeoJson(AppString.maplocation);
//     setState(() {
//       loadingData = false; // Ensure UI updates once data is loaded
//     });
//     print("Number of polygons: ${geoJsonModel.features.length}");

//   } catch (e) {
//     print('Error loading GeoJson: $e');
//   }
// }



// //   Future<void> processData() async {
// //     try {
//       //  geoJsonParser.parseGeoJsonAsString(
//       //   await DefaultAssetBundle.of(context).loadString('assets/lecture_theater.geojson'),
//       // );
// //           geoJsonModel= await geoJsonService.parseGeoJson(AppString.maplocation);
// // geoJsonParser.filterFunction;
// //     } catch (e) {
// //       print('Error loading GeoJson: $e');
// //     }
// //   }

//   @override
//   void initState() {
//     super.initState();
//     geoJsonParser.setDefaultMarkerTapCallback(onTapMarkerFunction);
//     geoJsonParser.filterFunction = myFilterFunction;

//     loadingData = true;
//     Stopwatch stopwatch = Stopwatch()..start();
//     // geoJsonModel= await geoJsonService.parseGeoJson(AppString.maplocation);
//     processData();
// setState(() {
  
// });
//     // Future.microtask(() async {
//     //   await processData();
//     //   setState(() {
//     //     loadingData = false;
//     //   });

//       Future.delayed(Duration.zero, () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('GeoJson Processing time: ${stopwatch.elapsed}'),
//             duration: const Duration(seconds: 5),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.green,
//           ),
//         );
//       });
//     }
//     int currentFloor=0 ;
  

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: Stack(

//         children: [


//           FlutterMap(
//           options: MapOptions(
//             initialCenter: LatLng(31.6340, 74.8259), // San Francisco coordinates
//             initialZoom: 20,
//           ),
//           children: [
//             TileLayer(
//           // urlTemplate: 'https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',
//           urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
//               userAgentPackageName: 'com.example.app',
//             ),
//             if (loadingData)
//               const Center(child: CircularProgressIndicator())
//             else ...[
//             Consumer<LocationController>(
//   builder: (context, value, child) {
//     List<Feature> allFeatures = geoJsonModel.features;
//     List<Feature> filteredFeatures = [];

//     if (value.currentLocation != null) {
//       double currentAltitude = value.currentLocation!.altitude ?? 0;
//       double baseAltitude = value.currentBase;
//       int newFloor = ((currentAltitude - baseAltitude) / 4).floor() + 1;

//       // Only update `currentFloor` if it changes, and do it outside the build phase
//       if (currentFloor != newFloor) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           setState(() {
//             currentFloor = newFloor;
//           });
//         });
//       }

//       filteredFeatures = GeoJsonService().filterFeatures(
//         allFeatures,
//         PropertyKey.floor,
//         newFloor,
//       );
//     }

//     return PolygonLayer(
//       polygons: filteredFeatures.map((data) {
//         List<LatLng> coordinates = data.geometry.toLatLngList();
//         return Polygon(
//           points: coordinates,
//           borderColor: Colors.red,
//           borderStrokeWidth: 2,
//           color: Colors.blue,
//         );
//       }).toList(),
//     );
//   },
// ),


//               PolylineLayer(polylines: geoJsonParser.polylines),
//               MarkerLayer(markers: geoJsonParser.markers),
//               CircleLayer(circles: geoJsonParser.circles),
            
        
//             ],
//           ],
//         ),
//       Text(currentFloor.toString(),style: TextStyle(fontSize: 40),)
        
        
//         ]
//       ),
//     );
//   }

// }






// // import 'package:flutter/material.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:latlong2/latlong.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:pinpoint/model/location/geoJsonModel.dart';
// // import 'package:pinpoint/repository/location_services/geoJsonService.dart';
// // import 'package:pinpoint/resources/constant/string/appString.dart';
// // // import 'package:turf/turf.dart' as turf;


// // class MapScreen extends StatefulWidget {
// //   const MapScreen({super.key});

// //   @override
// //   State<MapScreen> createState() => _MapScreenState();
// // }

// // class _MapScreenState extends State<MapScreen> {
// //   List<Feature> features=[];
// //   final GeoJsonService geoJsonService = GeoJsonService();
// //   // List<Map<String, dynamic>> filteredData = [];
// //   bool loading = true;
// //   LatLng? userLocation;
// //   String statusMessage = "Fetching location...";

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadData();
// //     _getUserLocation();
// //   }
  

// //   Future<void> loadData() async {
// //     try {
// //       // Parse and filter GeoJSON data
// //       GeoJsonModel geoJson = await geoJsonService.parseGeoJson(AppString.maplocation);
// //       // List<Feature> filteredFeatures = geoJsonService.filterFeatures(geoJson.features, 'floor', 1);

// //       // List<Feature>  features = geoJson.features.where((feature) {
// //       //   return feature.properties.floor == 1; // Filter by floor number
// //       // }).toList();
// //       List<Feature> feature= geoJson.features;
// //       // filteredData = geoJsonService.extractData(filteredFeatures);

// //       setState(() => loading = false);
// //     } catch (e) {
// //       print('Error loading GeoJSON: $e');
// //     }
// //   }

// //   Future<void> _getUserLocation() async {
// //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       setState(() => statusMessage = "Location services are disabled.");
// //       return;
// //     }

// //     LocationPermission permission = await Geolocator.requestPermission();
// //     if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
// //       setState(() => statusMessage = "Location permission denied.");
// //       return;
// //     }

// //     Position position = await Geolocator.getCurrentPosition(
// //       desiredAccuracy: LocationAccuracy.high,
// //     );

// //   //   setState(() {
// //   //     userLocation = LatLng(position.latitude, position.longitude);
// //   //     _checkIfInsideFeature();
// //   //   });
// //   // }

// //   // void _checkIfInsideFeature() {
// //   //   if (userLocation == null || filteredData.isEmpty) return;

// //   //   bool isInside = false;

// //   //   for (var data in filteredData) {
// //   //     List<LatLng> coordinates = _convertToLatLng(data['coordinates']);
// //   //     List<List<double>> polyCoords = coordinates.map((e) => [e.longitude, e.latitude]).toList();

// //   //     // Create a Turf polygon and point
// //   //     final polygon = turf.Polygon([polyCoords]);
// //   //     final point = turf.Point([userLocation!.longitude, userLocation!.latitude]);

// //   //     if (turf.booleanPointInPolygon(point, polygon)) {
// //   //       isInside = true;
// //   //       statusMessage = "Inside ${data['name']} (Floor: ${data['floor']})";
// //   //       break;
// //   //     }
// //   //   }

// //   //   if (!isInside) {
// //   //     statusMessage = "Outside any feature.";
// //   //   }

// //   //   setState(() {});
// //   // }

// //   }
// //   List<PolygonLayer> _buildPolygons() {
// //     return [
// //       PolygonLayer(
// //         polygons: features.map((data) {
// //           List<LatLng> coordinates =data.geometry.toLatLngList();
// //           return Polygon(
// //             points: coordinates,
// //             borderColor: Colors.blue,
// //             borderStrokeWidth: 2,
// //             color: Colors.blue.withOpacity(0.3),
// //           );
// //         }).toList(),
// //       ),
// //     ];
// //   }

// //   List<MarkerLayer> _buildUserMarker() {
// //     return [
// //       MarkerLayer(
// //         markers: [
// //           Marker(
// //             point: userLocation!,
// //             width: 80,
// //             height: 80,
// //             child: const Icon(Icons.my_location, color: Colors.red, size: 40),
// //           ),
// //         ],
// //       ),
// //     ];
// //   }

  
// //   @override
// //   Widget build(BuildContext context) {
// //    return Scaffold(
// //       body: loading
// //           ? const Center(child: CircularProgressIndicator())
// //           : Stack(
// //               children: [
// //                 FlutterMap(
// //                   options: MapOptions(
// //                     initialCenter: userLocation ?? const LatLng(31.6340, 74.8259),
// //                     initialZoom: 20,
// //                   ),
// //                   children: [
// //                     TileLayer(
// //                       urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
// //                       userAgentPackageName: 'com.example.app',
// //                     ),
// //                     ..._buildPolygons(),
// //                     if (userLocation != null) ..._buildUserMarker(),
// //                   ],
// //                 ),
// //                 Positioned(
// //                   bottom: 20,
// //                   left: 20,
// //                   child: Container(
// //                     padding: const EdgeInsets.all(12),
// //                     color: Colors.white,
// //                     child: Text(statusMessage),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //     );
// //   }
// // }
