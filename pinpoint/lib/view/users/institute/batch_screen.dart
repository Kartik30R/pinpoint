
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/model/batch.dart';
import 'package:pinpoint/viewModel/institute/batch_provider.dart';

final batchListProvider = FutureProvider((ref) async {
  final service = ref.read(batchServiceProvider);
  return service.getAllBatches();
});

class BatchListScreen extends ConsumerWidget {
  const BatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batchListAsync = ref.watch(batchListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Batches')),
      body: batchListAsync.when(
        data: (batches) => ListView.builder(
          itemCount: batches.length,
          itemBuilder: (ctx, i) => ListTile(
            title: Text(batches[i].name),
            subtitle: Text(batches[i].code),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await ref.read(batchServiceProvider).deleteBatch(batches[i].id);
                ref.refresh(batchListProvider);
              },
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateBatchScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateBatchScreen extends ConsumerStatefulWidget {
  const CreateBatchScreen({super.key});

  @override
  ConsumerState<CreateBatchScreen> createState() => _CreateBatchScreenState();
}

class _CreateBatchScreenState extends ConsumerState<CreateBatchScreen> {
  final nameController = TextEditingController();
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Batch')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Batch Name'),
            ),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'Batch Code'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final batch = BatchModel(
                  id: '',
                  name: nameController.text,
                  code: codeController.text,
                );
                await ref.read(batchServiceProvider).createBatch(batch);
                if (mounted) Navigator.pop(context);
              },
              child: const Text('Create'),
            )
          ],
        ),
      ),
    );
  }
}
