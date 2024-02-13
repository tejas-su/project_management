import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_management/presentation/screens/mobile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'presentation/themes/themes.dart';
import 'services/auth_changes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Supabase.initialize(
  //   url: url,
  //   anonKey: anonKey,
  // );
  // final response =
  //     await Supabase.instance.client.from('users').select().select();
  // print(response);
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Shrine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: whiteBG,
        useMaterial3: true,
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (width > 1260) {
            return const AuthChanges();
          } else {
            return const MobileScreen();
          }
        },
      ),
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
