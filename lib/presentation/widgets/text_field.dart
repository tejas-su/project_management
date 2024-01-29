import 'package:flutter/material.dart';
import '../themes/themes.dart';

class InputTextField extends StatelessWidget {
  final double left;
  final double right;
  final String hintText;
  final bool obscureText;
  const InputTextField(
      {super.key,
      this.left = 80,
      this.right = 80,
      required this.hintText,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: Container(
        decoration: const BoxDecoration(
            color: whiteBG,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
