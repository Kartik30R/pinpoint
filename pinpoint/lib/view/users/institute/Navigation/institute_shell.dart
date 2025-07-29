import 'package:flutter/material.dart';
import 'package:pinpoint/view/users/institute/Navigation/institute_bottom_navigation.dart';

class InstituteShell extends StatelessWidget {
  final Widget child;
  const InstituteShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: InstituteBottomNavBar(),
    );
  }
}
