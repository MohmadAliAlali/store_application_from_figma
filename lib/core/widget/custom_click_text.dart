import 'package:flutter/material.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_text_style.dart';

class CustomClickText extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final TextStyle textStyle;

  const CustomClickText({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = GlobalColor.black,
    this.textStyle = GlobalTextStyle.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPressed,
      child: Text(
        text,
        style: textStyle
      ),
    );
  }
}