import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_management/presentation/screens/home_screen.dart';
import 'presentation/themes/themes.dart';
import 'presentation/screens/signin_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Project Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: whiteBG,
        useMaterial3: true,
      ),
      home: const SignInScreen(),
      // home: const HomeScreen(),
    );
  }
}

//for scroll view on pc we use this one, more details on pub dev
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}
