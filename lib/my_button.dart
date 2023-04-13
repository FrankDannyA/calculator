import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textStyle;
  final String textButton;
  final onTap;

  const MyButton({
    Key? key,
    required this.color,
    required this.textButton,
    required this.onTap,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 30),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(textButton, style: textStyle),
            ),
          ),
        ),
      ),
    );
  }
}
