import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/resources/routes/bottom_navigation_provider.dart';

class AdminBottomNavBar extends ConsumerWidget {
  const AdminBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(adminNavIndexProvider);

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (i) => ref.read(adminNavIndexProvider.notifier).state = i,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Tab 1'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Tab 2'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Tab 3'),
      ],
    );
  }
}
