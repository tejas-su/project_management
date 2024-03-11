import 'package:flutter/material.dart';
import 'package:project_management/presentation/components/users_section.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'presentation/screens/imports.dart';

class HomeScreen extends StatefulWidget {
  final SupabaseClient supabase;

  const HomeScreen({
    super.key,
    required this.supabase,
  });

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

  void signOutUser() async {
    await widget.supabase.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    //retrieve the group name from the local storage
    // final Storage localStorage = window.localStorage;
    // String? groupName = localStorage['groupName'].toString();
    //List of screens
    List screens = [
      HomeContent(
        supabase: widget.supabase,
      ),
      CommentsSection(
        supabase: widget.supabase,
      ),
      const UsersSection(),
      const ProjectsScreen(),
      SearchScreen(supabase: widget.supabase),
      AddNewScreen(
        supabase: widget.supabase,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(width: 2, color: whiteBG)),
        backgroundColor: whiteContainer,
        title: Text(
          'Shrine',
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleSpacing: 25,
        automaticallyImplyLeading: false,
        actions: [
          //refresh button
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoadingScreen(
                      text: 'Crunching your data, This might take some time 😴',
                      screen: HomeScreen(
                        supabase: widget.supabase,
                      ),
                      supabase: widget.supabase,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.refresh,
                color: black,
              )),
          //Sign out button
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: IconButton(
                onPressed: () {
                  signOutUser();
                  //move back to the auth changes
                  print('Signed out sucessfully');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AuthChanges(
                      supabase: widget.supabase,
                    ),
                  ));
                },
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
              selectedIndex: selectedIndex,
              leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundImage: AssetImage('images/building.png')),
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
                    icon: Icon(Icons.chat_bubble_rounded),
                    label: Text('Comments')),
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
            ),
            screens[selectedIndex],
          ],
        ),
      ),
    );
  }
}
