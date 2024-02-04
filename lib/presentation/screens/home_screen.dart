import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/add_new_screen.dart';
import '../screens/home_content.dart';
import '../screens/projects_screen.dart';
import '../screens/search_screen.dart';
import 'users_screen.dart';
import '../themes/themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  //function for updating the index of the navigation rail
  void onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  //List of screens
  List screens = const [
    HomeContent(),
    UsersScreen(),
    ProjectsScreen(),
    SearchScreen(),
    AddNewScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(width: 2, color: whiteBG)),
        backgroundColor: whiteContainer,
        title: Text(
          'Kraken',
          style: GoogleFonts.libreFranklin(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 25,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  color: black,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            //
            //Navigation Rail
            //
            NavigationRail(
              indicatorColor: black,
              selectedIconTheme: const IconThemeData(color: whiteBG),
              indicatorShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: whiteContainer,
              onDestinationSelected: onDestinationSelected,
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.home_rounded), label: Text('Home')),
                NavigationRailDestination(
                    icon: Icon(Icons.person_rounded), label: Text('Users')),
                NavigationRailDestination(
                    icon: Icon(Icons.newspaper_rounded),
                    label: Text('Projects')),
                NavigationRailDestination(
                    icon: Icon(Icons.search_rounded), label: Text('Search')),
                NavigationRailDestination(
                    icon: Icon(Icons.add_rounded), label: Text('Add projects')),
              ],
              selectedIndex: selectedIndex,
              leading: const CircleAvatar(
                  foregroundImage: AssetImage('avatars/man.png')),
            ),
            screens[selectedIndex],
          ],
        ),
      ),
    );
  }
}
