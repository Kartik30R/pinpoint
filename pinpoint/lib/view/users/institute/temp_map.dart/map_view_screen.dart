// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:pinpoint/model/building/building_dto.dart';
// import 'package:pinpoint/model/building/room_dto.dart';

// class MapViewerScreen extends StatelessWidget {
//   final BuildingDto building;
//   final String title;
//   /// If provided, only this room will be highlighted on the map.
//   /// If null, the entire building is shown.
//   final RoomDto? highlightedRoom;

//   const MapViewerScreen({
//     super.key,
//     required this.building,
//     required this.title,
//     this.highlightedRoom,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final List<Polygon> polygons = [];
//     final List<LatLng> allPoints = [];

//     // Determine which rooms to display
//     final roomsToShow = highlightedRoom != null
//         ? [highlightedRoom!]
//         : building.floors?.expand((floor) => floor.rooms ?? []).toList() ?? [];

//     // Convert room geometries to map polygons
//     for (var room in roomsToShow) {
//       // A GeoJSON Polygon is a list of rings. The first ring is the exterior boundary.
//       // We'll take the first ring to create the flutter_map Polygon.
//       final points = room.geometry.isNotEmpty
//           ? room.geometry[0].map((coord) => LatLng(coord[1], coord[0])).toList()
//           : <LatLng>[];
          
//       if (points.isNotEmpty) {
//         allPoints.addAll(points);

//         polygons.add(Polygon(
//           points: points,
//           color: Colors.blue.withOpacity(0.5),
//           borderColor: Colors.blue,
//           borderStrokeWidth: 2,
//         ));
//       }
//     }

//     // Calculate the center of the map
//     // The explicit cast to <LatLng> fixes the type error.
//     final LatLng center = allPoints.isNotEmpty
//         ? LatLngBounds.fromPoints(allPoints.cast<LatLng>()).center
//         : const LatLng(51.5, -0.09); // Default center

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           initialCenter: center,
//           initialZoom: 18.0,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: const ['a', 'b', 'c'],
//           ),
//           PolygonLayer(
//             polygons: polygons,
//           ),
//         ],
//       ),
//     );
//   }
// }
