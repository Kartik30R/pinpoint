import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyMedium: const TextStyle().copyWith(
      color: AppColor.lightRegularText,
      fontSize: AppDimension().bodyFontSize,
    ),
    bodySmall: const TextStyle().copyWith(
      color: AppColor.lightRegularText,
      fontSize: AppDimension().smallDescriptionFontSize,
    ),
    titleLarge: const TextStyle().copyWith(
      color: AppColor.lightRegularText,
      fontSize: AppDimension().h3FontSize,
    ),
    headlineLarge: const TextStyle().copyWith(
        color: AppColor.lightRegularText,
        fontSize: AppDimension().h1FontSize,
        fontWeight: FontWeight.bold),
    headlineMedium: const TextStyle().copyWith(
        color: AppColor.lightRegularText,
        fontSize: AppDimension().h2FontSize,
        fontWeight: FontWeight.bold),
  );

//   static TextTheme darkTextTheme = TextTheme(
//       bodyMedium: const TextStyle().copyWith(
//         color: AppColor.darkRegularText,
//         fontSize: AppDimension().bodyText,
//       ),
//       bodyLarge: const TextStyle().copyWith(
//         color: AppColor.darkRegularText,
//         fontSize: AppDimension().bodyLargeText,
//       ),
//       bodySmall: const TextStyle().copyWith(
//         color: AppColor.darkRegularText,
//         fontSize: AppDimension().bodySmallText,
//       ),

//       //title 1
//       titleLarge: const TextStyle().copyWith(
//           color: AppColor.darkRegularText,
//           fontSize: AppDimension().title1Text,
//           fontWeight: FontWeight.bold),
//       titleMedium: const TextStyle().copyWith(
//           color: AppColor.darkRegularText,
//           fontSize: AppDimension().title2Text,
//           fontWeight: FontWeight.bold),
//       titleSmall: const TextStyle().copyWith(
//         color: AppColor.darkRegularText,
//         fontSize: AppDimension().title3Text,
//       ),

//       //Headline
//       headlineLarge: const TextStyle().copyWith(
//           color: AppColor.darkRegularText,
//           fontSize: AppDimension().headlineText,
//           fontWeight: FontWeight.w600),

//       // Subheadline - Medium
//       headlineMedium: const TextStyle().copyWith(
//           color: AppColor.darkRegularText,
//           fontSize: AppDimension().subHeadlineText,
//           fontWeight: FontWeight.w500),

// //Subheadline
//       headlineSmall: const TextStyle().copyWith(
//         color: AppColor.darkRegularText,
//         fontSize: AppDimension().subHeadlineText,
//       ),

//       //caption
//       labelSmall: const TextStyle().copyWith(
//         color: AppColor.darkSecondaryText,
//         fontSize: AppDimension().captionText,
//       ),
//       //caption medium
//       labelMedium: const TextStyle().copyWith(
//         color: AppColor.darkTertiaryText,
//         fontSize: AppDimension().captionText,
//       ),

//       //navigation label
//       displaySmall: const TextStyle().copyWith(
//         color: AppColor.darkRegularText,
//         fontSize: AppDimension().navigationLabelText
//       )

//       );
}
