import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_management/models/users_model.dart';
import 'package:project_management/presentation/screens/imports.dart';
import 'package:project_management/presentation/screens/loading_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../themes/themes.dart';

class UsersSection extends StatefulWidget {
  const UsersSection({super.key});

  @override
  State<UsersSection> createState() => _UsersSectionState();
}

class _UsersSectionState extends State<UsersSection> {
  @override
  Widget build(BuildContext context) {
    

    List images = [
      "assets/avatars/man (1).png",
      "assets/avatars/man (2).png",
      "assets/avatars/man (3).png",
      "assets/avatars/man (4).png",
      "assets/avatars/man (5).png",
    ];

    // Future<List<Map<String, dynamic>>> fetchUserAndProjectsData() async{
      final supabase = Supabase.instance.client;

    //   //select users and project table
    //   final result = await  supabase.from('users').select('username, user_designation').leftJoin('projects', on 'user_id = projects.user_id').select('projects.name as project_name');
    // }

    
    return FutureBuilder(
        future: supabase.from('users').select(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Lottie.asset('lottie/ani1.json', height: 500);
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
            final data = snapshot.data as List<dynamic>;
            return GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3,
                  crossAxisCount: 3,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final userdata = data[index] as Map<String, dynamic>;
                  return Card(
                    elevation: 0.2,
                    color: whiteContainer,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 4, bottom: 2),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Image.asset(
                                images[Random().nextInt(5)],
                              ),
                            ),
                            title: Text(userdata['user_name']),
                            subtitle: Text(userdata['user_email']),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 25, bottom: 2),
                          child: Text("Team : ${userdata['team_name']}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 25, bottom: 2),
                          child: Text('User designation : ${userdata['user_designation']}'),
                        )
                      ],
                    ),
                  );
                });
          }
        });
  }
}
