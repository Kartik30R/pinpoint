import 'package:flutter/material.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/batch/batch_list_response.dart';
import 'package:pinpoint/model/user/user_detail_dto.dart';
import 'package:pinpoint/view/users/institute/edit_student_screen.dart';

class StudentDetailScreen extends StatefulWidget {
  final String userId;
  const StudentDetailScreen({super.key, required this.userId});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  late Future<UserDetailDto> _studentDetailsFuture;

  @override
  void initState() {
    super.initState();
    _studentDetailsFuture = _fetchStudentDetails();
  }

  // --- Mock Data Fetch ---
  Future<UserDetailDto> _fetchStudentDetails() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, you would call: ref.read(provider).getUserDetails(widget.userId)
    return UserDetailDto(
      id: widget.userId,
      name: 'Alice Johnson',
      email: 'alice.j@example.com',
      phone: '555-0101',
      role: 'USER',
      isVerified: true,
      address: Address(id: 'addr-1', streetAddress: '123 Flutter Lane', city: 'Widgetville', state: 'CA', postalCode: '90210', country: 'USA'),
      batch: BatchListResponse(id: 'batch-cs101', name: 'Computer Science 101', code: ''),
      instituteId: 'inst-A',
      adminId: 'admin-1',
      adminName: 'Dr. Evelyn Reed',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }
  // ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        actions: [
          FutureBuilder<UserDetailDto>(
            future: _studentDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Only show the edit button if data has loaded
                return IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AddEditStudentScreen(student: snapshot.data!),
                    ));
                  },
                );
              }
              return const SizedBox.shrink(); // Hide button while loading
            },
          ),
        ],
      ),
      body: FutureBuilder<UserDetailDto>(
        future: _studentDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Student not found.'));
          }

          final student = snapshot.data!;
          return _buildDetailsView(context, student);
        },
      ),
    );
  }

  Widget _buildDetailsView(BuildContext context, UserDetailDto student) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildDetailItem(context, 'Name', student.name, Icons.person_outline),
        _buildDetailItem(context, 'Email', student.email, Icons.email_outlined),
        _buildDetailItem(context, 'Phone', student.phone, Icons.phone_outlined),
        _buildDetailItem(
          context,
          'Verification Status',
          student.isVerified ? 'Verified' : 'Not Verified',
          Icons.verified_user_outlined,
          valueColor: student.isVerified ? Colors.green.shade700 : Colors.orange.shade800,
        ),
        if (student.address != null)
          _buildDetailItem(context, 'Address', student.address.toString(), Icons.location_on_outlined),
        const Divider(height: 32),
        if (student.batch != null)
          _buildDetailItem(context, 'Assigned Batch', student.batch!.name, Icons.school_outlined),
        if (student.adminName != null)
          _buildDetailItem(context, 'Managed by Admin', student.adminName!, Icons.admin_panel_settings_outlined),
      ],
    );
  }

  Widget _buildDetailItem(BuildContext context, String title, String value, IconData icon, {Color? valueColor}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: valueColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
