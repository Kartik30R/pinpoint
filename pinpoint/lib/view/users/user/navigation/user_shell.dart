import 'package:flutter/material.dart';
import 'package:pinpoint/view/users/user/navigation/user_bottom_navigationBar.dart';

class UserShell extends StatelessWidget {
  final Widget child;
  const UserShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: UserBottomNavBar(),
    );
  }
}
