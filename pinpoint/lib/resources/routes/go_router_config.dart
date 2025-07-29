import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/resources/routes/app_routes.dart';
import 'package:pinpoint/splash_screen.dart';
import 'package:pinpoint/view/auth/sign_in_page.dart';
import 'package:pinpoint/view/auth/sign_up_page.dart';
import 'package:pinpoint/view/users/admin/navigation/admin_shell.dart';
import 'package:pinpoint/view/users/admin/tab_screens/admin_Screen_1.dart';
import 'package:pinpoint/view/users/admin/tab_screens/admin_screen_2.dart';
import 'package:pinpoint/view/users/admin/tab_screens/admin_screen_3.dart';
import 'package:pinpoint/view/users/institute/Navigation/institute_shell.dart';
import 'package:pinpoint/view/users/institute/tab_screens/institute_screen.dart';
import 'package:pinpoint/view/users/institute/tab_screens/institute_screen2.dart';
import 'package:pinpoint/view/users/institute/tab_screens/institute_screen3.dart';
import 'package:pinpoint/view/users/user/navigation/user_shell.dart';
import 'package:pinpoint/view/users/user/tab_screens/userScreen.dart';
import 'package:pinpoint/view/users/user/tab_screens/userScreen2.dart';
import 'package:pinpoint/view/users/user/tab_screens/userScreen3.dart';
import 'package:pinpoint/viewModel/auth/auth_provider.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authController = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final isLoggedIn = await authController.isLoggedIn();
      final location = state.fullPath;

      if (!isLoggedIn) {
        return (location == AppRoutes.signUp) ? null : AppRoutes.logIn;
      }

      final role = await authController.storageService.role;

      if ([AppRoutes.logIn, AppRoutes.signUp, '/'].contains(location)) {
        switch (role) {
          case 'ADMIN':
            return AppRoutes.adminTab1;
          case 'USER':
            return AppRoutes.userTab1;
          case 'INSTITUTE':
            return AppRoutes.instituteTab1;
          default:
            return AppRoutes.logIn;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.logIn,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

      // Admin Shell
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) => AdminShell(child: child),
        routes: [
          GoRoute(path: AppRoutes.adminTab1, builder: (_, __) => AdminScreen1()),
          GoRoute(path: AppRoutes.adminTab2, builder: (_, __) => AdminScreen2()),
          GoRoute(path: AppRoutes.adminTab3, builder: (_, __) => AdminScreen3()),
        ],
      ),

      // User Shell
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) => UserShell(child: child),
        routes: [
          GoRoute(path: AppRoutes.userTab1, builder: (_, __) => UserScreen()),
          GoRoute(path: AppRoutes.userTab2, builder: (_, __) => UserScreen2()),
          GoRoute(path: AppRoutes.userTab3, builder: (_, __) => UserScreen3()),
        ],
      ),

      // Institute Shell
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) => InstituteShell(child: child),
        routes: [
          GoRoute(path: AppRoutes.instituteTab1, builder: (_, __) => InstituteScreen()),
          GoRoute(path: AppRoutes.instituteTab2, builder: (_, __) => InstituteScreen2()),
          GoRoute(path: AppRoutes.instituteTab3, builder: (_, __) => InstituteScreen3()),
        ],
      ),
    ],
  );
});
