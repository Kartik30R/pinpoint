import 'package:flutter/material.dart';
import 'package:pinpoint/model/user/user_list_dto.dart';
import 'package:pinpoint/view/users/admin/student_location_map_screen.dart';
import 'package:pinpoint/view/users/institute/edit_student_screen.dart';
import 'package:pinpoint/view/users/institute/user_detail.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  // --- Mock Data ---
  // In a real app, this would be fetched from a provider/repository
  final List<UserListDto> _students = [
    UserListDto(id: 'user-001', name: 'Alice Johnson', email: 'alice.j@example.com', phone: '555-0101'),
    UserListDto(id: 'user-002', name: 'Bob Williams', email: 'bob.w@example.com', phone: '555-0102'),
    UserListDto(id: 'user-003', name: 'Charlie Brown', email: 'charlie.b@example.com', phone: '555-0103'),
  ];
  // ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Students'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child:ListTile(
  leading: CircleAvatar(
    child: Text(student.name.substring(0, 1)),
  ),
  title: Text(
    student.name,
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
  subtitle: Text(student.email),
  trailing: SizedBox(
    width: 72, // or adjust as needed
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentLocationMapScreen(
                  studentId: student.email,
                  studentName: student.name,
                ),
              ),
            );
          },
          icon: const Icon(Icons.map),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      ],
    ),
  ),
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StudentDetailScreen(userId: student.id),
      ),
    );
  },
)

          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to an "Add Student" screen
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddEditStudentScreen()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Student'),
      ),
    );
  }
}
