import 'package:flutter/material.dart';
import '../themes/themes.dart';

class CTAButton extends StatelessWidget {
  final double left;
  final double right;
  final String text;
  final Function()? onTap;
  const CTAButton(
      {super.key,
      this.left = 100,
      this.right = 100,
      required this.text,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: left, right: right),
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
              color: black,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: whiteBG, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}