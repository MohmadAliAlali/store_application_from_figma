import 'package:flutter/material.dart';
import 'package:task_5/core/global_color.dart';

class GlobalTextStyle {
  static const TextStyle heading = TextStyle(
    fontFamily: 'Raleway',
    height: 1.16,
    fontSize: 30,
    fontWeight: FontWeight.w900,
    color: GlobalColor.white,
  );

  static const TextStyle subheading = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
    color: GlobalColor.black,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: GlobalColor.white,
  );
  static const TextStyle btnText = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: GlobalColor.black,
  );
  static const TextStyle clickText = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: GlobalColor.black,
  );
}