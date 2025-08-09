
// --- Create/Edit Timetable Screen (Full Implementation) ---
import 'package:flutter/material.dart';
import 'package:pinpoint/model/timetable/day_schedule.dart';
import 'package:pinpoint/model/timetable/period.dart';
import 'package:pinpoint/model/timetable/timetable_detail.dart';
import 'package:uuid/uuid.dart';

class CreateOrEditTimetableScreen extends StatefulWidget {
  final TimetableDetail? existingTimetable;
  const CreateOrEditTimetableScreen({super.key, this.existingTimetable});

  @override
  State<CreateOrEditTimetableScreen> createState() => _CreateOrEditTimetableScreenState();
}

class _CreateOrEditTimetableScreenState extends State<CreateOrEditTimetableScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _timetableNameController;
  late List<DaySchedule> _schedules;

  @override
  void initState() {
    super.initState();
    if (widget.existingTimetable != null) {
      // Editing an existing timetable
      _timetableNameController = TextEditingController(text: widget.existingTimetable!.name);
      _schedules = List.from(widget.existingTimetable!.schedules);
    } else {
      // Creating a new timetable
      _timetableNameController = TextEditingController();
      _schedules = [
        DaySchedule(id: 'day-mon', day: 'Monday', periods: []),
        DaySchedule(id: 'day-tue', day: 'Tuesday', periods: []),
        DaySchedule(id: 'day-wed', day: 'Wednesday', periods: []),
        DaySchedule(id: 'day-thu', day: 'Thursday', periods: []),
        DaySchedule(id: 'day-fri', day: 'Friday', periods: []),
        DaySchedule(id: 'day-sat', day: 'Saturday', periods: []),
      ];
    }
  }

  void _saveTimetable() {
    if (_formKey.currentState!.validate()) {
      final newTimetable = TimetableDetail(
        id: widget.existingTimetable?.id ?? const Uuid().v4(),
        name: _timetableNameController.text,
        schedules: _schedules,
      );
      // Return the new/updated timetable to the previous screen
      Navigator.of(context).pop(newTimetable);
    }
  }

  void _addOrEditPeriod(DaySchedule daySchedule, {Period? existingPeriod}) async {
    // Show a dialog to get period details
    final result = await showDialog<Period>(
      context: context,
      builder: (_) => _AddEditPeriodDialog(dayScheduleId: daySchedule.id, period: existingPeriod),
    );

    if (result != null) {
      setState(() {
        final dayIndex = _schedules.indexWhere((s) => s.id == daySchedule.id);
        if (existingPeriod != null) {
          // Editing existing period
          final periodIndex = _schedules[dayIndex].periods.indexWhere((p) => p.id == existingPeriod.id);
          _schedules[dayIndex].periods[periodIndex] = result;
        } else {
          // Adding new period
          _schedules[dayIndex].periods.add(result);
        }
        // Sort periods by start time for consistency
        _schedules[dayIndex].periods.sort((a, b) => a.startTime.compareTo(b.startTime));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingTimetable == null ? 'Create Timetable' : 'Edit Timetable'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _timetableNameController,
              decoration: const InputDecoration(
                labelText: 'Timetable Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description_outlined),
              ),
              validator: (value) => (value == null || value.isEmpty) ? 'Please enter a name' : null,
            ),
            const SizedBox(height: 24),
            ..._schedules.map((day) => _buildDayCard(day)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveTimetable,
        label: const Text('Save Timetable'),
        icon: const Icon(Icons.save_outlined),
      ),
    );
  }

  Widget _buildDayCard(DaySchedule daySchedule) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(daySchedule.day, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                  onPressed: () => _addOrEditPeriod(daySchedule),
                )
              ],
            ),
            const Divider(),
            if (daySchedule.periods.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: Text('No periods added.')),
              )
            else
              ...daySchedule.periods.map((p) => ListTile(
                title: Text(p.subject),
                subtitle: Text('${p.startTime} - ${p.endTime} in ${p.roomName}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: () => _addOrEditPeriod(daySchedule, existingPeriod: p),
                ),
              )),
          ],
        ),
      ),
    );
  }
}

// --- Dialog for Adding/Editing a Period ---
class _AddEditPeriodDialog extends StatefulWidget {
  final String dayScheduleId;
  final Period? period;

  const _AddEditPeriodDialog({required this.dayScheduleId, this.period});

  @override
  State<_AddEditPeriodDialog> createState() => _AddEditPeriodDialogState();
}

class _AddEditPeriodDialogState extends State<_AddEditPeriodDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _subjectController;
  late TextEditingController _teacherController;
  late TextEditingController _roomController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;

  @override
  void initState() {
    super.initState();
    final p = widget.period;
    _subjectController = TextEditingController(text: p?.subject);
    _teacherController = TextEditingController(text: p?.teacher);
    _roomController = TextEditingController(text: p?.roomName);
    _startTimeController = TextEditingController(text: p?.startTime);
    _endTimeController = TextEditingController(text: p?.endTime);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _teacherController.dispose();
    _roomController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newPeriod = Period(
        id: widget.period?.id ?? const Uuid().v4(),
        name: 'Period', // Or derive from form
        subject: _subjectController.text,
        teacher: _teacherController.text,
        roomName: _roomController.text,
        startTime: _startTimeController.text,
        endTime: _endTimeController.text,
        scheduleDayId: widget.dayScheduleId,
        subjectId: 'sub-id-placeholder', // TODO: Get from a selection screen
        roomId: 'room-id-placeholder', // TODO: Get from a selection screen
      );
      Navigator.of(context).pop(newPeriod);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.period == null ? 'Add Period' : 'Edit Period'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(controller: _subjectController, decoration: const InputDecoration(labelText: 'Subject'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _teacherController, decoration: const InputDecoration(labelText: 'Teacher'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _roomController, decoration: const InputDecoration(labelText: 'Room'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _startTimeController, decoration: const InputDecoration(labelText: 'Start Time (e.g., 09:00 AM)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _endTimeController, decoration: const InputDecoration(labelText: 'End Time (e.g., 10:00 AM)'), validator: (v) => v!.isEmpty ? 'Required' : null),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
