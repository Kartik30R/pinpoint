import 'package:flutter/material.dart';
import 'package:pinpoint/model/address/address.dart';
import 'package:uuid/uuid.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressPoolScreenState();
}

class _AddressPoolScreenState extends State<AddressListScreen> {
  // --- Mock Data ---
  // Replace this with a call to your API to fetch all addresses
  final List<Address> _addresses = [
    Address(id: 'addr-001', streetAddress: '123 Tech Lane', city: 'Innovate City', state: 'CA', postalCode: '94043', country: 'USA'),
    Address(id: 'addr-002', streetAddress: '456 Code Avenue', city: 'Dev Town', state: 'TX', postalCode: '73301', country: 'USA'),
    Address(id: 'addr-003', streetAddress: '789 Byte Boulevard', city: 'Logicburg', state: 'NY', postalCode: '10001', country: 'USA'),
  ];
  // ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an Address'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _addresses.length,
        itemBuilder: (context, index) {
          final address = _addresses[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              leading: Icon(Icons.location_on_outlined, color: Theme.of(context).colorScheme.primary),
              title: Text(address.streetAddress, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${address.city}, ${address.state}'),
              onTap: () {
                Navigator.of(context).pop(address);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Navigate to the "Add Address" page and wait for a result
          final newAddress = await Navigator.of(context).push<Address>(
            MaterialPageRoute(builder: (context) => const AddAddressScreen()),
          );

          if (newAddress != null) {
            // If a new address was created, add it to the list and refresh the UI
            setState(() {
              _addresses.add(newAddress);
            });
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(const SnackBar(content: Text('New address added to the pool!')));
          }
        },
        icon: const Icon(Icons.add_location_alt_outlined),
        label: const Text('Add New Address'),
      ),
      
    );
  }
}


/// Screen with a form to create a new address for the pool.
class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each text field
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, create the new Address object
      final newAddress = Address(
        id: const Uuid().v4(), // Generate a new unique ID
        streetAddress: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        postalCode: _zipController.text,
        country: _countryController.text,
      );

      // TODO: Call your provider/API to save the address to your database

      // Pop the screen and return the newly created address
      Navigator.of(context).pop(newAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
                    icon: const Icon(Icons.save_outlined),
                    onPressed: _saveForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    label: const Text('Save Address'),
                  ),
      ),
      appBar: AppBar(
        title: const Text('Add New Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextFormField(
                  controller: _streetController,
                  labelText: 'Street Address',
                  icon: Icons.location_on_outlined,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter a street address' : null,
                ),
                _buildTextFormField(
                  controller: _cityController,
                  labelText: 'City',
                  icon: Icons.location_city_outlined,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter a city' : null,
                ),
                _buildTextFormField(
                  controller: _stateController,
                  labelText: 'State / Province',
                  icon: Icons.map_outlined,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter a state' : null,
                ),
                _buildTextFormField(
                  controller: _zipController,
                  labelText: 'ZIP / Postal Code',
                  icon: Icons.local_post_office_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter a postal code' : null,
                ),
                _buildTextFormField(
                  controller: _countryController,
                  labelText: 'Country',
                  icon: Icons.public_outlined,
                  validator: (value) => (value == null || value.isEmpty) ? 'Please enter a country' : null,
                ),
                const SizedBox(height: 32),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface.withAlpha(150),
        ),
        validator: validator,
      ),
    );
  }
}
