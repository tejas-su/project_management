import 'package:flutter/material.dart';
import 'package:project_management/presentation/screens/signin_screen.dart';
import 'package:project_management/presentation/screens/signup_screen.dart';

class AuthChanges extends StatefulWidget {
  const AuthChanges({super.key});

  @override
  State<AuthChanges> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<AuthChanges> {
  //initially show login page
  bool showLoginPage = true;
  //function to switch between the pages
  void switchScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return SignInScreen(onTap: switchScreens);
    } else {
      return SignUpScreen(onTap: switchScreens);
    }
  }
}
