import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';

class AppElevatedButtonTheme {
  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.primary,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(58), // Fixed height of 58, width will be dynamic
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      ),
      padding: EdgeInsets.zero, // No additional padding since the height is already fixed
    ),
  );
}
