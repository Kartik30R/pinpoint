import 'package:flutter/material.dart';
import 'package:pinpoint/model/subject/subject.dart';
import 'package:pinpoint/view/users/institute/edit_subject_screen.dart';

class SubjectsListScreen extends StatefulWidget {
  const SubjectsListScreen({super.key});

  @override
  State<SubjectsListScreen> createState() => _SubjectsListScreenState();
}

class _SubjectsListScreenState extends State<SubjectsListScreen> {
  // --- Mock Data ---
  // In a real app, this would be fetched from a provider/repository
  final List<SubjectResponse> _subjects = [
    SubjectResponse(id: 'subj-001', name: 'Data Structures', code: 'CS101', instituteId: 'inst-A'),
    SubjectResponse(id: 'subj-002', name: 'Algorithms', code: 'CS102', instituteId: 'inst-A'),
    SubjectResponse(id: 'subj-003', name: 'Operating Systems', code: 'CS201', instituteId: 'inst-A'),
  ];
  // ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Subjects'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _subjects.length,
        itemBuilder: (context, index) {
          final subject = _subjects[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: ListTile(
              leading: const Icon(Icons.book_outlined),
              title: Text(subject.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Code: ${subject.code}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => AddEditSubjectScreen(subject: subject),
                  ));
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const AddEditSubjectScreen(),
          ));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Subject'),
      ),
    );
  }
}
