import 'package:flutter/material.dart';
import 'package:pinpoint/model/admin/admin_response.dart';
import 'package:pinpoint/view/common/batch_detail_screen.dart';
import 'package:pinpoint/view/common/batch_list_screen.dart';
import 'package:pinpoint/view/users/institute/edit_admin_screen.dart';

class AdminDetailScreen extends StatefulWidget {
  final AdminResponse admin;

  const AdminDetailScreen({super.key, required this.admin});

  @override
  State<AdminDetailScreen> createState() => _AdminDetailScreenState();
}

class _AdminDetailScreenState extends State<AdminDetailScreen> {
  // Use a local state variable to manage the list of batches
  late List<String> _assignedBatchIds;

  @override
  void initState() {
    super.initState();
    // Initialize the local list with the admin's current batches
    _assignedBatchIds = widget.admin.batches.map((e) => e.name,).toList();
  }

  Future<void> _assignNewBatch() async {
    // Navigate to the BatchesScreen in selection mode
    final selectedBatchId = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) =>  BatchListScreen(isSelectionMode: true),
      ),
    );

    if (selectedBatchId != null) {
      // If a batch was selected, update the UI
      if (_assignedBatchIds.contains(selectedBatchId)) {
        // Show a message if the batch is already assigned
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('Batch "$selectedBatchId" is already assigned.'),
            backgroundColor: Colors.orange.shade800,
          ));
      } else {
        // Add the new batch to the list and show a success message
        setState(() {
          _assignedBatchIds.add(selectedBatchId);
        });
        // TODO: Make an API call here to persist the change in the backend
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text('Successfully assigned batch "$selectedBatchId".'),
            backgroundColor: Colors.green.shade700,
          ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.admin.name ?? 'Admin Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditAdminScreen(admin: widget.admin)));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem(context, 'Name', widget.admin.name ?? 'N/A', Icons.person_outline),
            _buildDetailItem(context, 'Email', widget.admin.email, Icons.email_outlined),
            _buildDetailItem(context, 'Phone', widget.admin.phone, Icons.phone_outlined),
            _buildDetailItem(
              context,
              'Verification Status',
              widget.admin.isVerified ? 'Verified' : 'Not Verified',
              Icons.verified_outlined,
              valueColor: widget.admin.isVerified ? Colors.green.shade700 : Colors.orange.shade800,
            ),
            const Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assigned Batches',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                OutlinedButton.icon(
                  onPressed: _assignNewBatch,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Assign'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    side: BorderSide(color: theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Build the list using the local state variable
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _assignedBatchIds.length,
              itemBuilder: (context, index) {
                final batchId = _assignedBatchIds[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text('Batch $batchId'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BatchDetailScreen(batchId: batchId),
                      ));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String title, String value, IconData icon, {Color? valueColor}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
