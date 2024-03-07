import 'dart:html';
import 'package:flutter/material.dart';
import 'package:project_management/models/projects_model.dart';
import 'package:project_management/models/users_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

//final Storage localStorage = window.localStorage;
//var groupName = localStorage['groupName'];

class HelperFunctions {
  Future<List<project>> getProjects(BuildContext context,
      SupabaseClient supabase,groupname, selectedprojectname) async {
    try {
      //teamname is name of team that login into website so to fetch corresponding teams details
      final response = await supabase
          .from('projects')
          .select()
          .eq('team_name', 'group1')
          .order('project_name');

      final projects =
          (response as List).map((json) => project.fromJson(json)).toList(); 

      if (response.isEmpty) {
        showErrorDialog(
            context, 'Sorry Something went wrong while fetching the data');
      }
      print("\n\n The response for the team : $response");
      return projects;
    } catch (error) {
      showErrorDialog(context, error.toString());
      return [];
    }
  }

Future<List<users>> getUsersForProject(
      BuildContext context, SupabaseClient supabase, String selectedprojectname) async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('project_name', 'project4')
          .order('user_name');

      final project_users = (response as List)
          .map((json) => users.fromJson(json))
          .toList();

      return project_users;
    } catch (error) {
      showErrorDialog(context, error.toString());
      return [];
    }
  }
}

