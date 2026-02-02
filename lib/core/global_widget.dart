import 'package:flutter/material.dart';
import 'package:task_5/core/global_color.dart';

import 'global_style_field.dart';

class GlobalWidget{
  static Widget costomButton(void Function() doFun ,Widget widget ){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
             GlobalColor.gray,
          ),
          minimumSize: WidgetStateProperty.all<Size>(const Size(80, 80)),),
        onPressed: doFun,
        child: widget
      ),
    );
  }
  static Widget costomTextField
      (String? Function(String?) doFun ,controller,String title,bool obscureText,TextInputType type){
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: GlobalStyleField.titleStyle(title),
      obscureText: obscureText,
      validator: doFun,
    );
  }
}