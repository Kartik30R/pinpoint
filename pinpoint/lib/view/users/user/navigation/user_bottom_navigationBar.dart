import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/resources/routes/app_routes.dart';
import 'package:pinpoint/resources/routes/bottom_navigation_provider.dart';

class UserBottomNavBar extends ConsumerWidget {
  const UserBottomNavBar({super.key});

  static const tabs = [
    AppRoutes.userTab1,
    AppRoutes.userTab2,
    AppRoutes.userTab3,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(userNavIndexProvider);

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) {
        ref.read(userNavIndexProvider.notifier).state = i;
        context.go(tabs[i]);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tab 1'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tab 2'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tab 3'),
      ],
    );
  }
}
