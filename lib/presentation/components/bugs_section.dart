import 'package:flutter/material.dart';

import '../themes/themes.dart';

class BugsSection extends StatelessWidget {
  const BugsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => const ListTile(
          title: Text('Bugs sections'),
          subtitle: Text(
            'Comments section is yet to be developed',
            style: TextStyle(fontSize: 12),
          ),
          trailing: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.edit_rounded,
                size: 20,
                color: black,
              )),
          horizontalTitleGap: 10,
        ),
        itemCount: 1,
      ),
    );
  }
}
