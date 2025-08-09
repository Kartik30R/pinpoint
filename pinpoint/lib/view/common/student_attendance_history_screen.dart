import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// --- Mock Model (for demonstration) ---
enum AttendanceStatus { present, absent, late }

class PeriodAttendance {
  final String subject;
  final String time;
  final AttendanceStatus status;

  const PeriodAttendance(
      {required this.subject, required this.time, required this.status});
}

class AttendanceRecord {
  final DateTime date;
  final AttendanceStatus overallStatus; // Overall status for the day
  final List<PeriodAttendance> periods;

  const AttendanceRecord(
      {required this.date,
      required this.overallStatus,
      this.periods = const []});
}
// ---

/// A screen for students to view their attendance history in a calendar format.
class StudentAttendanceHistoryScreen extends StatefulWidget {
  const StudentAttendanceHistoryScreen({super.key});

  @override
  State<StudentAttendanceHistoryScreen> createState() =>
      _StudentAttendanceHistoryScreenState();
}

class _StudentAttendanceHistoryScreenState
    extends State<StudentAttendanceHistoryScreen> {
  // --- Mock Data ---
  // In a real app, this would be fetched from an API based on the selected month.
  final List<AttendanceRecord> _attendanceRecords = [
    AttendanceRecord(
        date: DateTime.utc(2025, 8, 1),
        overallStatus: AttendanceStatus.present,
        periods: [
          const PeriodAttendance(
              subject: 'Data Structures',
              time: '10:00 - 11:00 AM',
              status: AttendanceStatus.present),
          const PeriodAttendance(
              subject: 'Algorithms',
              time: '11:00 - 12:00 PM',
              status: AttendanceStatus.present),
        ]),
    AttendanceRecord(
        date: DateTime.utc(2025, 8, 3),
        overallStatus: AttendanceStatus.absent,
        periods: [
          const PeriodAttendance(
              subject: 'Operating Systems',
              time: '09:00 - 10:00 AM',
              status: AttendanceStatus.absent),
        ]),
    AttendanceRecord(
        date: DateTime.utc(2025, 8, 6),
        overallStatus: AttendanceStatus.late,
        periods: [
          const PeriodAttendance(
              subject: 'Data Structures',
              time: '10:00 - 11:00 AM',
              status: AttendanceStatus.late),
        ]),
  ];
  // ---

  late DateTime _focusedDay;
  late DateTime _selectedDay;
  List<PeriodAttendance> _selectedDayPeriods = [];

  @override
  void initState() {
    super.initState();
    // FIX: Initialize the calendar to the first available record date.
    // This prevents errors by ensuring the screen loads with valid data
    // instead of starting on the current date, which might have no records.
    _focusedDay = _attendanceRecords.isNotEmpty
        ? _attendanceRecords.first.date
        : DateTime.now();
    _selectedDay = _focusedDay;
    _updateSelectedDayPeriods(_selectedDay);
  }

  void _updateSelectedDayPeriods(DateTime day) {
    final records = _getRecordsForDay(day);
    setState(() {
      _selectedDayPeriods = records.isNotEmpty ? records.first.periods : [];
    });
  }

  List<AttendanceRecord> _getRecordsForDay(DateTime day) {
    return _attendanceRecords
        .where((record) => isSameDay(record.date, day))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCalendar(),
          const SizedBox(height: 24),
          _buildDailyDetails(),
          const SizedBox(height: 24),
          _buildSummary(),
          const SizedBox(height: 16),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2026, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _updateSelectedDayPeriods(selectedDay);
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
          // TODO: Fetch attendance records for the new month
        },
        eventLoader: _getRecordsForDay,
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            if (events.isNotEmpty) {
              final record = events.first as AttendanceRecord;
              return Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _getStatusColor(record.overallStatus).withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              );
            }
            return null;
          },
        ),
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
      ),
    );
  }

  Widget _buildDailyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details for ${_selectedDay.month}/${_selectedDay.day}/${_selectedDay.year}',
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (_selectedDayPeriods.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('No classes on this day.')),
            ),
          )
        else
          ..._selectedDayPeriods.map((period) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(period.subject),
                  subtitle: Text(period.time),
                  trailing: Chip(
                    label: Text(period.status.name),
                    backgroundColor: _getStatusColor(period.status),
                    labelStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
      ],
    );
  }

  Widget _buildSummary() {
    final presentCount = _attendanceRecords
        .where((r) => r.overallStatus == AttendanceStatus.present)
        .length;
    final absentCount = _attendanceRecords
        .where((r) => r.overallStatus == AttendanceStatus.absent)
        .length;
    final lateCount = _attendanceRecords
        .where((r) => r.overallStatus == AttendanceStatus.late)
        .length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSummaryItem('Present', presentCount.toString(), Colors.green),
        _buildSummaryItem('Absent', absentCount.toString(), Colors.red),
        _buildSummaryItem('Late', lateCount.toString(), Colors.orange),
      ],
    );
  }

  Widget _buildSummaryItem(String title, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
        Text(title),
      ],
    );
  }

  Widget _buildLegend() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _LegendItem(color: Colors.green, label: 'Present'),
        _LegendItem(color: Colors.red, label: 'Absent'),
        _LegendItem(color: Colors.orange, label: 'Late'),
      ],
    );
  }

  Color _getStatusColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return Colors.green;
      case AttendanceStatus.absent:
        return Colors.red;
      case AttendanceStatus.late:
        return Colors.orange;
    }
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
              color: color.withOpacity(0.3), shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
