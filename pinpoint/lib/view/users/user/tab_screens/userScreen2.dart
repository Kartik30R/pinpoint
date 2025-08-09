import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/batch/batch_list_response.dart';
import 'package:pinpoint/model/user/user_detail_dto.dart';
import 'package:pinpoint/viewModel/auth/auth_provider.dart';

 

/// A screen to display the profile and settings for the logged-in student.
class UserScreen2 extends ConsumerStatefulWidget {
  const UserScreen2({super.key});
  
  @override
  ConsumerState<UserScreen2> createState() =>_UserScreen2State();

  // @override
  // State<UserScreen2> createState() => _UserScreen2State();
}

class _UserScreen2State extends ConsumerState<UserScreen2> {
  // --- Mock Data ---
  final UserDetailDto _student =   UserDetailDto(
    id: 'user-01',
    name: 'Alice Johnson',
    email: 'alice.j@example.com',
    phone: '555-0101',
    role: 'USER',
    isVerified: true,
    address: Address(streetAddress: '123 Flutter Lane', city: 'Widgetville', state: '', postalCode: '', country: ''),
    batch: BatchListResponse(id: 'batch-cs101', name: 'Computer Science 101', code: ''),
    instituteId: 'inst-A',
    adminId: 'admin-1',
    adminName: 'Dr. Evelyn Reed',
    createdAt: '2023-08-10T10:00:00Z',
    updatedAt: '2023-08-10T10:00:00Z',
  );
  // ---

  bool _isLocationEnabled = true; // State for the toggle switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileHeader(context, _student),
          const SizedBox(height: 24),
          _buildInfoCard(context, _student),
          const SizedBox(height: 24),
          _buildSettingsCard(context),
          const SizedBox(height: 24),
          _buildLogoutButton(ref,context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserDetailDto student) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          child: Text(student.name.substring(0, 1),
              style: theme.textTheme.headlineLarge),
        ),
        const SizedBox(height: 16),
        Text(student.name,
            style:
                theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        Text(student.email, style: theme.textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, UserDetailDto student) {
    return Card(
      child: Column(
        children: [
          _buildInfoTile(
              icon: Icons.phone_outlined,
              title: 'Phone',
              subtitle: student.phone),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildInfoTile(
              icon: Icons.school_outlined,
              title: 'Batch',
              subtitle: student.batch?.name ?? 'Not Assigned'),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildInfoTile(
              icon: Icons.location_on_outlined,
              title: 'Address',
              subtitle: student.address?.toString() ?? 'Not set'),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return Card(
      child: SwitchListTile(
        title: const Text('Enable Location Service',
            style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: const Text('Required for automatic attendance'),
        secondary: const Icon(Icons.location_searching),
        value: _isLocationEnabled,
        onChanged: (bool value) {
          setState(() {
            _isLocationEnabled = value;
          });
          // TODO: Add logic to persist this setting and handle location permissions.
        },
      ),
    );
  }

  Widget _buildInfoTile(
      {required IconData icon, required String title, required String subtitle}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildLogoutButton(WidgetRef ref,BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Logout'),
      onPressed: () async {
await  ref.read(authProvider).logout();  
   context.go('/');
   ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout success')),
        );
    },
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}
