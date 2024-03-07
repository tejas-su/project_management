// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'imports.dart';

class AddNewScreen extends StatefulWidget {
  final SupabaseClient supabase;
  const AddNewScreen({super.key, required this.supabase});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  @override
  Widget build(BuildContext context) {
    //project name controller
    TextEditingController projectName = TextEditingController();
    //project description controller
    TextEditingController projectDesc = TextEditingController();
    //user name controller
    TextEditingController userName = TextEditingController();
    TextEditingController name = TextEditingController();
    //user email controller
    TextEditingController userEmail = TextEditingController();
    //user designation controller
    TextEditingController userDesig = TextEditingController();
    //bugs name controller
    TextEditingController bugName = TextEditingController();
    //bug status controller
    TextEditingController bugStatus = TextEditingController();
    //bugs description controller
    TextEditingController bugsDesc = TextEditingController();
    //function to dispose the text editing controller

    void dispose() {
      projectName.clear();
      projectDesc.clear();
      userName.clear();
      userEmail.clear();
      userDesig.clear();
      name.clear();
      bugName.clear();
      bugsDesc.clear();
    }

    //fetch the date
    DateTime now = DateTime.now();
    //formatted date in the format dd-mm-yyyy
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    //pull the team name from the cache
    final Storage localStorage = window.localStorage;
    var groupName = localStorage['groupName'];
    //width of the screen
    double width = MediaQuery.of(context).size.width;
    //Text Controllers for varios fields

    //function to show error message
    void showErrorDialog(
      BuildContext context,
      String title,
      String message,
    ) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }

    //function to save the data to the database
    //first fetch the team name from the local cache then add the projects as the team name is the primary key
    //fetch the project name then add other details as the project name is the primary key
    void saveProject() async {
      try {
        if (projectName.text.isEmpty ||
            projectDesc.text.isEmpty ||
            userDesig.text.isEmpty ||
            userName.text.isEmpty ||
            userEmail.text.isEmpty ||
            bugName.text.isEmpty ||
            bugStatus.text.isEmpty) {
          showErrorDialog(
            context,
            'Oops, something went wrong',
            'Please fill in all the fields',
          );
        } else {
          //show loading screen
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
                    'Saving your data, this might take some time',
                    style: GoogleFonts.dmSerifDisplay(
                        fontWeight: FontWeight.w500, fontSize: 25),
                  )
                ],
              ),
            ),
          );
          var presponse = await widget.supabase.from('projects').insert({
            'project_name': projectName.text,
            'date_created': formattedDate,
            'team_name': groupName,
            'project_description': projectDesc.text
          }).select();
          var uresponse = await widget.supabase.from('users').insert({
            'user_name': userName.text,
            'user_designation': userDesig.text,
            'user_email': userEmail.text,
            'project_name': projectName.text,
            'name': userName.text,
          }).select();
          var bresponse = await widget.supabase.from('bugs').insert({
            'bugs_name': bugName.text,
            'bug_status': bugStatus.text,
            'bugs_description': bugsDesc.text,
            'project_name': projectName.text,
            'date_created': formattedDate,
          }).select();

          //clear the text fields after saving
          dispose();
          //pop the loading screen after loading

          Navigator.of(context).pop();
          if (presponse.isNotEmpty ||
              uresponse.isNotEmpty ||
              bresponse.isNotEmpty) {
            showErrorDialog(context, 'Successfully added your project 🥳',
                'Happy Coding, Don\'t forget to squash those bugs');
          } else {
            showErrorDialog(context, 'Oops something went wrong 😭',
                'Make sure you have an active internet connection');
          }
        }
      } catch (e) {
        showErrorDialog(context, "Oops, something went wrong", e.toString());
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 30),
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            alignment: Alignment.topLeft,
            width: 1360,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 32, left: 32, bottom: 0),
                    child: Text(
                      "Team: $groupName",
                      style: GoogleFonts.dmSerifDisplay(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //Project details starts from here
                  const Padding(
                    padding: EdgeInsets.only(top: 25, left: 32, bottom: 30),
                    child: Text(
                      "Project Details",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InputTextField(
                    controller: projectName,
                    hintText: 'Enter Project Name',
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 0, left: 35, bottom: 10),
                    child: Text(
                      'Creation Date: $formattedDate',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  InputTextField(
                    hintText: 'Enter Project Description',
                    controller: projectDesc,
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 200,
                    maxLines: 10,
                  ),
                  //User details starts from here
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 32, bottom: 30),
                    child: Text(
                      "User Details",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  InputTextField(
                    hintText: 'Your Name',
                    controller: name,
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Enter User Name',
                    controller: userName,
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Enter User Email',
                    color: whiteContainer,
                    controller: userEmail,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Enter User Designation',
                    controller: userDesig,
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  //bug details starts from here
                  const Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Text(
                      "Bug Details",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputTextField(
                    controller: bugName,
                    hintText: 'Short Description or ID',
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Bug Status',
                    controller: bugStatus,
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Long Description',
                    color: whiteContainer,
                    controller: bugsDesc,
                    bottom: 20,
                    left: 32,
                    right: 200,
                    maxLines: 10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CTAButton(
                    text: 'Save',
                    onTap: saveProject,
                    left: 32,
                    right: width / 1.3,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
