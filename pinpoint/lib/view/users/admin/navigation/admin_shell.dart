import 'package:flutter/material.dart';
import 'package:pinpoint/view/users/admin/navigation/admin_bottom_navigation.dart';

class AdminShell extends StatelessWidget {
  final Widget child;
  const AdminShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AdminBottomNavBar(),
    );
  }
}
