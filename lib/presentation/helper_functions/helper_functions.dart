// ignore_for_file: non_constant_identifier_names

import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:project_management/models/bugs_model.dart';
import 'package:project_management/models/chats_model.dart';
import 'package:project_management/models/projects_model.dart';
import 'package:project_management/models/users_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

showErrorDialog(BuildContext context, String message) {
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

//retrieve the group name from local storage
final Storage localStorage = window.localStorage;
var groupName = localStorage['groupName'];

//retrieve the selected project name from local storage
var projectName = localStorage['projectName'];

class HelperFunctions {
  Future<List<project>> getProjects(BuildContext context,
      SupabaseClient supabase, selectedprojectname) async {
    try {
      //groupName is name of team that login into website so to fetch corresponding teams details
      final response = await supabase
          .from('projects')
          .select('*')
          .eq('team_name', '$groupName')
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

  Future<List<users>> getUsersForProject(BuildContext context,
      SupabaseClient supabase, selectedprojectname) async {
    //Default:To fetch first project name  and its details
    var projects = await getProjects(context, supabase, selectedprojectname);
    var firstProject = projects[0];
    String firstProjectName = firstProject.projectName.toString();

    //Selecting the project name to fetch its users
    final String projectname =
        selectedprojectname.isEmpty ? firstProjectName : selectedprojectname;
    try {
      print(
          'The retrieved project name from the home content: $selectedprojectname');
      final response = await supabase
          .from('users')
          .select()
          .eq('project_name', projectname)
          .order('user_name');

      final project_users =
          (response as List).map((json) => users.fromJson(json)).toList();
      return project_users;
    } catch (error) {
      showErrorDialog(context, error.toString());
      return [];
    }
  }

  Future<List<bugs>> getBugsForProject(
    BuildContext context,
    SupabaseClient supabase,
    String selectedprojectname,
  ) async {
    //Default:To fetch first project name  and its details
    var projects = await getProjects(context, supabase, selectedprojectname);
    var firstProject = projects[0];
    String firstProjectName = firstProject.projectName.toString();

    //Selecting the project name to fetch its users
    final String finalprojectname =
        selectedprojectname.isEmpty ? firstProjectName : selectedprojectname;
    try {
      final response = await supabase
          .from('bugs')
          .select()
          .eq('project_name', finalprojectname)
          .order('bugs_name');

      final project_bugs =
          (response as List).map((json) => bugs.fromJson(json)).toList();
      return project_bugs;
    } catch (error) {
      showErrorDialog(context, error.toString());
      return [];
    }
  }

  //chat retrieval function
  Future<List<chats_model>> getChats(
    BuildContext context,
    SupabaseClient supabase,
    String selectedprojectname,
  ) async {
    //Default:To fetch first project name  and its details
    var projects = await getProjects(context, supabase, selectedprojectname);
    var firstProject = projects[0];
    String firstProjectName = firstProject.projectName.toString();

    //Selecting the project name to fetch its users
    final String finalprojectname =
        selectedprojectname.isEmpty ? firstProjectName : selectedprojectname;
    try {
      final response = await supabase
          .from('chats')
          .select()
          .eq('project_name', finalprojectname)
          .order('date');

      final project_chats =
          (response as List).map((json) => chats_model.fromJson(json)).toList();
      return project_chats;
    } catch (error) {
      showErrorDialog(context, error.toString());
      return [];
    }
  }

  //Function to search a term in project table
  Future<List<project>> searchInProjectTable(
    var column1,
    String tableName,
    String query,
    BuildContext context,
    SupabaseClient supabase,
  ) async {

    //using fetched first project name  from local storage as default search
    //if query is empty by default search for first project
    final searchquery = query.isEmpty ? projectName : query;

    //var column1 = project_name.toString();
    //var column2 = 'team_name';
    //var column3 = 'project_description';
    try {
      final response = await supabase.from(tableName).select().or((builder) => builder
            ..ilike(column1, searchquery) as String
            // ..ilike(column2, '%$searchquery%').toString()
            // ..ilike(column3, '%$searchquery%').toString()
        );
      //       // Specify the columns you want to search across
      //       builder.ilike(column1.toString(), '%$searchquery%');
      //       builder.ilike(column2.toString(), '%$searchquery%'); //format - '%$query%'
      //       builder.ilike(column3.toString(), '%$searchquery%');
      //       // Add more columns as needed
      //     }.toString() );




      final chatresponse =
          (response.first as List).map((json) => project.fromJson(json)).toList();
      // .execute();

      // if (response.) {
      //   throw Exception('Error searching in  table: $pres');
      // }
      return chatresponse; //as List<project>
    } catch (error) {
      showErrorDialog(context, error.toString());
      //Navigator.of(context).pop();
      return [];
    }
  }
}
