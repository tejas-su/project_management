import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_management/presentation/screens/mobile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/api_keys.dart';
import 'presentation/themes/themes.dart';
import 'services/auth_changes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: url,
    anonKey: anonKey,
  );
  final supabase = Supabase.instance.client;
  runApp(MyApp(
    supabase: supabase,
  ));
}

class MyApp extends StatelessWidget {
  final SupabaseClient supabase;
  const MyApp({super.key, required this.supabase});

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
            return AuthChanges(
              supabase: supabase,
            );
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
