import 'package:flutter/material.dart';
import 'package:task_5/core/global_style_text.dart';

class GlobalStyleField{
  static InputDecoration titleStyle(title) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelText: title,
      labelStyle: GlobalText.textSmall,
      filled: true,
      fillColor: Colors.white,
      hintText: 'Enter $title',
      hintStyle: GlobalText.textSmall
    );
  }
}