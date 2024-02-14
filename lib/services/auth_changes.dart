import 'package:flutter/material.dart';
import 'package:project_management/presentation/screens/signin_screen.dart';
import 'package:project_management/presentation/screens/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthChanges extends StatefulWidget {
  final SupabaseClient supabase;
  const AuthChanges({super.key, required this.supabase});

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
      return SignUpScreen(
        onTap: switchScreens,
        supabase: widget.supabase,
      );
    }
  }
}
