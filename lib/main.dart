import 'package:flutter/material.dart';
import 'presentation/themes/themes.dart';
import 'presentation/screens/signin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: whiteBG,
        useMaterial3: true,
      ),
      home: const SignInScreen(),
    );
  }
}
