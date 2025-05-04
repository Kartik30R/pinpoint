import 'package:flutter/material.dart';
import 'package:pinpoint/viewModel/location/locationController.dart';
import 'package:provider/provider.dart';

class Locationhistory extends StatelessWidget {
  const Locationhistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Consumer<LocationController>(
            builder: (context, value, child) => 
           Column(
             children: [
              ElevatedButton(onPressed: (){value.getLocationHistory();}, child: Text("data")),
               DataTable(
                  columns: [
                    DataColumn(label:Text("latitude")),
                                        DataColumn(label:Text("longitude")),

                    DataColumn(label:Text("altitude")),
                    DataColumn(label:Text("time")),

                  ],
                 rows: value.locationHistory.map((e) => DataRow(
  cells: [
    DataCell(Text(e.latitude.toString())),
    DataCell(Text(e.longitude.toString())),
    // DataCell(Text(e.altitude.toString())),
    DataCell(Text(e.timestamp.toString())),
  ],
) ) .toList(),

                ),
             ],
           ),
          ),
        ],
      ),
    );
  }
}