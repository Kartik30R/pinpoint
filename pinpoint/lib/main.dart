import 'package:flutter/material.dart';
import 'package:pinpoint/repository/location_services/location_services.dart';
import 'package:pinpoint/resources/theme/app_theme.dart';
import 'package:pinpoint/view/user/userScreen.dart';
import 'package:pinpoint/viewModel/Employee/employeeController.dart';
import 'package:pinpoint/viewModel/bottomNavigationController.dart';
import 'package:pinpoint/viewModel/location/locationController.dart';
import 'package:pinpoint/viewModel/services/Storage/appStorage.dart';
import 'package:provider/provider.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  final locationService = LocationService();
  final AppStorage localStorage= AppStorage();
  localStorage.initDatabase();

  runApp(MultiProvider( providers: [

        Provider<LocationService>(create: (_) => locationService),
         ChangeNotifierProvider(
          create: (context) => EmployeeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationController(locationService),
        )
      ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        home: UserScreen());
  }
}
