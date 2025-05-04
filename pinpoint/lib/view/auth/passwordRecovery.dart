import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/view/widget/navigate_back_button.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

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
                  Text("Password Recovery",
                      style: Theme.of(context).textTheme.headlineLarge),
                      Text("We have sent a OTP to your email address",style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(
                    height: 46,
                  ),
                  
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.numbers_outlined,
                          size: 24,
                          color: AppColor.lightSecondaryText,
                        ),
                        labelText: "OTP",
                        ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                 
                      Text("Remember your password?",style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(
                    height: 64,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Done",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: AppColor.light),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                 
                ],
              ),
            ),
          ),
        ));
  }
}
