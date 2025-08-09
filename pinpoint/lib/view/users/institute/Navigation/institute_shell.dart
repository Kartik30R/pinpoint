import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/resources/routes/bottom_navigation_provider.dart';


class InstituteBottomNavBar extends ConsumerWidget {
  const InstituteBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(instituteNavIndexProvider);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _NavButton(
              label: 'Home',
              icon: Icons.home,
              selected: index == 0,
              onTap: () => ref.read(instituteNavIndexProvider.notifier).state = 0,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: _NavButton(
              label: 'Profile',
              icon: Icons.person,
              selected: index == 1,
              onTap: () => ref.read(instituteNavIndexProvider.notifier).state = 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: selected ? Colors.blueAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? Colors.white : Colors.black54),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
