import 'package:flutter/material.dart';

import '../components/bugs_section.dart';
import '../components/comments_section.dart';
import '../themes/themes.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool selected = false;
  //on tap of list tile event handler
  void onTap(index) {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        //Projects section
        //
        Container(
          height: 800,
          width: 350,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              border:
                  Border(right: BorderSide(width: 3, color: whiteContainer))),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: ListTile(
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusColor: whiteContainer,
                hoverColor: whiteContainer,
                autofocus: true,
                selected: selected,
                selectedColor: black,
                selectedTileColor: whiteContainer,
                onTap: () => onTap(index),
                enabled: true,
                tileColor: whiteBG,
                leading: const CircleAvatar(
                    foregroundImage: AssetImage('avatars/man.png')),
                title: const Text('Kraken'),
                subtitle: const Text(
                  'A simple project management tool',
                  style: TextStyle(fontSize: 12),
                ),
                trailing: const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.edit_rounded,
                      size: 20,
                      color: black,
                    )),
                horizontalTitleGap: 10,
              ),
            ),
          ),
        ),
        //
        //Users Section
        //
        Container(
          height: 800,
          width: 350,
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              border:
                  Border(right: BorderSide(width: 3, color: whiteContainer))),
          child: ListView.builder(
            itemBuilder: (context, index) => const ListTile(
              leading:
                  CircleAvatar(foregroundImage: AssetImage('avatars/man.png')),
              title: Text('tejas.s.u_'),
              subtitle: Text(
                'tejas_s.u@yahoo.com',
                style: TextStyle(fontSize: 12),
              ),
              horizontalTitleGap: 10,
            ),
            itemCount: 3,
          ),
        ),
        //
        //bugs section
        //
        Container(
            height: 800,
            width: 750,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                border:
                    Border(right: BorderSide(width: 3, color: whiteContainer))),
            child: const BugsSection()),
        //
        //comments section
        //
        Container(
          height: 800,
          width: 400,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              border:
                  Border(right: BorderSide(width: 3, color: whiteContainer))),
          child: const CommentsSection(),
        )
      ],
    );
  }
}
