import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/resources/routes/bottom_navigation_provider.dart';
import 'package:pinpoint/view/users/admin/navigation/admin_bottom_navigation.dart';
import 'package:pinpoint/view/users/admin/tab_screens/admin_Screen_1.dart';
import 'package:pinpoint/view/users/admin/tab_screens/admin_screen_2.dart';
import 'package:pinpoint/view/users/admin/tab_screens/admin_screen_3.dart';
class AdminShell extends ConsumerWidget {
  final child;
  const AdminShell( {this.child,super.key});

  static final List<Widget> _tabs = [
    AdminScreen1(),
    AdminScreen2(),
    AdminScreen3(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(adminNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: _tabs,
      ),
      bottomNavigationBar: AdminBottomNavBar(),
    );
  }
}

