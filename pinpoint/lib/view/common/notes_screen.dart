import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// --- Mock Model (for demonstration) ---
class Note {
  final String id;
  String content;
  final DateTime timestamp;

  Note({required this.id, required this.content, required this.timestamp});
}
// ---

/// A screen for admins to create, view, edit, and delete personal notes.
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _noteController = TextEditingController();

  // --- Mock Data ---
  final List<Note> _notes = [
    Note(
      id: 'note-001',
      content: 'Prepare the question paper for the upcoming CS101 mid-term exam.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Note(
      id: 'note-002',
      content: 'Follow up with the IT department about the new projector for Room 205.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];
  // ---

  void _addNote() {
    if (_noteController.text.trim().isEmpty) return;

    setState(() {
      _notes.insert(
        0,
        Note(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: _noteController.text.trim(),
          timestamp: DateTime.now(),
        ),
      );
      _noteController.clear();
    });
  }

  void _deleteNote(String noteId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() {
                _notes.removeWhere((note) => note.id == noteId);
              });
              Navigator.of(ctx).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _editNote(Note note) async {
    final updatedContent = await showDialog<String>(
      context: context,
      builder: (context) => _EditNoteDialog(initialContent: note.content),
    );

    if (updatedContent != null && updatedContent.isNotEmpty) {
      setState(() {
        note.content = updatedContent;
      });
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      body: Column(
        children: [
          _buildAddNoteCard(),
          const Divider(height: 1),
          Expanded(child: _buildNotesList()),
        ],
      ),
    );
  }

  Widget _buildAddNoteCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _noteController,
              decoration: InputDecoration(
                hintText: 'Add a new note...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onSubmitted: (_) => _addNote(),
            ),
          ),
          const SizedBox(width: 12),
          IconButton.filled(
            onPressed: _addNote,
            icon: const Icon(Icons.add),
            tooltip: 'Add Note',
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList() {
    if (_notes.isEmpty) {
      return const Center(child: Text('You have no notes.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            title: Text(note.content),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(DateFormat.yMMMd().add_jm().format(note.timestamp)),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: () => _editNote(note),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                  onPressed: () => _deleteNote(note.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A dialog for editing the content of a note.
class _EditNoteDialog extends StatefulWidget {
  final String initialContent;
  const _EditNoteDialog({required this.initialContent});

  @override
  State<_EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<_EditNoteDialog> {
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
      title: const Text('Edit Note'),
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
            Navigator.of(context).pop(_editController.text.trim());
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
