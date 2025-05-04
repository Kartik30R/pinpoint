import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';
import 'package:pinpoint/view/admin/map_screen.dart';
import 'package:pinpoint/view/user/userProfile.dart';
import 'package:pinpoint/viewModel/Employee/employeeController.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          _buildUserInfo(context)

        ],
      )),
      
    );
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
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
              child: Text("Map")),
        )
      ],
    ),
  );
}
}
// 
// Widget _/