
import 'package:flutter/material.dart';
import 'package:pinpoint/model/admin/admin_response.dart';
import 'package:pinpoint/view/common/admin_detail_screen.dart';

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
                  .map((id) => Chip(
                        label: Text(id.id.split('-').last), // Show a cleaner version of the ID
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
