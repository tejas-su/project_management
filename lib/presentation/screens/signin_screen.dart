import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management/presentation/screens/home_screen.dart';
import 'package:project_management/presentation/widgets/cta_button.dart';
import '../widgets/text_field.dart';
import '../themes/themes.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteBG,
        title: Text(
          'Kraken',
          style: GoogleFonts.libreFranklin(
              fontSize: 35, fontWeight: FontWeight.bold, letterSpacing: 3),
        ),
        titleSpacing: 30,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 600,
              width: 600,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: whiteContainer),
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
                    'Welcome back!',
                    style: GoogleFonts.libreFranklin(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const InputTextField(
                    hintText: 'Group Id or Group Name',
                    left: 150,
                    right: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const InputTextField(
                      left: 150,
                      right: 150,
                      hintText: 'Group Password',
                      obscureText: true),
                  const SizedBox(
                    height: 20,
                  ),
                  CTAButton(
                    text: 'Signin',
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    )),
                    left: 150,
                    right: 150,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "To login, use Email:test@example.comand Password:123456",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
