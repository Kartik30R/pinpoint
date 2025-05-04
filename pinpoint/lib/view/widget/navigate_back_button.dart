import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';

class NavigateBackButton extends StatefulWidget {
  const NavigateBackButton({super.key});

  @override
  State<NavigateBackButton> createState() => _NavigateBackButtonState();
}

class _NavigateBackButtonState extends State<NavigateBackButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Color(0xffF5F5F5),
            width: 1.5,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(child: Icon(Icons.arrow_back_ios, color:AppColor.dark, size: 24)),
        ),
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}