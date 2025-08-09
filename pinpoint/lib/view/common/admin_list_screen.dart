import 'package:flutter/material.dart';
import 'package:pinpoint/model/admin/admin_response.dart';
import 'package:pinpoint/view/common/admin_detail_screen.dart';
import 'package:pinpoint/view/users/institute/create_admin_screen.dart';

class AdminListScreen extends StatelessWidget {
   AdminListScreen({super.key});

  // --- Mock Data ---
  // Replace this with a call to your API: getAdminsByInstituteId
  final List<AdminResponse> _admins =  [
    AdminResponse(id: 'admin-01', name: 'Johnathan Doe', email: 'j.doe@example.com', phone: '+1 123-456-7890', role: 'ADMIN', instituteId: 'inst-A', createdAt: '', updatedAt: '', isVerified: true, notices: [], batches: []),
    AdminResponse(id: 'admin-02', name: 'Jane Smith', email: 'j.smith@example.com', phone: '+1 987-654-3210', role: 'ADMIN', instituteId: 'inst-A',  createdAt: '', updatedAt: '', isVerified: true, notices: [], batches: []),
    AdminResponse(id: 'admin-03', name: 'Peter Jones', email: 'p.jones@example.com', phone: '+1 555-555-5555', role: 'ADMIN', instituteId: 'inst-A', createdAt: '', updatedAt: '', isVerified: false, notices: [], batches: []),
  ];
  // ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Admins'),
        // If this screen is a tab, you might not need a back button.
        // If it's pushed on top, the back button will appear automatically.
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _admins.length,
        itemBuilder: (context, index) {
          final admin = _admins[index];
          return AdminListTile(admin: admin);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAdminScreen(),));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Admin'),
      ),
    );
  }
}

class AdminListTile extends StatelessWidget {
  final AdminResponse admin;

  const AdminListTile({required this.admin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            admin.name?.substring(0, 1) ?? 'A',
            style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
          ),
        ),
        title: Text(
          admin.name ?? 'No Name',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(admin.phone),
            const SizedBox(height: 6),
            // Display batch IDs using chips for better UI
            Wrap(
              spacing: 6.0,
              runSpacing: 4.0,
              children: admin.batches
                  .map((e) => Chip(
                        label: Text(e.id.split('-').last), // Show a cleaner version of the ID
                        labelStyle: const TextStyle(fontSize: 12),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ))
                  .toList(),
            ),
          ],
        ),
        onTap: () {
          // Navigate to the detail screen, passing the admin object
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminDetailScreen(admin: admin),
          ));
        },
      ),
    );
  }
}
