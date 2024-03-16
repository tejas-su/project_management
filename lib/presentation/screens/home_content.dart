// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../app.dart';
import 'imports.dart';

class HomeContent extends StatefulWidget {
  final SupabaseClient supabase;
  const HomeContent({super.key, required this.supabase});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final Storage localStorage = window.localStorage;

  //selected project name
  String selectedprojectname = '';

  //user taps on project
  bool selected = false;

  //helpful functions to retrieve project and user details of team that login to website
  HelperFunctions helperFunctions = HelperFunctions();

  final supabase = Supabase.instance.client;
  int selectedIndex = -1;
  //on tap of list tile event handler
  void retrieveIndex(BuildContext context, projectname, index) {
    setState(() {
      selectedprojectname = projectname;
      selectedIndex = index;
    });
  }

  //update user function
  void updateProject(
      projectName, projectDescription, BuildContext context, supabase) {
    TextEditingController projectcontroller =
        TextEditingController(text: projectName);
    TextEditingController projectDescriptionController =
        TextEditingController(text: projectDescription);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: 500,
          height: 460,
          child: Column(
            children: [
              Text(
                "Team $groupName currently working on $projectName",
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              InputTextField(
                left: 0,
                right: 0,
                hintText: 'Project',
                controller: projectcontroller,
              ),
              const SizedBox(height: 20),
              InputTextField(
                left: 0,
                right: 0,
                hintText: 'Project Description',
                controller: projectDescriptionController,
              ),
              const SizedBox(height: 20),
              const SizedBox(
                height: 25,
              ),
              CTAButton(
                text: 'Save',
                onTap: () async {
                  try {
                    await supabase.from('projects').upsert({
                      'project_name': projectcontroller.text.toString(),
                      'project_description':
                          projectDescriptionController.text.toString(),
                    });
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Update user error: $e');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  late String deletingproject = '';

  Future<dynamic> deleteproject(selectedproject) async {
    try {
      showDialog(
        context: context,
        builder: (context) => Container(
          color: whiteBG,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('lottie/ani1.json', height: 500),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Crunching your data, this might take some time',
                style: GoogleFonts.dmSerifDisplay(
                    fontWeight: FontWeight.w500, fontSize: 25),
              )
            ],
          ),
        ),
      );
      await supabase
          .from('projects')
          .delete()
          .eq('project_name', selectedproject);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoadingScreen(
            screen: HomeScreen(
              supabase: widget.supabase,
            ),
            supabase: widget.supabase,
          ),
        ),
      );
    } catch (e) {
      // showDialog(

      // );
    }
  }

  late String deletingUser = '';

  Future<dynamic> deleteUser(selectedUser) async {
    try {
      showDialog(
        context: context,
        builder: (context) => Container(
          color: whiteBG,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('lottie/ani1.json', height: 500),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Crunching your data, this might take some time',
                style: GoogleFonts.dmSerifDisplay(
                    fontWeight: FontWeight.w500, fontSize: 25),
              )
            ],
          ),
        ),
      );
      await supabase.from('users').delete().eq('user_name', selectedUser);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoadingScreen(
            screen: HomeScreen(
              supabase: widget.supabase,
            ),
            supabase: widget.supabase,
          ),
        ),
      );
    } catch (e) {
      // showDialog(

      // );
    }
  }


  void updateUser(projectName, name, userDesignation, userName, userEmail,
      BuildContext context) {
    TextEditingController userController =
        TextEditingController(text: userName);
    TextEditingController userDesignationController =
        TextEditingController(text: userDesignation);
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController emailController =
        TextEditingController(text: userEmail);
    TextEditingController projectController =
        TextEditingController(text: projectName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update User Details'),
        content: SizedBox(
          width: 500,
          height: 460,
          child: Column(
            children: [
              const SizedBox(height: 20),
              InputTextField(
                left: 0,
                right: 0,
                hintText: 'Project',
                controller: projectController,
              ),
              const SizedBox(height: 20),
              InputTextField(
                left: 0,
                right: 0,
                hintText: 'Username',
                controller: userController,
              ),
              const SizedBox(height: 20),
              InputTextField(
                left: 0,
                right: 0,
                hintText: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 20),
              InputTextField(
                left: 0,
                right: 0,
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 20),
              InputTextField(
                left: 0,
                right: 0,
                hintText: 'Designation',
                controller: userDesignationController,
              ),
              const SizedBox(
                height: 25,
              ),
              CTAButton(
                text: 'Save',
                onTap: () async {
                  try {
                    await widget.supabase.from('users').upsert({
                      'name': userController.text.toString(),
                      'user_name': nameController.text.toString(),
                      'user_designation':
                          userDesignationController.text.toString(),
                      'user_email': emailController.text.toString(),
                      'project_name': projectController.text.toString(),
                    });
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Update user error: $e');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        //Projects section
        //
        Container(
          height: 800,
          width: 400,
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
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return showErrorDialog(context, 'Error in retreiving data');
                } else if (snapshot.data!.isEmpty) {
                  return ListTile(
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusColor: whiteContainer,
                    hoverColor: whiteContainer,
                    autofocus: true,
                    selected: selected,
                    selectedColor: black,
                    selectedTileColor: whiteContainer,
                    tileColor: whiteBG,
                    leading: const CircleAvatar(
                        child: Text('😒', style: TextStyle(fontSize: 30))),
                    title: const Text(
                      'Add a project',
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final project = snapshot.data;

                  return ListView.builder(
                      itemCount: project!.length,
                      itemBuilder: (context, index) {
                        final projects = project[index];
                        localStorage['firstProject'] =
                            projects.projectName.toString();
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
                            selected: selectedIndex == index,
                            selectedColor: black,
                            selectedTileColor: whiteContainer,
                            onTap: () {
                              retrieveIndex(
                                  context, projects.projectName, index);
                              localStorage['projectName'] =
                                  projects.projectName.toString();
                            },
                            enabled: true,
                            tileColor: whiteBG,
                            leading: const CircleAvatar(
                                foregroundImage: AssetImage('avatars/man.png')),
                            title: Text('${projects.projectName}'),
                            subtitle: Text(
                              maxLines: 2,
                              '${projects.projectDescription}...',
                              softWrap: true,
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () => updateProject(
                                          projects.projectName,
                                          projects.projectDescription,
                                          context,
                                          supabase),
                                      icon: const Icon(
                                        Icons.edit_rounded,
                                        size: 20,
                                        color: black,
                                      )),
                                  IconButton(
                                      onPressed: () =>
                                          deleteproject(projects.projectName),
                                      icon: const Icon(
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
                } else {
                  return Text('');
                }
              }),
        ),
        //
        //Users Section
        //
        Container(
          height: 800,
          width: 400,
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              border:
                  Border(right: BorderSide(width: 3, color: whiteContainer))),
          child: FutureBuilder(
            future: helperFunctions.getUsersForProject(
                context, supabase, selectedprojectname),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return showErrorDialog(context, 'Error in retreiving data');
              } else if (snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusColor: whiteContainer,
                    hoverColor: whiteContainer,
                    autofocus: true,
                    selected: selected,
                    selectedColor: black,
                    selectedTileColor: whiteContainer,
                    enabled: true,
                    tileColor: whiteBG,
                    leading: const CircleAvatar(
                        child: Text('😒', style: TextStyle(fontSize: 30))),
                    title: const Text(
                      'Add a user',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final data = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final userdata = data[index];
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10),
                        child: ListTile(
                          selectedColor: black,
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          selected: true,
                          selectedTileColor: whiteContainer,
                          leading: const CircleAvatar(
                              foregroundImage: AssetImage('avatars/man.png')),
                          title: Text('${userdata.name}'),
                          subtitle: Text(
                            '${userdata.userDesignation}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          horizontalTitleGap: 10,
                          trailing: SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => updateUser(
                                        userdata.projectName,
                                        userdata.name,
                                        userdata.userDesignation,
                                        userdata.userName,
                                        userdata.userEmail,
                                        context),
                                    icon: const Icon(
                                      Icons.edit_rounded,
                                      size: 20,
                                      color: black,
                                    )),
                                IconButton(
                                    onPressed: () =>
                                        deleteUser(userdata.userName),
                                    icon: const Icon(
                                      Icons.delete_rounded,
                                      size: 20,
                                      color: black,
                                    )),
                              ],
                            ),
                          ),
                        ));
                  },
                  itemCount: data!.length,
                );
              } else {
                return const Text('');
              }
            },
          ),
        ),
        //
        //bugs section
        //
        Container(
            height: 800,
            width: 770,
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
