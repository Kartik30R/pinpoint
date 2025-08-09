import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/resources/routes/bottom_navigation_provider.dart';
import 'package:pinpoint/view/users/institute/Navigation/institute_shell.dart';
import 'package:pinpoint/view/users/institute/tab_screens/institute_screen.dart';
import 'package:pinpoint/view/users/institute/tab_screens/institute_screen3.dart';

class InstituteShell extends ConsumerWidget {
  final child;
  const InstituteShell( {this.child,super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(instituteNavIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: index,
        children:   [
          InstituteScreen(),   
          InstituteScreen3(),  
        ],
      ),
      bottomNavigationBar: InstituteBottomNavBar(),
    );
  }
}
