import 'package:flutter/material.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/admin/admin_request.dart';
import 'package:pinpoint/model/admin/admin_response.dart';
import 'package:pinpoint/view/widget/address_selector.dart';
import 'package:pinpoint/view/widget/custom_text_field.dart';

class EditAdminScreen extends StatefulWidget {
  final AdminResponse admin;
  const EditAdminScreen({super.key, required this.admin});

  @override
  State<EditAdminScreen> createState() => _EditAdminScreenState();
}

class _EditAdminScreenState extends State<EditAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final _passwordController = TextEditingController();

  Address? _selectedAddress;

  @override
  void initState() {
    super.initState();
    final admin = widget.admin;
    _nameController = TextEditingController(text: admin.name);
    _emailController = TextEditingController(text: admin.email);
    _phoneController = TextEditingController(text: admin.phone);
    _selectedAddress = admin.address;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final adminRequest = AdminRequest(
        name: _nameController.text,
        phone: _phoneController.text,
        // Only include password if it has been changed
        password: _passwordController.text.isNotEmpty ? _passwordController.text : null,
        address: _selectedAddress,
      );

      // TODO: Call your updateAdmin API
      print('Update form submitted for admin ID: ${widget.admin.id}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updating Admin...')));
      Navigator.of(context).pop();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: const Text('Save Changes'),
                  ),
      ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(title: const Text('Edit Admin')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader('Admin Details'),
                // Email is read-only
                CustomTextFormField(controller: _emailController, labelText: 'Email Address (Cannot be changed)', icon: Icons.email_outlined, enabled: false),
                CustomTextFormField(controller: _nameController, labelText: 'Full Name', icon: Icons.person_outline, validator: (v) => v!.isEmpty ? 'Please enter a name' : null),
                CustomTextFormField(controller: _phoneController, labelText: 'Phone Number', icon: Icons.phone_outlined, keyboardType: TextInputType.phone, validator: (v) => v!.isEmpty ? 'Enter a phone number' : null),
                CustomTextFormField(controller: _passwordController, labelText: 'New Password (Optional)', icon: Icons.lock_outline, obscureText: _obscurePassword, suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)),
                  validator: (v) => (v != null && v.isNotEmpty && v.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Address'),
AddressSelectorField(
  selectedAddress: _selectedAddress,
  onAddressSelected: (addr) => setState(() => _selectedAddress = addr),
),
                const SizedBox(height: 32),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
    );
  }
}
 