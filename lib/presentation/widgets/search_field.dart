import 'package:flutter/material.dart';
import 'package:project_management/presentation/themes/themes.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(12),
            color: whiteContainer,
          ),
          // shape1:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
        ));
  }
}
