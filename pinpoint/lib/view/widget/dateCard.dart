import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';

class Datecard extends StatelessWidget {
  final IconData icon;
  final String event;
  final String time;
  final String? comment;
  const Datecard(
      {super.key,
      required this.event,
      required this.time,
      this.comment,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 140,
        decoration: BoxDecoration(
            color: AppColor.light,
            boxShadow: [
              BoxShadow(
                  color: AppColor.dark,
                
                  offset: const Offset(2, 2))
            ],
            borderRadius: BorderRadius.circular(AppDimension().borderRadius),
            border: Border.all(color: AppColor.dark, width: 1.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor.primaryShade1),
                  child: Icon(
                    icon,
                    color: AppColor.primary,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(event),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 12,
            ),
            Text(comment ?? "")
          ],
        ),
      ),
    );
  }
}
