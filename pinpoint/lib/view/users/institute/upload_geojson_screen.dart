import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/viewModel/location/geojson_upload_provider.dart';

class GeoJsonUploadScreen extends ConsumerWidget {
  const GeoJsonUploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload GeoJSON')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload GeoJSON"),
          onPressed: () async {
            final success = await ref.read(geoJsonUploadProvider).uploadGeoJsonFile();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(success ? 'Upload successful!' : 'Upload failed'),
                backgroundColor: success ? Colors.green : Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }
}
