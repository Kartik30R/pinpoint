import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/viewModel/admin/admin_provider.dart';

class AdminListScreen extends ConsumerWidget {
  final String instituteId;

  const AdminListScreen({super.key, required this.instituteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminsAsync = ref.watch(adminListProvider(instituteId));

    return Scaffold(
      appBar: AppBar(title: const Text('Admins')),
      body: adminsAsync.when(
        data: (admins) => ListView.builder(
          itemCount: admins.length,
          itemBuilder: (_, index) {
            final admin = admins[index];
            return ListTile(
              title: Text(admin.email),
              subtitle: Text(admin.phone),
              onTap: () {
                // navigate to detail/edit screen
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
