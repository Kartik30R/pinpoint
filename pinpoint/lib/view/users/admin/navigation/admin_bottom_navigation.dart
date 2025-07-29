import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/resources/routes/app_routes.dart';
import 'package:pinpoint/resources/routes/bottom_navigation_provider.dart';


class AdminBottomNavBar extends ConsumerWidget {
  const AdminBottomNavBar({super.key});

  static const tabs = [
    AppRoutes.adminTab1,
    AppRoutes.adminTab2,
    AppRoutes.adminTab3,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(adminNavIndexProvider);

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) {
        ref.read(adminNavIndexProvider.notifier).state = i;
        context.go(tabs[i]);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Admin 1'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Admin 2'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Admin 3'),
      ],
    );
  }
}
