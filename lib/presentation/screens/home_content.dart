import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'imports.dart';

class HomeContent extends StatefulWidget {
  final SupabaseClient supabase;
  const HomeContent({super.key, required this.supabase});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool selected = false;
  //on tap of list tile event handler
  void onTap(index) {
    setState(() {
      selected = !selected;
    });
  }

  final obj = HelperFunctions();
  @override
  Widget build(BuildContext context) {
    final Storage localStorage = window.localStorage;
    final supabase = Supabase.instance.client;
    var groupName = localStorage['groupName'];
    var selectedprojectname;
    //helpful functions to retrieve project and user details of team that login to website
    HelperFunctions helperFunctions = HelperFunctions();
    return Row(
      children: [
        //
        //Projects section
        //
        Container(
          height: 800,
          width: 350,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              border:
                  Border(right: BorderSide(width: 3, color: whiteContainer))),
          child: FutureBuilder(
              future: helperFunctions.getProjects(
                  context, supabase, groupName.toString(), selectedprojectname),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('');
                } else if (snapshot.hasError) {
                  return AlertDialog(
                    title: const Text("Oops, something went wrong"),
                    content: Text('${snapshot.error}'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("OK"),
                      ),
                    ],
                  );
                } else {
                  final project = snapshot.data;

                  return ListView.builder(
                      itemCount: project!.length,
                      itemBuilder: (context, index) {
                        final projects = project[index];
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 10),
                          child: ListTile(
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusColor: whiteContainer,
                            hoverColor: whiteContainer,
                            autofocus: true,
                            selected: selected,
                            selectedColor: black,
                            selectedTileColor: whiteContainer,
                            //=> onTap(index)
                            onTap: () {
                              setState(() {
                                selected = !selected;
                                selectedprojectname = projects.projectName;
                              });
                              //return show_user();
                            },
                            enabled: true,
                            tileColor: whiteBG,
                            leading: const CircleAvatar(
                                foregroundImage: AssetImage('avatars/man.png')),
                            title: Text('${projects.projectName}'),
                            subtitle: Text(
                              '${projects.projectDescription}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: const IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.edit_rounded,
                                  size: 20,
                                  color: black,
                                )),
                            horizontalTitleGap: 10,
                          ),
                        );
                      });
                }
              }),
        ),
        //
        //Users Section
        //
        Container(
            height: 800,
            width: 350,
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                border:
                    Border(right: BorderSide(width: 3, color: whiteContainer))),
            child: FutureBuilder(
                future: helperFunctions.getUsersForProject(context, supabase,
                    groupName.toString()),
                builder: (context, snapshot) {
                  
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('');
                  } else if (snapshot.hasError) {
                    return AlertDialog(
                      title: const Text("Oops, something went wrong"),
                      content: Text('${snapshot.error}'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  } else {
                    final users = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        
                        return ListTile(
                        leading: CircleAvatar(
                            foregroundImage: AssetImage('avatars/man.png')),
                        title: Text('username'),
                        subtitle: Text(
                          'username@yahoo.com',
                          style: TextStyle(fontSize: 12),
                        ),
                        horizontalTitleGap: 10,
                      );
                      },
                      itemCount: 3,
                    );
                  }
                })),
        //
        //bugs section
        //
        Container(
            height: 800,
            width: 750,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                border:
                    Border(right: BorderSide(width: 3, color: whiteContainer))),
            child: const BugsSection()),
        //
        //comments section
        //
        Container(
          height: 800,
          width: 400,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              border:
                  Border(right: BorderSide(width: 3, color: whiteContainer))),
          child: const CommentsSection(),
        )
      ],
    );
  }
}
