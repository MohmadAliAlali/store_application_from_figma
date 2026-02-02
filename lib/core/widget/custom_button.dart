import 'package:flutter/material.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/responsiv/risponsive.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width =335,
    this.height = 50,
    this.color = GlobalColor.greenButton,
    this.isLoading =false,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SizedBox(
      height:ScreenUtil.getHeight(height),
      width: ScreenUtil.getWidth(width),
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(ScreenUtil.getWidth(width), ScreenUtil.getHeight(height)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: child,
      ),
    );
  }
}



class CustomIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Color color;

  const CustomIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color = GlobalColor.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          margin: const EdgeInsets.all(8),  // Optional: Set margin for better spacing
          decoration:BoxDecoration(
            color: color,          // Custom background color
            shape: BoxShape.circle,     // Circular shape
          ),
          child:Align(alignment:const  Alignment(0.4, 0),child:  icon,) // Icon and its color
      ),
    );
  }
}

class CustomIconAction extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Color color;

  final double width;

  final double height;

  const CustomIconAction({
    super.key,
    required this.onPressed,
    required this.icon,
    this.width= 44 ,
    this.height= 44 ,
    this.color = const Color(0xffffffff),
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: ScreenUtil.getHeight(height),
          width:  ScreenUtil.getWidth(width),
          decoration:BoxDecoration(
            color: color,          // Custom background color
            shape: BoxShape.circle,     // Circular shape
          ),
          child:Align(child:  icon,) // Icon and its color
      ),
    );
  }
}
