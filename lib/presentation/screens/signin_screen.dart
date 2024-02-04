import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management/presentation/screens/home_screen.dart';
import '../widgets/cta_button.dart';
import '../widgets/text_field.dart';
import '../themes/themes.dart';

class SignInScreen extends StatelessWidget {
  final Function()? onTap;
  const SignInScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    //user controller
    TextEditingController userController = TextEditingController();
    //group controller
    TextEditingController groupController = TextEditingController();
    //password controller
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                    'images/bg.png',
                    fit: BoxFit.fitHeight,
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 650,
                decoration: const BoxDecoration(
                    color: whiteContainer,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Image(
                        image: AssetImage('avatars/man.png'),
                        height: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Kraken',
                      style: GoogleFonts.libreFranklin(
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
                      text: 'Sign in',
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      )),
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
                          onTap: onTap,
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
