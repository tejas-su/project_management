import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
    Future<void> registerUser() async {
      try {
        final AuthResponse res = await widget.supabase.auth.signUp(
          email: 'test@example.com',
          password: 'test123',
        );
        print(res);
      } catch (e) {
        print(e);
      }
    }

    //user controller
    TextEditingController userController = TextEditingController();
    //group controller
    TextEditingController passwordController = TextEditingController();
    //password controller
    TextEditingController groupController = TextEditingController();
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
                        controller: userController,
                        hintText: 'Username or Email',
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
