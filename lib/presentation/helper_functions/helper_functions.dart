import 'dart:html';
import 'package:flutter/material.dart';
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

//retrieve the group name from local storage
final Storage localStorage = window.localStorage;
var groupName = localStorage['groupName'];

class HelperFunctions {
  Future getProjects(BuildContext context, SupabaseClient supabase) async {
    try {
      final response =
          await supabase.from('projects').select().eq('team_name', 'team 1');

      if (response.isEmpty) {
        showErrorDialog(
            context, 'Sorry Something went wrong while fetching the data');
      }
      print("\n\n The response for the team : $response");
      return response.toList();
    } catch (error) {
      showErrorDialog(context, error.toString());
    }
  }
}
