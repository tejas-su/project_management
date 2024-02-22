// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/cta_button.dart';
import '../widgets/text_field.dart';
import '../themes/themes.dart';
import 'loading_screen.dart';

class SignInScreen extends StatefulWidget {
  final Function()? onTap;
  final SupabaseClient supabase;
  const SignInScreen({super.key, required this.onTap, required this.supabase});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    //user controller
    TextEditingController emailController = TextEditingController();
    //group controller
    TextEditingController groupController = TextEditingController();
    //password controller
    TextEditingController passwordController = TextEditingController();
    //signin a user function
    Future<void> signInUser() async {
      try {
        // check if the fields are empty or password is less than the mandatory length (7)
        if (emailController.text.isEmpty &&
            passwordController.text.isEmpty &&
            groupController.text.length < 7) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Did you forget to fill in the details"),
              content: const Text(
                  "Please check that you typed in your email, Group ID and password correctly"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Proceed"),
                ),
              ],
            ),
          );
        } else {
          widget.supabase.auth.signInWithPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => LoadingScreen(
              supabase: widget.supabase,
            ),
          ));
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Oops Something went wrong"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Proceed"),
              ),
            ],
          ),
        );
      }
      dispose();
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
                        hintText: 'Email',
                        left: 100,
                        right: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputTextField(
                        controller: groupController,
                        hintText: 'Group ID or Group Name',
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
