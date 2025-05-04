import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';
import 'package:pinpoint/viewModel/location/locationController.dart';
import 'package:provider/provider.dart';
class AltitudeSet extends StatelessWidget {
   AltitudeSet({super.key});
 final baseController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimension().defaultMargin),
        child: Consumer<LocationController>(
          builder: (context, viewModel, child) {

            return Column(
              children: [
                Text(
                  viewModel.currentBase.toString(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(viewModel.currentLocation!.altitude.toString()),
                const SizedBox(height: 40),
                TextField(
                  controller: baseController,
                  decoration: const InputDecoration(labelText: "Altitude"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    viewModel.setBase(baseController.text);
                    print("Altitude saved: ${baseController.text}");
                  },
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.currentLocation != null) {
                      final altitude = viewModel.currentLocation!.altitude.toString();
                      viewModel.setBase(altitude);
                    }
                    print(viewModel.currentBase);
                  },
                  child: const Text("Save by sensor"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
