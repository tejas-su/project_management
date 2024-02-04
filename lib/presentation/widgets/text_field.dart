import 'package:flutter/material.dart';
import '../themes/themes.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final double bottom;
  final double left;
  final double right;
  final String hintText;
  final bool obscureText;
  final Color? color;
  const InputTextField(
      {super.key,
      this.controller,
      this.bottom = 0,
      this.left = 80,
      this.right = 80,
      required this.hintText,
      this.suffixIcon,
      this.color = whiteBG,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, bottom: bottom),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TextField(
          controller: controller,
          showCursor: true,
          obscureText: obscureText,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
              border: const OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
