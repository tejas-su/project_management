import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management/presentation/screens/home_screen.dart';
import '../widgets/cta_button.dart';
import '../widgets/text_field.dart';
import '../themes/themes.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: whiteBG,
      //   title: Text(
      //     'Kraken',
      //     style: GoogleFonts.libreFranklin(
      //         fontSize: 35, fontWeight: FontWeight.bold, letterSpacing: 3),
      //   ),
      //   titleSpacing: 30,
      // ),
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
                      height: 50,
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
                    const InputTextField(
                      hintText: 'Group Id or Group Name',
                      left: 100,
                      right: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const InputTextField(
                        left: 100,
                        right: 100,
                        hintText: 'Group Password',
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
                    const Text(
                      "To login, use Email:test@example.com Password:123456",
                      style: TextStyle(fontSize: 10),
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
