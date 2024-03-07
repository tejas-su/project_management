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
    //project name controller
    TextEditingController projectName = TextEditingController();
    //project description controller
    TextEditingController projectDesc = TextEditingController();
    //user name controller
    TextEditingController userName = TextEditingController();
    //user email controller
    TextEditingController puserEmail = TextEditingController();
    //user designation controller
    TextEditingController userDesig = TextEditingController();
    //function to show error message
    void showErrorDialog(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Oops, something went wrong"),
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
        var response = await widget.supabase.from('projects').insert({
          'project_name': projectName.text,
          'date_created': formattedDate,
          'team_name': groupName,
          'project_description': projectDesc.text
        });
        print(response);
      } catch (e) {
        showErrorDialog(context, e.toString());
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
                  const InputTextField(
                    hintText: 'Enter User Name',
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  const InputTextField(
                    hintText: 'Enter User Email',
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  const InputTextField(
                    hintText: 'Enter User Designation',
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
                  const InputTextField(
                    hintText: 'Short Description or ID',
                    color: whiteContainer,
                    bottom: 20,
                    left: 32,
                    right: 700,
                  ),
                  const InputTextField(
                    hintText: 'Enter Bug Description',
                    color: whiteContainer,
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
