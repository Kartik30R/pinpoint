import 'package:flutter/material.dart';
import 'package:pinpoint/model/building/building_dto.dart';
import 'package:pinpoint/model/building/floor_dto.dart';
import 'package:pinpoint/model/building/room_dto.dart';
import 'package:pinpoint/view/users/institute/temp_map.dart/map_view_screen.dart';

class BuildingDetailScreen extends StatelessWidget {
  final BuildingDto building;

  const BuildingDetailScreen({super.key, required this.building});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final floors = building.floors ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(building.name ?? 'Building Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Main action button to view the entire building on the map
          ElevatedButton.icon(
            icon: const Icon(Icons.map_outlined),
            label: const Text('View Full Building on Map'),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (_) => MapViewerScreen(
              //     building: building,
              //     title: building.name ?? 'Building Map',
              //   ),
              // ));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              textStyle: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 24),

          // List of floors
          Text('Floors', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const Divider(),
          if (floors.isEmpty)
            const Center(child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No floors found for this building.'),
            ))
          else
            ...floors.map((floor) => _buildFloorExpansionTile(context, floor)),
        ],
      ),
    );
  }

  Widget _buildFloorExpansionTile(BuildContext context, FloorDto floor) {
    final rooms = floor.rooms ?? [];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTile(
        leading: CircleAvatar(child: Text('${floor.level}')),
        title: Text('Floor ${floor.level}', style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${rooms.length} rooms'),
        children: rooms.map((room) => _buildRoomTile(context, room)).toList(),
      ),
    );
  }

  Widget _buildRoomTile(BuildContext context, RoomDto room) {
    return ListTile(
      title: Text(room.name),
      subtitle: Text('Type: ${room.type}'),
      trailing: IconButton(
        icon: const Icon(Icons.location_on_outlined, color: Colors.blueAccent),
        tooltip: 'View Room on Map',
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (_) => MapViewerScreen(
          //     building: building,
          //     highlightedRoom: room, // Pass the specific room to highlight
          //     title: room.name,
          //   ),
          // ));
        },
      ),
    );
  }
}
