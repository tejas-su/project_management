// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management/presentation/screens/home_content.dart';
import 'package:project_management/presentation/screens/loading_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/cta_button.dart';
import '../widgets/text_field.dart';
import '../themes/themes.dart';

class SignUpScreen extends StatefulWidget {
  final Function()? onTap;
  final SupabaseClient supabase;
  const SignUpScreen({super.key, required this.onTap, required this.supabase});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    //user controller
    TextEditingController groupEmailController = TextEditingController();
    //group controller
    TextEditingController groupPasswordController = TextEditingController();
    //password controller
    TextEditingController groupNameController = TextEditingController();

    //Show success dialog to the user if everything goes properly
    void _showDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success 🥳"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }

    //show error message to the user if something goes wrong
    void _showErrorDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Oops, something went wrong"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }

    //create a new team in the database
    Future<void> insertUserData() async {
      try {
        final response = await widget.supabase.from('team').upsert([
          {
            'team_name': groupNameController.text,
            'team_email': groupEmailController.text,
            'team_password': groupPasswordController.text,
          }
        ]);
        print('Table insertion response\n\n $response');
      } catch (error) {
        _showErrorDialog(context,
            'Oops, Something went wrong while creating your team./n This was the error message: $error');
      }
    }

    //register the user
    Future<void> registerUser() async {
      if (groupEmailController.text.isEmpty ||
          groupPasswordController.text.length < 7 ||
          groupNameController.text.length < 5) {
        _showErrorDialog(context,
            "Please fill in all fields and use a password with at least 7 characters and a group name with at least 5 characters.");
        return;
      }

      try {
        final session = await widget.supabase.auth.signUp(
          email: groupEmailController.text,
          password: groupPasswordController.text,
        );

        // ignore: unnecessary_null_comparison
        if (session == null) {
          _showErrorDialog(context, "An error occurred during registration.");
        } else {
          //upsert data to the table
          insertUserData();
          // Successful registration, show success message and switch to sign-in

          LoadingScreen(
            screen: const HomeContent(),
            supabase: widget.supabase,
          );
          _showDialog(context, "Registration successful!");
          widget.onTap?.call();
        }
      } catch (error) {
        _showErrorDialog(context, "An unexpected error occurred.");
      }
    }

    // add the team details to the public table teams in supabase

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///left section
            Expanded(
              flex: 2,
              child: Container(
                  height: 800,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: whiteBG),
                  child: Image.asset(
                    'images/bg2.png',
                    fit: BoxFit.fitHeight,
                  )),
            ),
            //right section
            Expanded(
              flex: 1,
              child: Container(
                height: 740,
                decoration: const BoxDecoration(
                    color: whiteContainer,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )),
                child: Stack(children: [
                  Align(
                      alignment: const AlignmentDirectional(0, -1),
                      child:
                          Lottie.asset('lottie/ani2.json', fit: BoxFit.cover)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Shrine',
                        style: GoogleFonts.dmSerifDisplay(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '"A one stop solution for project management"',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        controller: groupEmailController,
                        hintText: 'Group Email',
                        left: 100,
                        right: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        controller: groupNameController,
                        hintText: 'Group Name',
                        left: 100,
                        right: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                          controller: groupPasswordController,
                          left: 100,
                          right: 100,
                          hintText: 'Password',
                          obscureText: true),
                      const SizedBox(
                        height: 20,
                      ),
                      CTAButton(
                        text: 'Register',
                        onTap: registerUser,
                        left: 100,
                        right: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(fontSize: 10),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
