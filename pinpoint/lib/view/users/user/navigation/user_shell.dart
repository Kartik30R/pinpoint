import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/view/users/user/navigation/user_bottom_navigationBar.dart';
import 'package:pinpoint/view/users/user/tab_screens/userScreen.dart';
import 'package:pinpoint/view/users/user/tab_screens/userScreen2.dart';
import 'package:pinpoint/view/users/user/tab_screens/userScreen3.dart';
import 'package:pinpoint/resources/routes/bottom_navigation_provider.dart';

class UserShell extends ConsumerWidget {
  final child;
  const UserShell({this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(userNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: const [
          UserScreen(),
          UserScreen2(),
          UserScreen3(),
        ],
      ),
      bottomNavigationBar: UserBottomNavBar(),
    );
  }
}
