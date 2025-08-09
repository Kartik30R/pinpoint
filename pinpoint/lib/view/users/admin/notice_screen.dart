import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// --- Mock Model (for demonstration) ---
// In a real app, you would have a more complex model and fetch data from an API.
class Notice {
  final String id;
  String content; // Changed to non-final to allow editing
  final DateTime timestamp;

  Notice({required this.id, required this.content, required this.timestamp});
}
// ---

/// A screen for admins to send notices to batches and view past notices.
class SendNoticeScreen extends StatefulWidget {
  const SendNoticeScreen({super.key});

  @override
  State<SendNoticeScreen> createState() => _SendNoticeScreenState();
}

class _SendNoticeScreenState extends State<SendNoticeScreen> {
  final _noticeController = TextEditingController();

  // --- Mock Data ---
  final List<Notice> _sentNotices = [
    Notice(
      id: 'notice-002',
      content:
          'The results for the mid-term exams have been declared. Please check the student portal.',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
    ),
    Notice(
      id: 'notice-001',
      content:
          'Reminder: The guest lecture on AI is scheduled for tomorrow at 10 AM in the main auditorium.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];
  // ---

  void _sendNotice() {
    if (_noticeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Notice cannot be empty.'),
            backgroundColor: Colors.red),
      );
      return;
    }

    // TODO: Add API call to send the notice to selected batches.

    setState(() {
      // Add the new notice to the top of the list for immediate feedback.
      _sentNotices.insert(
        0,
        Notice(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(), // Use a temporary unique ID
          content: _noticeController.text.trim(),
          timestamp: DateTime.now(),
        ),
      );
      _noticeController.clear(); // Clear the text field after sending.
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Notice sent successfully!'),
          backgroundColor: Colors.green),
    );
  }

  void _deleteNotice(String noticeId) {
    // TODO: Add API call to delete the notice from the backend.
    setState(() {
      _sentNotices.removeWhere((notice) => notice.id == noticeId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Notice deleted.'), backgroundColor: Colors.red),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String noticeId) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this notice?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteNotice(noticeId);
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editNotice(Notice notice) async {
    final updatedContent = await showDialog<String>(
      context: context,
      builder: (context) => _EditNoticeDialog(initialContent: notice.content),
    );

    if (updatedContent != null && updatedContent.isNotEmpty) {
      // TODO: Add API call to update the notice in the backend.
      setState(() {
        notice.content = updatedContent;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Notice updated successfully!'),
            backgroundColor: Colors.green),
      );
    }
  }

  @override
  void dispose() {
    _noticeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notice'),
      ),
      body: Column(
        children: [
          // The top card for composing and sending a new notice.
          _buildComposeCard(context),
          const Divider(height: 1),
          // The header for the history section.
          _buildHistoryHeader(context),
          // The list of previously sent notices.
          Expanded(
            child: _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildComposeCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: Add a dropdown or multi-select chip group to select target batches.
          const Text("Compose New Notice",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _noticeController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Type your message here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _sendNotice,
              icon: const Icon(Icons.send_outlined),
              label: const Text('Send to Batches'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Previously Sent',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    if (_sentNotices.isEmpty) {
      return const Center(
        child: Text('No notices have been sent yet.'),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: _sentNotices.length,
      itemBuilder: (context, index) {
        final notice = _sentNotices[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            title: Text(notice.content),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                // Format the timestamp for better readability
                DateFormat.yMMMd().add_jm().format(notice.timestamp),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: () => _editNotice(notice),
                  tooltip: 'Edit Notice',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      size: 20, color: Colors.red),
                  onPressed: () => _showDeleteConfirmation(context, notice.id),
                  tooltip: 'Delete Notice',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A dialog for editing the content of a notice.
class _EditNoticeDialog extends StatefulWidget {
  final String initialContent;
  const _EditNoticeDialog({required this.initialContent});

  @override
  State<_EditNoticeDialog> createState() => _EditNoticeDialogState();
}

class _EditNoticeDialogState extends State<_EditNoticeDialog> {
  late TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Notice'),
      content: TextField(
        controller: _editController,
        autofocus: true,
        maxLines: 5,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Return the updated content when saving
            Navigator.of(context).pop(_editController.text.trim());
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
