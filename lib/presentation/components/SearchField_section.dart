import "package:flutter/material.dart";
import "package:project_management/presentation/themes/themes.dart";

class searchField extends StatefulWidget {
  const searchField({super.key});

  @override
  State<searchField> createState() => _searchFieldState();
}

class _searchFieldState extends State<searchField> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:const  EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: whiteContainer,
        child:const TextField(
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon:  Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ));
  }
}