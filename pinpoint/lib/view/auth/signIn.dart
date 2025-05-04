import 'package:flutter/material.dart';
import 'package:pinpoint/resources/constant/color/app_color.dart';
import 'package:pinpoint/view/widget/navigate_back_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                  Text("Glad to see you again",
                      style: Theme.of(context).textTheme.headlineLarge),
                  SizedBox(
                    height: 46,
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
                  SizedBox(
                    height: 18,
                  ),
                 
                      Text("Forgot Password?",style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(
                    height: 64,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Sign In",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: AppColor.light),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Text('New to Pinpoint? Create an account',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        ));
  }
}
