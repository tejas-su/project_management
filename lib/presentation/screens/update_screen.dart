// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_management/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'imports.dart';

class UpdateScreen extends StatefulWidget {
  final SupabaseClient supabase;
  final String projectDescription;
  final String primaryKey;

  const UpdateScreen(
      {super.key,
      required this.supabase,
      required this.primaryKey,
      required this.projectDescription});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController projectName =
        TextEditingController(text: widget.primaryKey);

    TextEditingController projectDesc =
        TextEditingController(text: widget.projectDescription);

    TextEditingController userName = TextEditingController();
    TextEditingController name = TextEditingController();

    TextEditingController userEmail = TextEditingController();

    TextEditingController userDesig = TextEditingController();

    TextEditingController bugName = TextEditingController();

    TextEditingController bugStatus = TextEditingController();

    TextEditingController bugsDesc = TextEditingController();

    //fetch the date
    DateTime now = DateTime.now();
    //formatted date in the format dd-mm-yyyy
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    //pull the team name from the cache
    final Storage localStorage = window.localStorage;
    var groupName = localStorage['groupName'];

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

    //function to update the data to the database
    void updateUser() async {
      try {
        if (userDesig.text.isEmpty ||
            userName.text.isEmpty ||
            userEmail.text.isEmpty) {
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
              child: Container(
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
            ),
          );
          //update user
          var uresponse = await widget.supabase.from('users').upsert({
            'user_name': userName.text,
            'user_designation': userDesig.text,
            'user_email': userEmail.text,
            'project_name': projectName.text,
            'name': userName.text,
          }).select();
          //pop the loading screen after loading

          Navigator.of(context).pop();
          if (uresponse.isNotEmpty) {
            showErrorDialog(context, 'Successfully added the user 🥳', '');
          } else {
            showErrorDialog(context, 'Oops something went wrong 😭',
                'Make sure you have an active internet connection');
          }
        }
      } catch (e) {
        showErrorDialog(context, 'Oops something went wrong 😭', '$e');
      }
    }

    void updateProject() async {
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
          await widget.supabase.from('projects').update({
            'project_name': projectName.text,
            'date_created': formattedDate,
            'team_name': groupName,
            'project_description': projectDesc.text
          }).select();
          await widget.supabase.from('users').update({
            'user_name': userName.text,
            'user_designation': userDesig.text,
            'user_email': userEmail.text,
            'project_name': projectName.text,
            'name': userName.text,
          }).select();
          var bresponse = await widget.supabase.from('bugs').update({
            'bugs_name': bugName.text,
            'bug_status': bugStatus.text,
            'bugs_description': bugsDesc.text,
            'project_name': projectName.text,
            'update_date': formattedDate,
          }).select();

          //pop the loading screen after loading

          Navigator.of(context).pop();
          if (bresponse.isNotEmpty) {
            showErrorDialog(context, 'Successfully added 🥳',
                'Don\'t forget to squash those bugs');
          } else {
            showErrorDialog(context, 'Oops something went wrong 😭',
                'Make sure you have an active internet connection');
          }
        }
      } catch (e) {
        showErrorDialog(context, 'Oops something went wrong 😭', '$e');
      }
    }

//update or insert the project if it does not exist
    void UpdateProject() async {
      try {
        if (projectName.text.isEmpty || projectDesc.text.isEmpty) {
          showErrorDialog(
            context,
            'Did you forget to fill in the project name! 🤔',
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
          var presponse = await widget.supabase.from('projects').upsert({
            'project_name': projectName.text,
            'date_created': formattedDate.toString(),
            'team_name': groupName,
            'project_description': projectDesc.text
          }).select();

          //clear the text fields after saving
          dispose();
          //pop the loading screen after loading

          Navigator.of(context).pop();
          if (presponse.isNotEmpty ||
              presponse.isNotEmpty ||
              presponse.isNotEmpty) {
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

    return Scaffold(
      backgroundColor: whiteBG,
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoadingScreen(
                    supabase: widget.supabase,
                    screen: HomeScreen(
                      supabase: widget.supabase,
                    )),
              ));
            },
            icon: const Icon(Icons.fork_left_rounded)),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 32, bottom: 0),
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
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.only(top: 0, left: 35, bottom: 10),
            child: Text(
              'Updation Date: $formattedDate',
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
          CTAButton(
            text: 'Save',
            onTap: updateProject,
            left: 32,
            right: width * 1 / 1.3,
          ),
          const SizedBox(
            height: 20,
          ),
          //User details starts from here
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 32, bottom: 30),
            child: Text(
              "User Details",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
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
          CTAButton(
            text: 'Save',
            onTap: updateUser,
            // left: 32,
            // right: width*1/3,
          ),
          //bug details starts from here
          const Padding(
            padding: EdgeInsets.only(left: 32.0),
            child: Text(
              "Bug Details",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
          const CTAButton(
            text: 'Save',
            onTap: null,
            // left: 32,
            // right: width*1/3,
          ),
          const SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}
