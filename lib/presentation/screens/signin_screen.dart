import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BugsDB',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
        ),
        titleSpacing: 20,
      ),
    );
  }
}
