
 import 'package:flutter/material.dart';
 import 'package:intl/intl.dart';


class Batch {
  final String id;
  final String name;
  const Batch({required this.id, required this.name});
}

class StudentAttendance {
  final String studentId;
  final String studentName;
  final String status; // 'Present', 'Absent', 'Late'

  const StudentAttendance({
    required this.studentId,
    required this.studentName,
    required this.status,
  });
}
// ---

/// A screen for admins to view attendance records by batch and date.
class ViewAttendanceScreen extends StatefulWidget {
  const ViewAttendanceScreen({super.key});

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  // --- Mock Data ---
  final List<Batch> _batches = [
    const Batch(id: 'batch-A', name: 'Batch A - Morning'),
    const Batch(id: 'batch-B', name: 'Batch B - Afternoon'),
  ];

  final Map<String, List<StudentAttendance>> _attendanceRecords = {
    'batch-A': const [
      StudentAttendance(studentId: 'user-01', studentName: 'Alice Johnson', status: 'Present'),
      StudentAttendance(studentId: 'user-02', studentName: 'Bob Williams', status: 'Present'),
      StudentAttendance(studentId: 'user-04', studentName: 'Diana Prince', status: 'Late'),
      StudentAttendance(studentId: 'user-05', studentName: 'Ethan Hunt', status: 'Absent'),
    ],
    'batch-B': const [
      StudentAttendance(studentId: 'user-11', studentName: 'Frank Miller', status: 'Present'),
      StudentAttendance(studentId: 'user-12', studentName: 'Grace Lee', status: 'Present'),
    ],
  };
  // ---

  Batch? _selectedBatch;
  DateTime _selectedDate = DateTime.now();
  List<StudentAttendance> _currentRecords = [];

  @override
  void initState() {
    super.initState();
    // Initialize with the first batch if available
    if (_batches.isNotEmpty) {
      _selectedBatch = _batches.first;
      _fetchAttendanceRecords();
    }
  }

  void _fetchAttendanceRecords() {
    // In a real app, this would be an API call:
    // API.getAttendance(batchId: _selectedBatch!.id, date: _selectedDate);
    setState(() {
      _currentRecords = _attendanceRecords[_selectedBatch?.id] ?? [];
    });
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
      _fetchAttendanceRecords();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Attendance'),
      ),
      body: Column(
        children: [
          _buildFilterControls(),
          const Divider(height: 1),
          Expanded(
            child: _buildAttendanceList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Batch Selector
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<Batch>(
              value: _selectedBatch,
              items: _batches.map((batch) {
                return DropdownMenuItem<Batch>(
                  value: batch,
                  child: Text(batch.name),
                );
              }).toList(),
              onChanged: (Batch? newValue) {
                setState(() {
                  _selectedBatch = newValue;
                });
                _fetchAttendanceRecords();
              },
              decoration: const InputDecoration(
                labelText: 'Select Batch',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Date Selector
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
Text(DateFormat.yMMMd().format(_selectedDate)),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceList() {
    if (_currentRecords.isEmpty) {
      return const Center(child: Text('No attendance records found for this selection.'));
    }
    return ListView.separated(
      itemCount: _currentRecords.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final record = _currentRecords[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: _getStatusColor(record.status).withOpacity(0.2),
            child: Text(record.studentName.substring(0, 1)),
          ),
          title: Text(record.studentName),
          trailing: Chip(
            label: Text(record.status),
            backgroundColor: _getStatusColor(record.status),
            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
