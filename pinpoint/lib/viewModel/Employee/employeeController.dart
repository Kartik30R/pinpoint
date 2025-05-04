import 'package:flutter/material.dart';
import 'package:pinpoint/viewModel/services/Storage/localStorage.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeController extends ChangeNotifier {
  LocalStorage localStorage = LocalStorage();

  String userName = "";
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime focusedDate = DateTime.now();
  DateTime? selectedDate;

  EmployeeController() {
    init();  
  }

  Future<void> init() async {
    userName = await localStorage.readValue("userName") ?? "";
    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate = selectedDay;
    focusedDate = focusedDay;
    notifyListeners();
  }

  void saveUserName(String name) async {
    await localStorage.setValue("userName", name);
    userName = name;  
    print("name saved"+ userName);
    notifyListeners();
  }
}
