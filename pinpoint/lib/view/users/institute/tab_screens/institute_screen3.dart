import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:pinpoint/model/institute/institute.dart';
import 'package:pinpoint/viewModel/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InstituteScreen3 extends ConsumerWidget {
  InstituteScreen3({super.key});

  // --- Mock Data ---
  // In a real app, this would be fetched from a user provider or repository
  final InstituteResponse _institute = InstituteResponse(
    id: 'inst-A',
    name: 'Pinpoint University',
    email: 'contact@pinpointuni.edu',
    phone: '+1 (800) 555-0199',
    isVerified: true,
    baseAltitude: '150.5',
    address: Address(
      id: 'addr-main',
      streetAddress: '123 University Ave',
      city: 'Innovate City',
      state: 'CA',
      postalCode: '94043',
      country: 'USA',
    ),
  );
  // ---

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildProfileHeader(context, _institute),
            const SizedBox(height: 24),
            _buildInfoCard(context, _institute),
            const SizedBox(height: 24),
            _buildLogoutButton(ref, context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, InstituteResponse institute) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            institute.name?.substring(0, 1) ?? 'P',
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          institute.name ?? 'Institute Name',
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (institute.isVerified == true)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Chip(
              avatar:
                  Icon(Icons.verified, color: Colors.green.shade700, size: 18),
              label: const Text('Verified'),
              backgroundColor: Colors.green.withOpacity(0.1),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, InstituteResponse institute) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildInfoTile(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: institute.email ?? 'Not available',
          ),
          const Divider(height: 1),
          _buildInfoTile(
            icon: Icons.phone_outlined,
            title: 'Phone',
            subtitle: institute.phone ?? 'Not available',
          ),
          const Divider(height: 1),
          _buildInfoTile(
            icon: Icons.location_on_outlined,
            title: 'Address',
            subtitle: institute.address?.toString() ?? 'Not available',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle:
          Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildLogoutButton(WidgetRef ref, BuildContext context) {
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
