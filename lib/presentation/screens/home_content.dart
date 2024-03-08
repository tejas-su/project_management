import 'package:flutter/material.dart';
import 'package:project_management/models/projects_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'imports.dart';

class HomeContent extends StatefulWidget {
  final SupabaseClient supabase;
  const HomeContent({super.key, required this.supabase});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  //selected project name
  String selectedprojectname = '';

  //user taps on project
  bool selected = false;

  //helpful functions to retrieve project and user details of team that login to website
  HelperFunctions helperFunctions = HelperFunctions();

  final supabase = Supabase.instance.client;

  //on tap of list tile event handler
  void retrieveIndex(BuildContext context, projectname) {
    setState(() {
      selectedprojectname = projectname;
      selected = !selected;
    });
  }

  late String deletingproject = '';
  

 Future<dynamic> deleteproject(selectedproject) async {
  try{
    showDialog(
        context: context,
        builder: (context) => Container(),
      );
    await supabase
      .from('projects')
      .delete()
      .eq('project_name', selectedproject);
  }catch(e){
    // showDialog(

    // );
  }
    
  }

  late String firstproject;

  @override
  Widget build(BuildContext context) {
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
                  context, supabase, selectedprojectname),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('');
                } else if (snapshot.hasError) {
                  return showErrorDialog(context, 'Error in retreiving data');
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
                            onTap: () {
                              retrieveIndex(context, projects.projectName);
                            },
                            //=> onTap(index)
                            enabled: true,
                            tileColor: whiteBG,
                            leading: const CircleAvatar(
                                foregroundImage: AssetImage('avatars/man.png')),
                            title: Text('${projects.projectName}'),
                            subtitle: Text(
                              '${projects.projectDescription}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: Row(
                                children: [
                                  const IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.edit_rounded,
                                        size: 20,
                                        color: black,
                                      )),
                                  IconButton(
                                      onPressed:()=>deleteproject(projects.projectName) ,
                                      icon:const Icon(
                                        Icons.delete_rounded,
                                        size: 20,
                                        color: black,
                                      )),
                                ],
                              ),
                            ),
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
                future: helperFunctions.getUsersForProject(
                    context, supabase, selectedprojectname),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('');
                  } else if (snapshot.hasError) {
                    return showErrorDialog(context, 'Error in retreiving data');
                  } else {
                    final data = snapshot.data;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final userdata = data[index];
                        return ListTile(
                          leading: const CircleAvatar(
                              foregroundImage: AssetImage('avatars/man.png')),
                          title: Text('${userdata.username}'),
                          subtitle: Text(
                            '${userdata.userDesignation}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          horizontalTitleGap: 10,
                        );
                      },
                      itemCount: data!.length,
                    );
                  }
                })),
        //
        //bugs section
        //
        Container(
            height: 800,
            width: 700,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                border:
                    Border(right: BorderSide(width: 3, color: whiteContainer))),
            child: BugsSection(
              projectname: selectedprojectname,
            )),
      ],
    );
  }
  
}
