import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/viewModel/auth/auth_provider.dart';
 

class BatchListResponse {
  final String id;
  final String name;
  const BatchListResponse({required this.id, required this.name});
}

class NoticeDto {
  // Define properties for NoticeDto if needed, or leave as a placeholder
}

class AdminResponse {
  final String id;
  final String email;
  final String phone;
  final String? name;
  final String role;
  final Address? address;
  final String instituteId;
  final List<BatchListResponse> batches;
  final List<NoticeDto> notices;
  final String createdAt;
  final String updatedAt;
  final bool isVerified;

  const AdminResponse({
    required this.id,
    required this.email,
    required this.phone,
    this.name,
    required this.role,
    this.address,
    required this.instituteId,
    required this.batches,
    required this.notices,
    required this.createdAt,
    required this.updatedAt,
    required this.isVerified,
  });
}
// ---

/// A screen to display the profile information for the logged-in admin.
class AdminScreen2 extends ConsumerWidget {
    AdminScreen2({super.key});

  // --- Mock Data ---
  // In a real app, this would be fetched from a user provider or repository.
  final AdminResponse _admin = AdminResponse(
    id: 'admin-01',
    name: 'Dr. Evelyn Reed',
    email: 'e.reed@example.com',
    phone: '+1 (800) 555-0123',
    role: 'ADMIN',
    isVerified: true,
    instituteId: 'inst-A',
    address: Address(
      id: 'addr-admin-1',
      streetAddress: '456 Academy Lane',
      city: 'Innovate City',
      state: 'CA',
      postalCode: '94043',
      country: 'USA',
    ),
    batches: const [
      BatchListResponse(id: 'batch-A', name: 'Batch A - Morning'),
      BatchListResponse(id: 'batch-B', name: 'Batch B - Afternoon'),
    ],
    notices: const [],
    createdAt: '2023-01-15T09:30:00Z',
    updatedAt: '2023-10-20T14:00:00Z',
  );
  // ---

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProfileHeader(context, _admin),
          const SizedBox(height: 24),
          _buildInfoCard(context, _admin),
          const SizedBox(height: 24),
          _buildAssignedBatches(context, _admin.batches),
          const SizedBox(height: 24),
          _buildLogoutButton(ref,context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, AdminResponse admin) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: theme.colorScheme.secondaryContainer,
          child: Text(
            admin.name?.substring(0, 1) ?? 'A',
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          admin.name ?? 'Admin Name',
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (admin.isVerified)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Chip(
              avatar: Icon(Icons.verified, color: Colors.green.shade700, size: 18),
              label: const Text('Verified'),
              backgroundColor: Colors.green.withOpacity(0.1),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, AdminResponse admin) {
    return Card(
      child: Column(
        children: [
          _buildInfoTile(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: admin.email,
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildInfoTile(
            icon: Icons.phone_outlined,
            title: 'Phone',
            subtitle: admin.phone,
          ),
          if (admin.address != null) ...[
            const Divider(height: 1, indent: 16, endIndent: 16),
            _buildInfoTile(
              icon: Icons.location_on_outlined,
              title: 'Address',
              subtitle: admin.address.toString(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAssignedBatches(BuildContext context, List<BatchListResponse> batches) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assigned Batches',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (batches.isEmpty)
              const Text('No batches assigned.')
            else
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: batches.map((batch) => Chip(label: Text(batch.name))).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle}) {
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
    await ref.read(authProvider).logout();
       context.go('/');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout success')),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
