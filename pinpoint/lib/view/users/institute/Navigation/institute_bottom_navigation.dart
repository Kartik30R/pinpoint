import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/resources/routes/app_routes.dart';
import 'package:pinpoint/resources/routes/bottom_navigation_provider.dart';


class InstituteBottomNavBar extends ConsumerWidget {
  const InstituteBottomNavBar({super.key});

  static const tabs = [
    AppRoutes.instituteTab1,
    AppRoutes.instituteTab2,
    AppRoutes.instituteTab3,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(instituteNavIndexProvider);

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) {
        ref.read(instituteNavIndexProvider.notifier).state = i;
        context.go(tabs[i]);
        
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Inst 1'),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Inst 2'),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Inst 3'),
      ],
    );
  }
}
