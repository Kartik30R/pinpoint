import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';
import 'package:pinpoint/view/admin/adminScreen.dart';
import 'package:pinpoint/view/admin/map_screen.dart';
import 'package:pinpoint/view/user/userProfile.dart';
import 'package:pinpoint/view/widget/dateCard.dart';
import 'package:pinpoint/viewModel/Employee/employeeController.dart';
import 'package:pinpoint/viewModel/location/locationController.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            _buildUserInfo(context),
            _buildCalendarTable(context),
            _buildSummaryGrid(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildUserInfo(BuildContext context) {
    final viewModel = context.read<EmployeeController>();

  return Padding(
    padding: EdgeInsets.all(AppDimension().defaultMargin),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserprofileScreen()),
          ),
          child: CircleAvatar(
            child: Container(),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.userName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text("site")
          ],
        ),
        SizedBox(width: 2,),
        Container(height: 50,width: 100,
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminScreen()),
                );
              },
              child: Text("Admin")),
        )
      ],
    ),
  );
}

Widget _buildCalendarTable(BuildContext context) {
  final viewModel = context.watch<EmployeeController>();

  return Stack(
    children: [
      TableCalendar(
        firstDay: DateTime.utc(2004),
        lastDay: DateTime.now(),
        focusedDay: viewModel.focusedDate,
        selectedDayPredicate: (day) =>
            viewModel.selectedDate != null &&
            isSameDay(viewModel.selectedDate, day),
        onDaySelected: (selectedDay, focusedDay) {
          viewModel.onDaySelected(selectedDay, focusedDay);
        },
        calendarFormat: viewModel.calendarFormat,
        headerVisible: true,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontSize: 16),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(fontSize: 16),
          weekendTextStyle: TextStyle(fontSize: 16),
          selectedDecoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 75, 75, 75)),
            borderRadius: BorderRadius.circular(AppDimension().borderRadius),
            color: AppColor.primary,
            shape: BoxShape.rectangle,
          ),
          selectedTextStyle: TextStyle(color: Colors.white),
          todayDecoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(color: Colors.black),
          outsideDaysVisible: false,
        ),
      ),
      // Container(
      //   child: Column(children: [],),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //         bottomRight: Radius.circular(AppDimension().borderRadius),
      //         topRight: Radius.circular(AppDimension().borderRadius)),
      //         color: AppColor.primary,
      //   ),
      //   height: 64,
      //   width: 60,
      // )
    ],
  );
}

Widget _buildSummaryGrid(BuildContext context) {
  final viewModel = context.read<LocationController>();
  return Padding(
    padding: EdgeInsets.all(AppDimension().defaultMargin),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today Attendence',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Datecard(
              event: 'Check In',
              time: '23:23 pm',
              icon: Icons.arrow_forward_rounded,
              comment: "hello",
            ),
            SizedBox(
              width: AppDimension().defaultMargin,
            ),
            Datecard(
              event: 'Check In',
              time: '23:23 pm',
              icon: Icons.arrow_forward_rounded,
              comment: "hello",
            )
          ],
        ),
        SizedBox(height: AppDimension().defaultMargin),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Datecard(
              event: 'Check In',
              time: '23:23 pm',
              icon: Icons.arrow_forward_rounded,
              comment: "hello",
            ),
            SizedBox(
              width: AppDimension().defaultMargin,
            ),
            Datecard(
              event: 'Check In',
              time: '23:23 pm',
              icon: Icons.arrow_forward_rounded,
              comment: "hello",
            )
          ],
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(),
            onPressed: () {
              viewModel.startTracking();
            },
            child: Text("data")),
        Consumer<LocationController>(
          builder: (BuildContext context, value, Widget? child) {
            return Column(
              children: [
                Text("longitude : ${value.currentLocation?.longitude}"),
                Text("latitude : ${value.currentLocation?.latitude}"),
                Text("altitude : ${value.currentLocation?.altitude}"),
                Text(
                    "time : ${DateTime.fromMillisecondsSinceEpoch(value.currentLocation?.time?.toInt() ?? 12)}"),
              ],
            );
          },
          // child:
        ),
      ],
    ),
  );
}
