import 'package:flutter/material.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/batch/batch_list_response.dart';
import 'package:pinpoint/model/user/update_user_dto.dart';
import 'package:pinpoint/model/user/user_detail_dto.dart';

// --- Placeholder Models (for demonstration) ---
class AdminListResponse {
  final String id;
  final String name;
  const AdminListResponse({required this.id, required this.name});
}
// ---

/// A single screen for both creating and editing a student's details.
class AddEditStudentScreen extends StatefulWidget {
  /// If a student object is provided, the screen operates in "Edit Mode".
  /// If it's null, the screen operates in "Add Mode".
  final UserDetailDto? student;

  const AddEditStudentScreen({super.key, this.student});

  @override
  State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool _isEditMode;
  bool _obscurePassword = true;

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final _passwordController = TextEditingController();

  // State variables for complex objects
  Address? _selectedAddress;
  BatchListResponse? _selectedBatch;
  AdminListResponse? _selectedAdmin;
  late bool _isVerified;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.student != null;
    final s = widget.student;

    // Initialize controllers and state based on mode
    _nameController = TextEditingController(text: s?.name);
    _emailController = TextEditingController(text: s?.email);
    _phoneController = TextEditingController(text: s?.phone);
    _isVerified = s?.isVerified ?? false;
    _selectedAddress = s?.address;
    _selectedBatch = s?.batch;
    _selectedAdmin = s?.adminId != null ? AdminListResponse(id: s!.adminId!, name: s.adminName ?? 'N/A') : null;
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
      if (_isEditMode) {
        // --- UPDATE LOGIC ---
        final updateUserDto = UpdateUserDto(
          name: _nameController.text,
          phone: _phoneController.text,
          isVerified: _isVerified,
          address: _selectedAddress!, // Add null check for production
          batch: _selectedBatch,
          adminId: _selectedAdmin?.id,
        );
        // TODO: Call API to update student
        print('Updating student: ${widget.student!.id}');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student details updated.'), backgroundColor: Colors.green));
      } else {
        // --- CREATE LOGIC ---
        // TODO: Create a proper request DTO for creating a user
        // final createUserRequest = { ... };
        // TODO: Call API to create student
        print('Creating new student...');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New student created.'), backgroundColor: Colors.green));
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Student' : 'Add New Student'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          children: [
            // --- Editable Fields ---
            _buildSectionHeader('User Information'),
            _buildTextFormField(controller: _nameController, labelText: 'Full Name', icon: Icons.person_outline),
            const SizedBox(height: 16),
            // Email is only editable in Add Mode
            _buildTextFormField(controller: _emailController, labelText: 'Email Address', icon: Icons.email_outlined, enabled: !_isEditMode),
            const SizedBox(height: 16),
            _buildTextFormField(controller: _phoneController, labelText: 'Phone Number', icon: Icons.phone_outlined, keyboardType: TextInputType.phone),
            const SizedBox(height: 16),

            // Password field is only shown in Add Mode
            if (!_isEditMode)
              _buildTextFormField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: (v) => (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
              ),
            
            // --- Selection Fields ---
            const SizedBox(height: 24),
            _buildSectionHeader('Assignments & Status'),
            _buildSelectionTile(title: 'Address', subtitle: _selectedAddress?.toString() ?? 'Not Set', onTap: () {/* TODO: Navigate to address selection */}),
            _buildSelectionTile(title: 'Batch', subtitle: _selectedBatch?.name ?? 'Not Assigned', onTap: () {/* TODO: Navigate to batch selection */}),
            _buildSelectionTile(title: 'Managing Admin', subtitle: _selectedAdmin?.name ?? 'Not Assigned', onTap: () {/* TODO: Navigate to admin selection */}),
            
            SwitchListTile(
              title: const Text('User is Verified'),
              value: _isVerified,
              onChanged: (value) => setState(() => _isVerified = value),
              secondary: const Icon(Icons.verified_user_outlined),
              contentPadding: EdgeInsets.zero,
            ),

            // --- Read-Only Fields (in Edit Mode) ---
            if (_isEditMode) ...[
              const Divider(height: 40),
              _buildSectionHeader('System Information'),
              _buildReadOnlyField(label: 'Role', value: widget.student!.role, icon: Icons.security_outlined),
              _buildReadOnlyField(label: 'Institute ID', value: widget.student!.instituteId ?? 'N/A', icon: Icons.business_outlined),
              _buildReadOnlyField(label: 'Date Created', value: widget.student!.createdAt, icon: Icons.calendar_today_outlined),
            ],

            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: Icon(_isEditMode ? Icons.save_outlined : Icons.add_circle_outline),
              label: Text(_isEditMode ? 'Save Changes' : 'Create Student'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool enabled = true,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: enabled ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
      ),
      validator: validator ?? (v) => (v == null || v.isEmpty) ? 'This field is required' : null,
    );
  }

  Widget _buildSelectionTile({required String title, required String subtitle, required VoidCallback onTap}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildReadOnlyField({required String label, required String value, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const UnderlineInputBorder(),
          filled: false,
        ),
      ),
    );
  }
}
