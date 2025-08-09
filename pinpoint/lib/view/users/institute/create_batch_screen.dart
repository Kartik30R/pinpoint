
import 'package:flutter/material.dart';
import 'package:pinpoint/model/batch/batch_list_response.dart';
import 'package:pinpoint/view/widget/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class CreateBatchScreen extends StatefulWidget {
  const CreateBatchScreen({super.key});

  @override
  State<CreateBatchScreen> createState() => _CreateBatchScreenState();
}

class _CreateBatchScreenState extends State<CreateBatchScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each text field
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validate the form before proceeding
    if (_formKey.currentState!.validate()) {
      // Form is valid, create the BatchModel object
      final newBatch = BatchListResponse(
        // ID is often handled by the backend, but we can generate one for the client-side model
        id: const Uuid().v4(), 
        name: _nameController.text,
        code: _codeController.text,
      );

      // --- TODO: Call your API provider here ---
      // Example:
      // final success = await ref.read(batchProvider).createBatch(newBatch);
      // if (success) {
      //   Navigator.of(context).pop();
      // } else {
      //   // Show error message
      // }
      // -----------------------------------------

      // For now, just print the data and show a success message
      print('Form submitted!');
      print('Batch Name: ${newBatch.name}');
      print('Batch Code: ${newBatch.code}');
      
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Creating new batch...'),
            backgroundColor: Colors.green,
          ),
        );

      // Optionally, pop the screen after successful submission
      Navigator.of(context).pop(newBatch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                    label: const Text('Create Batch'),
                  ),
      ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: const Text('Create New Batch'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: _nameController,
                  labelText: 'Batch Name',
                  icon: Icons.school_outlined,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter a batch name' : null,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _codeController,
                  labelText: 'Batch Code',
                  icon: Icons.code_outlined,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter a unique batch code' : null,
                ),
                const SizedBox(height: 32),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
