import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';
import 'package:pinpoint/viewModel/Employee/employeeController.dart';
import 'package:provider/provider.dart';

class ProfileSetting extends StatelessWidget {
   ProfileSetting({super.key});


   TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimension().defaultMargin),
        child: Consumer<EmployeeController>(
          builder: (context, viewModel, child) {
             String userName = "Name";
             userName = viewModel.userName;
            nameController.text =  viewModel.userName;

            return Column(
              children: [
                 Text(userName,style: Theme.of(context).textTheme.headlineLarge,),
                const SizedBox(height: 40),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    viewModel.saveUserName(nameController.text);
                    print("Name saved: ${nameController.text}");
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
