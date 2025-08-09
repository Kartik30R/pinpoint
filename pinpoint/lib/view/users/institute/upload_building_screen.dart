import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geolocator/geolocator.dart';

// Note: To use this screen, you need to add the following dependencies
// to your pubspec.yaml file:
// dependencies:
//   file_picker: ^6.2.1
//   geolocator: ^12.0.0

/// A screen for uploading a GeoJSON building plan and configuring its height properties.
class UploadBuildingPlanScreen extends StatefulWidget {
  const UploadBuildingPlanScreen({super.key});

  @override
  State<UploadBuildingPlanScreen> createState() => _UploadBuildingPlanScreenState();
}

class _UploadBuildingPlanScreenState extends State<UploadBuildingPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ceilHeightController = TextEditingController();
  final _baseHeightController = TextEditingController();

  String? _pickedFileName;
  bool _isFetchingLocation = false;

  /// Opens the device's file picker to select a GeoJSON file.
  Future<void> _pickGeoJsonFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['geojson', 'json'],
      );

      if (result != null) {
        setState(() {
          _pickedFileName = result.files.single.name;
          // In a real app, you would handle the file bytes or path:
          // final fileBytes = result.files.single.bytes;
          // final filePath = result.files.single.path;
        });
      }
    } catch (e) {
      // Handle potential errors, e.g., permissions not granted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e'), backgroundColor: Colors.red),
      );
    }
  }

  /// Fetches the current device altitude using the geolocator package.
  Future<void> _getCurrentAltitude() async {
    setState(() => _isFetchingLocation = true);
    try {
      // Check for location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied.')),
          );
          setState(() => _isFetchingLocation = false);
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      
      setState(() {
        // Update the text field with the fetched altitude
        _baseHeightController.text = position.altitude.toStringAsFixed(2);
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not fetch location: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isFetchingLocation = false);
    }
  }
  
  void _submitPlan() {
    if (_formKey.currentState!.validate()) {
      if (_pickedFileName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a GeoJSON file.'), backgroundColor: Colors.red),
        );
        return;
      }
      
      // TODO: Implement the API call to upload the file and data
      print('Submitting Plan:');
      print('File: $_pickedFileName');
      print('Ceiling Height: ${_ceilHeightController.text}');
      print('Base Height: ${_baseHeightController.text}');
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Uploading building plan...'), backgroundColor: Colors.green),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _ceilHeightController.dispose();
    _baseHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Building Plan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // --- File Picker Section ---
            _buildSectionHeader('Building Plan File'),
            _buildFilePickerTile(),
            const SizedBox(height: 24),

            // --- Height Configuration Section ---
            _buildSectionHeader('Floor Configuration'),
            _buildTextFormField(
              controller: _ceilHeightController,
              labelText: 'Ceiling Height (in meters)',
              hintText: 'e.g., 3.5',
              icon: Icons.height_outlined,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              controller: _baseHeightController,
              labelText: 'Base Floor Altitude (in meters)',
              hintText: 'Enter manually or get from GPS',
              icon: Icons.layers_outlined,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              suffixIcon: _isFetchingLocation
                  ? const CircularProgressIndicator()
                  : IconButton(
                      icon: const Icon(Icons.my_location_rounded),
                      onPressed: _getCurrentAltitude,
                      tooltip: 'Get Current Altitude',
                    ),
            ),
            const SizedBox(height: 32),
            
            // --- Submit Button ---
            ElevatedButton.icon(
              onPressed: _submitPlan,
              icon: const Icon(Icons.cloud_upload_outlined),
              label: const Text('Save Plan'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFilePickerTile() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: _pickGeoJsonFile,
        leading: const Icon(Icons.map_outlined, color: Colors.blueAccent),
        title: Text(_pickedFileName ?? 'Select GeoJSON file'),
        subtitle: _pickedFileName != null ? const Text('File selected') : null,
        trailing: const Icon(Icons.attach_file),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
