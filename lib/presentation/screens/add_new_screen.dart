import 'package:flutter/material.dart';
import 'package:project_management/presentation/widgets/text_field.dart';
import '../themes/themes.dart';

class AddNewScreen extends StatelessWidget {
  const AddNewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 30),
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            alignment: Alignment.topLeft,
            width: 1360,
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 32, left: 32, bottom: 32),
                    child: Text(
                      "User Details",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InputTextField(
                    hintText: 'Enter User Name',
                    color: whiteContainer,
                    bottom: 32,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Enter User Email',
                    color: whiteContainer,
                    bottom: 32,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Enter User Designation',
                    color: whiteContainer,
                    bottom: 32,
                    left: 32,
                    right: 700,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 32, left: 32, bottom: 32),
                    child: Text(
                      "Project Details",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InputTextField(
                    hintText: 'Enter Project Name',
                    color: whiteContainer,
                    bottom: 32,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Enter Project Description',
                    color: whiteContainer,
                    bottom: 32,
                    left: 32,
                    right: 200,
                    maxLines: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 32.0),
                    child: Text(
                      "Bug Details",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InputTextField(
                    hintText: 'Enter Bug Title',
                    color: whiteContainer,
                    bottom: 32,
                    left: 32,
                    right: 700,
                  ),
                  InputTextField(
                    hintText: 'Enter Bug Description',
                    color: whiteContainer,
                    bottom: 32,
                    left: 32,
                    right: 200,
                    maxLines: 10,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
