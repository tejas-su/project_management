import 'dart:math';

import 'package:flutter/material.dart';

import '../themes/themes.dart';

class UsersSection extends StatelessWidget {
  const UsersSection({super.key});

  @override
  Widget build(BuildContext context) {
    List images = [
      "assets/avatars/man (1).png",
      "assets/avatars/man (2).png",
      "assets/avatars/man (3).png",
      "assets/avatars/man (4).png",
      "assets/avatars/man (5).png",
    ];
    return GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3,
          crossAxisCount: 3,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0.2,
            color: whiteContainer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 4, bottom: 2),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Image.asset(
                        images[Random().nextInt(5)],
                      ),
                    ),
                    title: const Text("Abhay B Prabhu"),
                    subtitle: const Text("team lead"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25, bottom: 2),
                  child: Text("Team : Kraken"),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 25, bottom: 2),
                  child: Text("Project : Lady_Bug"),
                )
              ],
            ),
          );
        });
  }
}
