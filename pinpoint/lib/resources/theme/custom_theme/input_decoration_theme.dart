import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme darkInputTheme = InputDecorationTheme(
    floatingLabelStyle:
        TextStyle(color: AppColor.primary, fontSize: AppDimension().h3FontSize),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.inactiveBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.primary),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.errorText),
    ),
  );

  static InputDecorationTheme lightInputTheme = InputDecorationTheme(
    labelStyle: TextStyle(
        color: AppColor.lightSecondaryText,
        fontSize: AppDimension().h3FontSize),
    floatingLabelStyle:
        TextStyle(color: AppColor.primary, fontSize: AppDimension().h3FontSize),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.inactiveBorder,width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.inactiveBorder,width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.primary,width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.error,width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimension().borderRadius),
      borderSide: BorderSide(color: AppColor.errorText,width: 1.5),
    ),
  );
}
