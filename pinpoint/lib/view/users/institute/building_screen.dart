import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/viewModel/institute/building_provider.dart';

class BuildingListScreen extends ConsumerWidget {
  final String instituteId;

  const BuildingListScreen({super.key, required this.instituteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingAsync = ref.watch(buildingListProvider(instituteId));

    return Scaffold(
      appBar: AppBar(title: const Text("Buildings")),
      body: buildingAsync.when(
        data: (buildings) => ListView.builder(
          itemCount: buildings.length,
          itemBuilder: (context, index) {
            final b = buildings[index];
            return ListTile(
              title: Text(b.name ?? "Unnamed"),
              subtitle: Text("Base Altitude: ${b.baseAltitude ?? "N/A"}"),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
