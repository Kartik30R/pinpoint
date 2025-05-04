import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/resources/constant/dimension/app_dimension.dart';
import 'package:pinpoint/view/widget/navigate_back_button.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  NavigateBackButton(),
                  SizedBox(
                    height: 36,
                  ),
                  Text("Please fill in your details",
                      style: Theme.of(context).textTheme.headlineLarge),
                  SizedBox(height: 46,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_4_outlined,
                        size: 24,
                        color: AppColor.lightSecondaryText,
                      ),
                      labelText: "Full Name",
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android_outlined,
                        size: 24,
                        color: AppColor.lightSecondaryText,
                      ),
                      labelText: "Phone Number",
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        size: 24,
                        color: AppColor.lightSecondaryText,
                      ),
                      labelText: "Email Address",
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          size: 24,
                          color: AppColor.lightSecondaryText,
                        ),
                        labelText: "Password",
                        suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                  ),
                  SizedBox(height: 18,
                  ),
                  Row(
                    spacing: 2,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:MainAxisAlignment.start ,
                    children: [
                      
                      SizedBox(height: 24,width: 24,child: Checkbox(
  value: false,
  onChanged: (value) {},
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  ),
  side: BorderSide(
    color: AppColor.lightSecondaryText,  
    width: 1.5,  
  ),
)),
                      SizedBox(width: 2,),
                      Text('I agree to the terms and conditions',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  Expanded(
                      flex: 4,
                      child: SizedBox(
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Create Account",style: Theme.of(context).textTheme.headlineMedium?.copyWith(color:AppColor.light),),
                  ),
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                      )),
                  Text('Have an account? login',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
