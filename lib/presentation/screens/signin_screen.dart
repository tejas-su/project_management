// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';
import 'imports.dart';

class SignInScreen extends StatefulWidget {
  final Function()? onTap;
  final SupabaseClient supabase;
  const SignInScreen({super.key, required this.onTap, required this.supabase});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    //user controller
    TextEditingController emailController = TextEditingController();
    //group controller
    TextEditingController groupController = TextEditingController();
    //password controller
    TextEditingController passwordController = TextEditingController();
    // save the group name in the web cache
    final Storage localStorage = window.localStorage;

    void showErrorDialog(BuildContext context, String message) {
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

    Future<void> signInUser() async {
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          groupController.text.length < 5) {
        showErrorDialog(context,
            "Please fill in all fields and use a password with at least 7 characters.");
        return;
      }

      try {
        showDialog(
          context: context,
          builder: (context) => Container(
            color: whiteBG,
            child: Center(child: Lottie.asset('lottie/ani1.json', height: 500)),
          ),
        );
        final session = await widget.supabase.auth.signInWithPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        localStorage['groupName'] = groupController.text;

        if (session == null) {
          Navigator.of(context).pop();
          showErrorDialog(context, "Invalid email or password.");
        } else {
          Navigator.of(context).pop();
          // Successful sign-in, navigate to home screen
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(supabase: widget.supabase),
          ));
        }
      } catch (error) {
        showErrorDialog(context, "An unexpected error occurred. \n $error");
      }
    }

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //left section
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
                ),
              ),
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
                        controller: emailController,
                        hintText: 'Group Email',
                        left: 100,
                        right: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        controller: groupController,
                        hintText: 'Group Name',
                        left: 100,
                        right: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                          controller: passwordController,
                          left: 100,
                          right: 100,
                          hintText: 'Password',
                          obscureText: true),
                      const SizedBox(
                        height: 20,
                      ),
                      CTAButton(
                        text: 'Sign in',
                        onTap: signInUser,
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
                            "Don't have an account? ",
                            style: TextStyle(fontSize: 10),
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              "Register Now",
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
