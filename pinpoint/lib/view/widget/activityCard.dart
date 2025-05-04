import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';

class Activitycard extends StatelessWidget {
   Activitycard({required this.event,required this.icon,required this.time,super.key});
IconData icon;
String event;
String time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimension().borderRadius)
          
        ),

      ),
    );
  }
}