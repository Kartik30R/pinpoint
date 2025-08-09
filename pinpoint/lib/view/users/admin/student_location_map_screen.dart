import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

// --- Mock Models (for demonstration) ---
// In a real app, you would import these from your model files.
class StudentLocationData {
  final String id;
  final String name;
  final LatLng location;
  final int floorLevel;

  const StudentLocationData({
    required this.id,
    required this.name,
    required this.location,
    required this.floorLevel,
  });
}

class TimeRange {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  const TimeRange({required this.startTime, required this.endTime});
}
// ---

enum ViewMode { live, history }

/// A full-screen map to display a single student's live location or history.
class StudentLocationMapScreen extends StatefulWidget {
  final String studentId;
  final String studentName;

  const StudentLocationMapScreen({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  State<StudentLocationMapScreen> createState() => _StudentLocationMapScreenState();
}

class _StudentLocationMapScreenState extends State<StudentLocationMapScreen> {
  ViewMode _viewMode = ViewMode.live;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);

  // --- Mock Data for a single student ---
  // In a real app, this data would be fetched based on widget.studentId
  final StudentLocationData _liveStudent = const StudentLocationData(
      id: 'user-01',
      name: 'Alice Johnson',
      location: LatLng(31.6340, 74.8723),
      floorLevel: 2);
  final List<LatLng> _historyPath = const [
    LatLng(31.6340, 74.8723),
    LatLng(31.6341, 74.8724),
    LatLng(31.6343, 74.8722)
  ];
  // ---

  Future<void> _selectTime(BuildContext context, {bool isStartTime = true}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
      // TODO: Fetch new history data based on the updated time range
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentName),
      ),
      body: Stack(
        children: [
          // The Map
          FlutterMap(
            options: MapOptions(
              initialCenter: _viewMode == ViewMode.live
                  ? _liveStudent.location
                  : _historyPath.first,
              initialZoom: 19.0,
            ),
            children: [
              TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),
              if (_viewMode == ViewMode.live)
                MarkerLayer(markers: [_buildLiveMarker(_liveStudent)]),
              if (_viewMode == ViewMode.history)
                PolylineLayer(polylines: [_buildHistoryPolyline(_historyPath)]),
            ],
          ),

          // Top Controls
          _buildTopControls(),

          // Bottom Floor Indicator
          _buildFloorIndicator(),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Column(
        children: [
          SegmentedButton<ViewMode>(
            segments: const <ButtonSegment<ViewMode>>[
              ButtonSegment<ViewMode>(
                  value: ViewMode.live, label: Text('Live'), icon: Icon(Icons.sensors)),
              ButtonSegment<ViewMode>(
                  value: ViewMode.history,
                  label: Text('History'),
                  icon: Icon(Icons.history)),
            ],
            selected: {_viewMode},
            onSelectionChanged: (newSelection) =>
                setState(() => _viewMode = newSelection.first),
          ),
          if (_viewMode == ViewMode.history)
            Card(
              margin: const EdgeInsets.only(top: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async {
                          final picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2020), lastDate: DateTime.now());
                          if(picked != null) setState(() => _selectedDate = picked);
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(DateFormat.yMMMd().format(_selectedDate)),
                        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                              onPressed: () => _selectTime(context, isStartTime: true),
                              icon: const Icon(Icons.access_time),
                              label: Text('Start: ${_startTime.format(context)}')),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                              onPressed: () => _selectTime(context, isStartTime: false),
                              icon: const Icon(Icons.access_time_filled),
                              label: Text('End: ${_endTime.format(context)}')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFloorIndicator() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Floor: ${_liveStudent.floorLevel}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Marker _buildLiveMarker(StudentLocationData student) {
    return Marker(
      width: 45.0,
      height: 45.0,
      point: student.location,
      child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 45.0),
    );
  }

  Polyline _buildHistoryPolyline(List<LatLng> path) {
    return Polyline(
      points: path,
      strokeWidth: 5.0,
      color: Colors.deepPurple,
    );
  }
}
