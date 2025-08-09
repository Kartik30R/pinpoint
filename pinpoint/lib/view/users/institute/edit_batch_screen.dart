
import 'package:flutter/material.dart';
import 'package:pinpoint/model/batch/batch_list_response.dart';
import 'package:pinpoint/view/widget/custom_text_field.dart';

class EditBatchScreen extends StatefulWidget {
  final BatchListResponse batch;

  const EditBatchScreen({super.key, required this.batch});

  @override
  State<EditBatchScreen> createState() => _EditBatchScreenState();
}


class _EditBatchScreenState extends State<EditBatchScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.batch.name);
    _codeController = TextEditingController(text: widget.batch.code);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedBatch = BatchListResponse(
        id: widget.batch.id,
        name: _nameController.text,
        code: _codeController.text,
      );

      //  TODO: Call your API provider here to update the batch ---
      // Example:
      // final success = await ref.read(batchProvider).updateBatch(updatedBatch);
      // if (success) {
      //   Navigator.of(context).pop();
      // } else {
      //   // Show error message
      // }
      // -----------------------------------------------------------

      // For now, just print the data and show a success message
      print('Update form submitted!');
      print('Updated Batch Name: ${updatedBatch.name}');
      print('Updated Batch Code: ${updatedBatch.code}');
      
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Updating batch...'),
            backgroundColor: Colors.green,
          ),
        );

      // Optionally, pop the screen after successful submission
      Navigator.of(context).pop(updatedBatch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Batch'),
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
                ElevatedButton.icon(
                  icon: const Icon(Icons.save_outlined),
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  label: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
