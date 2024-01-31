import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: ListView.builder(
        itemBuilder: (context, index) => const ListTile(
          leading: CircleAvatar(foregroundImage: AssetImage('avatars/man.png')),
          title: Text('tejas.s.u_'),
          subtitle: Text(
            'tejas_s.u@yahoo.com',
            style: TextStyle(fontSize: 12),
          ),
          horizontalTitleGap: 10,
        ),
        itemCount: 3,
      ),
    );
  }
}
