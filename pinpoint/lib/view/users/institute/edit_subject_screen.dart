

import 'package:flutter/material.dart';
import 'package:pinpoint/model/subject/subject.dart';

class AddEditSubjectScreen extends StatefulWidget {
  final SubjectResponse? subject;

  const AddEditSubjectScreen({super.key, this.subject});

  @override
  State<AddEditSubjectScreen> createState() => _AddEditSubjectScreenState();
}

class _AddEditSubjectScreenState extends State<AddEditSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isEditMode;

  late TextEditingController _nameController;
  late TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.subject != null;
    _nameController = TextEditingController(text: widget.subject?.name);
    _codeController = TextEditingController(text: widget.subject?.code);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final subjectRequest = SubjectRequest(
        name: _nameController.text,
        code: _codeController.text,
        instituteId: widget.subject?.instituteId ?? 'your-institute-id', // TODO: Get instituteId from provider
      );

      if (_isEditMode) {
        // TODO: Call API to update subject
        print('Updating subject: ${widget.subject!.id}');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subject updated.'), backgroundColor: Colors.green));
      } else {
        // TODO: Call API to create subject
        print('Creating new subject...');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New subject created.'), backgroundColor: Colors.green));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Subject' : 'Add New Subject'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildTextFormField(
              controller: _nameController,
              labelText: 'Subject Name',
              icon: Icons.title,
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              controller: _codeController,
              labelText: 'Subject Code',
              icon: Icons.code,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: Icon(_isEditMode ? Icons.save_outlined : Icons.add_circle_outline),
              label: Text(_isEditMode ? 'Save Changes' : 'Create Subject'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }
}
