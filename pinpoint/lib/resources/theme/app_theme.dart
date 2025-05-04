import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/resources/theme/custom_theme/elevated_button_theme.dart';
import 'package:pinpoint/resources/theme/custom_theme/input_decoration_theme.dart';
import 'package:pinpoint/resources/theme/custom_theme/text_theme.dart';
class AppTheme {
  static ThemeData lightTheme = ThemeData(
      dividerTheme: const DividerThemeData(
        color: Color.fromARGB(39, 163, 167, 174),
      ),
      inputDecorationTheme: AppInputDecorationTheme.lightInputTheme,
      primaryColorLight: AppColor.dark,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.light,
      textTheme: AppTextTheme.lightTextTheme,
      brightness: Brightness.light,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
  );

  // static ThemeData darkTheme = ThemeData(
  //     dividerTheme:
  //         const DividerThemeData(color: Color.fromARGB(39, 119, 121, 125)),
  //     primaryColorLight: AppColor.light,
  //     inputDecorationTheme: AppInputDecorationTheme.darkInputTheme,
  //     iconTheme: AppIconTheme.darkIconTheme,
  //     primaryColor: AppColor.primary,
  //     bottomNavigationBarTheme: AppNavigationTheme.darkNavigationTheme,
  //     scaffoldBackgroundColor: AppColor.dark,
  //     brightness: Brightness.dark,
  //     textTheme: AppTextTheme.darkTextTheme,
  //     fontFamily: 'Inter',
  //     cardTheme: AppCardTheme.darkCardTheme);
}
