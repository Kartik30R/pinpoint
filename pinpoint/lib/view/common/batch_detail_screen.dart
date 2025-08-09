import 'package:flutter/material.dart';
// Import your actual models and other screens
import 'package:pinpoint/model/batch/batch_detail_response.dart';
import 'package:pinpoint/model/timetable/timetable_detail.dart';
import 'package:pinpoint/view/common/time_table_detail_screen.dart';
import 'package:pinpoint/view/users/institute/create_edit_timetable_screen.dart';
import 'package:pinpoint/view/users/institute/user_list_screen.dart';
import 'admin_list_screen.dart';

class BatchDetailScreen extends StatefulWidget {
  final String batchId;

  const BatchDetailScreen({super.key, required this.batchId});

  @override
  State<BatchDetailScreen> createState() => _BatchDetailScreenState();
}

class _BatchDetailScreenState extends State<BatchDetailScreen> {

  bool _hasTimetable = false;

  // --- Mock Data ---
  // In a real app, you would fetch this data in initState using a provider
  late Future<BatchDetailResponse> _batchDetailsFuture;
  
  // This would be fetched based on the timetableId from the batch details
  TimetableDetail? _timetableDetail;

  @override
  void initState() {
    super.initState();
    // Start the mock data fetching
    _batchDetailsFuture = _fetchBatchDetails();
  }

  Future<BatchDetailResponse> _fetchBatchDetails() async {
  await Future.delayed(const Duration(milliseconds: 800));

  final batchDetails = BatchDetailResponse(
    id: widget.batchId,
    name: 'Computer Science 2024',
    code: 'CS-2024',
    students: [
      BatchUser(id: 'user-1', name: 'Alice Johnson', phone: '555-0101'),
      BatchUser(id: 'user-2', name: 'Bob Williams', phone: '555-0102'),
    ],
    admins: [
      BatchAdmin(id: 'admin-1', name: 'Dr. Evelyn Reed'),
    ],
    timetableId: _hasTimetable ? 'timetable-id-001' : null,
  );

  if (_hasTimetable) {
    _timetableDetail = TimetableDetail.getMockData();
  }

  return batchDetails;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batch Details sdfghjklkjhgfdfghjkl'),
      ),
      body: FutureBuilder<BatchDetailResponse>(
        future: _batchDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Batch not found.'));
          }

          final batch = snapshot.data!;
          return _buildContent(context, batch);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, BatchDetailResponse batch) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //!
           SwitchListTile(
          title: const Text('Has Timetable? (Dev Toggle)'),
          value: _hasTimetable,
          onChanged: (value) {
            setState(() {
              _hasTimetable = value;
              _timetableDetail = null;
              _batchDetailsFuture = _fetchBatchDetails();
            });
          },
        ),


          Text(
            batch.name,
            style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Chip(
            label: Text('Code: ${batch.code}'),
            avatar: const Icon(Icons.code_rounded),
          ),
          const SizedBox(height: 24),
          _buildActionButton(
            context,
            icon: Icons.people_outline,
            title: 'View Students (${batch.students.length})',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => StudentListScreen(),
              ));
            },
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            context,
            icon: Icons.admin_panel_settings_outlined,
            title: 'View Admins (${batch.admins.length})',
            onTap: () {
               Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AdminListScreen(),
              ));
            },
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            context,
            icon: Icons.calendar_today_outlined,
            title: batch.timetableId != null ? 'View Timetable' : 'Add Timetable',
            onTap: () async {
              if (_timetableDetail != null) {
                // View existing timetable
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => TimetableDetailScreen(timetable: _timetableDetail!),
                ));
              } else {
                // Add a new timetable
                final newTimetable = await Navigator.of(context).push<TimetableDetail>(
                  MaterialPageRoute(builder: (_) =>  CreateOrEditTimetableScreen()),
                );
                if (newTimetable != null) {
                  // If a timetable was created, refresh the state to show it
                  setState(() {
                    _timetableDetail = newTimetable;
                    // In a real app, you'd also update the batch's timetableId
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}

