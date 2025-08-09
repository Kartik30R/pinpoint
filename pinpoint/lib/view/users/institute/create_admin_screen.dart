import 'package:flutter/material.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/admin/admin_request.dart';
import 'package:pinpoint/view/widget/address_selector.dart';
import 'package:pinpoint/view/widget/custom_text_field.dart';

class CreateAdminScreen extends StatefulWidget {
  const CreateAdminScreen({super.key});

  @override
  State<CreateAdminScreen> createState() => _CreateAdminScreenState();
}

class _CreateAdminScreenState extends State<CreateAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  Address? _selectedAddress;

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
      if (_selectedAddress == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an address.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final adminRequest = AdminRequest(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        instituteId:
            'your-institute-id', // TODO: Replace with actual instituteId
        address: _selectedAddress,
      );

      print('Form submitted with Address ID: ${_selectedAddress!.id}');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Creating Admin...')));
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Admin')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: const Text('Create Admin'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader('Admin Credentials'),
                CustomTextFormField(
                    controller: _nameController,
                    labelText: 'Full Name',
                    icon: Icons.person_outline,
                    validator: (v) =>
                        v!.isEmpty ? 'Please enter a name' : null),
                CustomTextFormField(
                    controller: _emailController,
                    labelText: 'Email Address',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) =>
                        !v!.contains('@') ? 'Enter a valid email' : null),
                CustomTextFormField(
                    controller: _phoneController,
                    labelText: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (v) =>
                        v!.isEmpty ? 'Enter a phone number' : null),
                CustomTextFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword)),
                    validator: (v) => v!.length < 6
                        ? 'Password must be at least 6 characters'
                        : null),
                const SizedBox(height: 24),
                _buildSectionHeader('Address'),
                AddressSelectorField(
                  selectedAddress: _selectedAddress,
                  onAddressSelected: (addr) =>
                      setState(() => _selectedAddress = addr),
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
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600)),
    );
  }
}
