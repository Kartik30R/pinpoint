import 'package:flutter/material.dart';
import 'package:pinpoint/view/common/batch_list_screen.dart';
import 'package:pinpoint/view/common/notes_screen.dart';
import 'package:pinpoint/view/users/admin/live_details_screen.dart';
import 'package:pinpoint/view/users/admin/notice_screen.dart';
import 'package:pinpoint/view/users/admin/view_attendance_screen.dart';
// Assuming you have a profile screen to navigate to
// import 'package:pinpoint/profile/admin_profile_screen.dart'; 

class AdminScreen1 extends StatelessWidget {
  const AdminScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'View Profile',
            onPressed: () {
              // TODO: Navigate to the AdminProfileScreen
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(context, "Dr. Evelyn Reed"),
            const SizedBox(height: 24),
            _buildSectionHeader(context, "Live Classes"),
            const SizedBox(height: 16),
            _buildLiveClasses(context),
            const SizedBox(height: 32),
            _buildSectionHeader(context, "Quick Actions"),
            const SizedBox(height: 16),
            _buildQuickActions(context),
            const SizedBox(height: 32),
            _buildSectionHeader(context, "Today's Period Attendance"),
            const SizedBox(height: 16),
            _buildTodayAttendanceOverview(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, String adminName) {
    return Text(
      "Welcome back, $adminName!",
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildLiveClasses(BuildContext context) {
    // Mock data for multiple live classes
    final liveClasses = [
      {
        'subject': 'Data Structures',
        'batch': 'Batch A',
        'time': '10:00 AM - 11:00 AM',
        'present': 38,
        'total': 42,
      },
      {
        'subject': 'Physics II',
        'batch': 'Batch D',
        'time': '10:00 AM - 11:00 AM',
        'present': 28,
        'total': 30,
      },
    ];

    if (liveClasses.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(child: Text('No classes currently in session.')),
        ),
      );
    }

    return Column(
      children: liveClasses.map((classData) => _LiveClassCard(classData: classData)).toList(),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _QuickActionButton(icon: Icons.send_outlined, label: 'Send Notice', onTap: () {{Navigator.push(context, MaterialPageRoute(builder: (context) => SendNoticeScreen(),));}}),
        _QuickActionButton(icon: Icons.playlist_add_check_outlined, label: 'Manual Attendance', onTap: () {{Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAttendanceScreen(),));}}),
        _QuickActionButton(icon: Icons.groups_outlined, label: 'My Batches', onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => BatchListScreen(),));}),
        _QuickActionButton(icon: Icons.note_alt_outlined, label: 'My Notes', onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => NotesScreen(),));}),
      ],
    );
  }

  Widget _buildTodayAttendanceOverview(BuildContext context) {
    // Mock data for period-wise attendance
    final periodAttendance = [
      {'subject': 'Algorithms', 'batch': 'Batch A', 'time': '09:00 - 10:00 AM', 'percentage': 0.98},
      {'subject': 'Thermodynamics', 'batch': 'Batch D', 'time': '09:00 - 10:00 AM', 'percentage': 0.85},
      {'subject': 'Calculus', 'batch': 'Batch B', 'time': '11:00 - 12:00 PM', 'percentage': 1.0},
    ];

    return Column(
      children: periodAttendance.map((data) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            title: Text(data['subject'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${data['batch']}  •  ${data['time']}'),
            trailing: Text(
              '${((data['percentage'] as double) * 100).toInt()}%',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: (data['percentage'] as double) < 0.9 ? Colors.orange.shade800 : Colors.green.shade700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _LiveClassCard extends StatelessWidget {
  final Map<String, dynamic> classData;
  const _LiveClassCard({required this.classData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.colorScheme.primaryContainer,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${classData['subject']} - ${classData['batch']}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              classData['time'] as String,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8)),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.group_outlined),
                const SizedBox(width: 8),
                Text.rich(
                  TextSpan(
                    style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onPrimaryContainer),
                    children: [
                      TextSpan(text: '${classData['present']} / ${classData['total']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' Students Present'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.location_on_outlined),
                label: const Text('View Live Details'),
                onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => LiveDetailsScreen(batchId: "classData", classTitle: "classTitle"),))      ;          },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(label),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
