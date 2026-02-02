import 'package:flutter/material.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/responsiv/risponsive.dart';

class CustomText extends StatelessWidget {
  final String text1;
  final double text2;
  final TextStyle style1;
  final TextStyle style2;

  const CustomText({
    super.key,
    required this.text1,
    required this.text2,
    this.style1=GlobalTextStyle.clickText,
     this.style2= GlobalTextStyle.clickText,

  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Padding(padding: const EdgeInsets.only(left: 12,right: 12),child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1,style: style1,),
          Text('$text2 \$',style: style2,)
        ],
      )
      ,);
  }
}

class CustomTextDrwoer extends StatelessWidget {
  final String text1;
  final String text2;
  final TextStyle style1;
  final VoidCallback? onPressed;

  const CustomTextDrwoer({
    super.key,
    required this.text1,
    required this.text2,
    this.style1=const TextStyle(
      fontFamily: 'Raleway',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: GlobalColor.white,
    ),
    this.onPressed ,

  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Padding(padding: const EdgeInsets.only(bottom: 30,),child:
    InkWell(onTap:onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(text1,width: 24,height: 24, color: GlobalColor.white,),
            const SizedBox(width: 22,),
            Text(text2 ,style: style1,)
          ],
        ),
        const Icon(Icons.arrow_forward_ios,color: GlobalColor.white,)
      ],
    ),)
      ,);
  }
}



