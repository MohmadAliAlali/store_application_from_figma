
import 'package:flutter/material.dart';
import 'package:task_5/core/responsiv/risponsive.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;


  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      color: Colors.transparent,
      height: ScreenUtil.getHeight(100) ,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, ScreenUtil.getHeight(80) ,),
              painter: BottomNavPainter(),
              child: Container(
                color: Colors.transparent,

                height: ScreenUtil.getHeight(80) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(Icons.home_outlined, 0),
                    _buildNavItem(Icons.favorite_outline, 1),
                     SizedBox(width: ScreenUtil.getWidth(60) ), // Space for center button
                    _buildNavItem(Icons.notifications_none, 2),
                    _buildNavItem(Icons.person_outline_outlined, 3),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: ScreenUtil.getWidth(60) ,
                height: ScreenUtil.getHeight(60) ,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_bag, color: Colors.white),
                  onPressed: () => onItemTapped(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: selectedIndex == index ? Colors.green : Colors.black38,
      ),
      onPressed: () => onItemTapped(index),
    );
  }
}


class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, -20);
    path.quadraticBezierTo(size.width * 0.05, 0, size.width * 0.25, 0);

    path.lineTo(size.width * 0.35, 0);

    double radius = 14.0;
    double rectLeft = size.width * 0.38;
    double rectRight = size.width * 0.62;
    double rectTop = size.height * 0.56;
    double rectBottom = size.height * 0.65;

    path.lineTo(rectLeft - radius, 0);
    path.quadraticBezierTo(rectLeft, 0, rectLeft, radius);
    path.lineTo(rectLeft, rectTop - radius);

    path.quadraticBezierTo(rectLeft, rectTop, rectLeft + radius, rectTop + 3);
    path.quadraticBezierTo(
        (rectLeft + rectRight) / 2, rectBottom + 2, rectRight - radius, rectTop + 3);

    path.quadraticBezierTo(
        rectRight ,
        rectTop-2,
        rectRight+0.1,
        rectTop - radius+1
    );
    path.lineTo(rectRight, radius);

    path.quadraticBezierTo(rectRight, 0, rectRight + radius, 0);

    path.lineTo(size.width * 0.75, 0);

    path.quadraticBezierTo(size.width * 0.95, 0, size.width, -20);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}