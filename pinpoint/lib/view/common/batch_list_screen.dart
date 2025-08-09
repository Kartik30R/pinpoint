import 'package:flutter/material.dart';
import 'package:pinpoint/model/batch/batch_list_response.dart';
import 'package:pinpoint/view/common/batch_detail_screen.dart';
import 'package:pinpoint/view/users/institute/create_batch_screen.dart';

class BatchListScreen extends StatelessWidget {
  final bool isSelectionMode;

   BatchListScreen({super.key, this.isSelectionMode = false});

  // --- Mock Data ---
  // In a real app, you would fetch this from your provider/repository
  final List<BatchListResponse> _allBatches =  [
    BatchListResponse(id: 'batch-CS101', name: 'Computer Science 101', code: 'CS101'),
    BatchListResponse(id: 'batch-PHY202', name: 'Physics 202', code: 'PHY202'),
    BatchListResponse(id: 'batch-MTH301', name: 'Mathematics 301', code: 'MTH301'),
    BatchListResponse(id: 'batch-CHM101', name: 'Chemistry 101', code: 'CHM101'),
    BatchListResponse(id: 'batch-ENG201', name: 'English Literature 201', code: 'ENG201'),
  ];
  // ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBatchScreen(),));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Batch'),
      ),
      appBar: AppBar(
        title: Text(isSelectionMode ? 'Select a Batch' : 'All Batches'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _allBatches.length,
        itemBuilder: (context, index) {
          final batch = _allBatches[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: ListTile(
              title: Text(batch.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Code: ${batch.code}'),
              trailing: isSelectionMode
                  ? const Icon(Icons.add_circle_outline)
                  : const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () {
                if (isSelectionMode) {
                  // In selection mode, pop the navigator and return the selected batch ID
                  Navigator.of(context).pop(batch.id);
                } else {
                  // In view mode, navigate to the detail screen
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BatchDetailScreen(batchId: batch.id),
                  ));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
