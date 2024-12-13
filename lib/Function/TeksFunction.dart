import 'package:flutter/material.dart';

class TextButtons extends StatelessWidget {
  final String Texts;
  final double TextSize;
  final VoidCallback onPress;
  const TextButtons({
    super.key,
    required this.Texts,
    required this.TextSize,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: TextButton(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
            fontSize: TextSize,
            // color: Colors.blue,
            fontFamily: "Poppin",
            fontWeight: FontWeight.bold),
      ),
      onPressed: onPress,
      child: Text(
        Texts,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
        ),
      ),
    ));
  }
}
