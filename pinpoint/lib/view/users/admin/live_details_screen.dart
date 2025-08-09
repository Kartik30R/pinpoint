import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

// Note: To use this screen, you need to add the following dependencies
// to your pubspec.yaml file:
// dependencies:
//   flutter_map: ^6.1.0
//   latlong2: ^0.9.0
//   intl: ^0.19.0

// --- Mock Models (for demonstration) ---
class StudentStatus {
  final String id;
  final String name;
  final LatLng location;
  final String status; // 'Present', 'Absent', 'Late'

  const StudentStatus({
    required this.id,
    required this.name,
    required this.location,
    required this.status,
  });
}

/// A simple class to hold a start and end time.
class TimeRange {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const TimeRange({required this.startTime, required this.endTime});
}
// ---

enum ViewMode { live, history }

class LiveDetailsScreen extends StatefulWidget {
  final String batchId;
  final String classTitle;

  const LiveDetailsScreen({
    super.key,
    required this.batchId,
    required this.classTitle,
  });

  @override
  State<LiveDetailsScreen> createState() => _LiveDetailsScreenState();
}

class _LiveDetailsScreenState extends State<LiveDetailsScreen> {
  ViewMode _viewMode = ViewMode.live;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);
  String? _selectedStudentId; // To track the selected student

  // --- Mock Data ---
  final List<StudentStatus> _liveStudents = [
    const StudentStatus(id: 'user-01', name: 'Alice Johnson', location: LatLng(31.6340, 74.8723), status: 'Present'),
    const StudentStatus(id: 'user-02', name: 'Bob Williams', location: LatLng(31.6342, 74.8725), status: 'Present'),
    const StudentStatus(id: 'user-03', name: 'Charlie Brown', location: LatLng(31.6338, 74.8720), status: 'Present'),
    const StudentStatus(id: 'user-04', name: 'Diana Prince', location: LatLng(31.6345, 74.8718), status: 'Late'),
    const StudentStatus(id: 'user-05', name: 'Ethan Hunt', location: LatLng(0, 0), status: 'Absent'),
  ];

  final Map<String, List<LatLng>> _historyPaths = {
    'user-01': const [LatLng(31.6340, 74.8723), LatLng(31.6341, 74.8724), LatLng(31.6343, 74.8722)],
    'user-02': const [LatLng(31.6342, 74.8725), LatLng(31.6340, 74.8726), LatLng(31.6339, 74.8724)],
    'user-03': const [LatLng(31.6338, 74.8720), LatLng(31.6339, 74.8721), LatLng(31.6337, 74.8723)],
  };
  // ---

  /// A custom function to show two time pickers sequentially for a start and end time.
  Future<TimeRange?> _showTimeRangePicker({
    required BuildContext context,
    required TimeOfDay start,
    required TimeOfDay end,
  }) async {
    final TimeOfDay? newStart = await showTimePicker(
      context: context,
      initialTime: start,
      helpText: 'Select Start Time',
    );

    if (newStart == null) return null; // User cancelled

    final TimeOfDay? newEnd = await showTimePicker(
      context: context,
      initialTime: end,
      helpText: 'Select End Time',
    );

    if (newEnd == null) return null; // User cancelled

    return TimeRange(startTime: newStart, endTime: newEnd);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      // TODO: Fetch history data for the new date
    }
  }

  Future<void> _selectTimeRange(BuildContext context) async {
    final TimeRange? picked = await _showTimeRangePicker(
      context: context,
      start: _startTime,
      end: _endTime,
    );
    if (picked != null) {
      setState(() {
        _startTime = picked.startTime;
        _endTime = picked.endTime;
      });
      // TODO: Fetch history data for the new time range
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classTitle),
        actions: [
          // Show a "Show All" button only when a student is selected
          if (_selectedStudentId != null)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _selectedStudentId = null;
                });
              },
              icon: const Icon(Icons.people_outline, color: Colors.white),
              label: const Text('Show All', style: TextStyle(color: Colors.white)),
            )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SegmentedButton<ViewMode>(
                  segments: const <ButtonSegment<ViewMode>>[
                    ButtonSegment<ViewMode>(value: ViewMode.live, label: Text('Live'), icon: Icon(Icons.sensors)),
                    ButtonSegment<ViewMode>(value: ViewMode.history, label: Text('History'), icon: Icon(Icons.history)),
                  ],
                  selected: {_viewMode},
                  onSelectionChanged: (Set<ViewMode> newSelection) {
                    setState(() {
                      _viewMode = newSelection.first;
                    });
                  },
                ),
                if (_viewMode == ViewMode.history) _buildHistoryControls(),
              ],
            ),
          ),
          // Map View
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: _buildMapView(),
          ),
          // Student List
          Expanded(
            child: _buildStudentList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryControls() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_today),
            label: Text(DateFormat.yMMMd().format(_selectedDate)),
          ),
          ElevatedButton.icon(
            onPressed: () => _selectTimeRange(context),
            icon: const Icon(Icons.access_time),
            label: Text('${_startTime.format(context)} - ${_endTime.format(context)}'),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    if (_viewMode == ViewMode.live) {
      // Filter for selected student if any, otherwise show all present students
      final studentsToShow = _selectedStudentId != null
          ? _liveStudents.where((s) => s.id == _selectedStudentId).toList()
          : _liveStudents.where((s) => s.status != 'Absent').toList();
      return _buildLiveMapView(studentsToShow);
    } else {
      // Filter for selected student's history if any, otherwise show all
      final historyToShow = _selectedStudentId != null
          ? Map.fromEntries(_historyPaths.entries.where((e) => e.key == _selectedStudentId))
          : _historyPaths;
      return _buildHistoryMapView(historyToShow);
    }
  }

  Widget _buildLiveMapView(List<StudentStatus> students) {
    final markers = students.map((student) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: student.location,
        child: Column(
          children: [
            Icon(
              Icons.person_pin_circle,
              color: student.status == 'Late' ? Colors.orange : Colors.blue,
              size: 40.0,
            ),
            Text(student.name.split(' ').first, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }).toList();

    return FlutterMap(
      options: MapOptions(
        initialCenter: students.isNotEmpty ? students.first.location : const LatLng(31.6339, 74.8723),
        initialZoom: 18.0,
      ),
      children: [
        TileLayer(urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),
        MarkerLayer(markers: markers),
      ],
    );
  }

  Widget _buildHistoryMapView(Map<String, List<LatLng>> historyData) {
    final polylines = historyData.entries.map((entry) {
      return Polyline(
        points: entry.value,
        strokeWidth: 4.0,
        color: Colors.primaries[entry.key.hashCode % Colors.primaries.length],
      );
    }).toList();

    return FlutterMap(
      options: MapOptions(
        initialCenter: historyData.isNotEmpty ? historyData.values.first.first : const LatLng(31.6339, 74.8723),
        initialZoom: 18.0,
      ),
      children: [
        TileLayer(urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),
        PolylineLayer(polylines: polylines),
      ],
    );
  }

  Widget _buildStudentList() {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: _liveStudents.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final student = _liveStudents[index];
        final isSelected = student.id == _selectedStudentId;
        return ListTile(
          onTap: () {
            setState(() {
              // Toggle selection: if already selected, deselect. Otherwise, select.
              if (isSelected) {
                _selectedStudentId = null;
              } else {
                _selectedStudentId = student.id;
              }
            });
          },
          selected: isSelected,
          selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          leading: CircleAvatar(
            backgroundColor: _getStatusColor(student.status).withOpacity(0.2),
            child: Text(student.name.substring(0, 1)),
          ),
          title: Text(student.name),
          trailing: _viewMode == ViewMode.live
              ? Chip(
                  label: Text(student.status),
                  backgroundColor: _getStatusColor(student.status),
                  labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )
              : null, // In history mode, you might show different info
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green.shade600;
      case 'Late':
        return Colors.orange.shade700;
      case 'Absent':
        return Colors.red.shade600;
      default:
        return Colors.grey;
    }
  }
}
