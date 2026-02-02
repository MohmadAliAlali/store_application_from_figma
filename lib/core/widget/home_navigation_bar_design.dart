import 'package:flutter/material.dart';

class HomeNavigationBarDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 2 Copy Copy

    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.9995257);
    path_0.lineTo(0, size.height * 0.8525018);
    path_0.quadraticBezierTo(size.width * 0.1392000, size.height * 0.8679274,
        size.width * 0.2514000, size.height * 0.8692673);
    path_0.cubicTo(
        size.width * 0.4754750,
        size.height * 0.8666350,
        size.width * 0.3062250,
        size.height * 0.9315746,
        size.width * 0.4602750,
        size.height * 0.9422457);
    path_0.quadraticBezierTo(size.width * 0.9404000, size.height * 0.9538890,
        size.width * 0.5983250, size.height * 0.9995257);
    path_0.lineTo(0, size.height * 0.9995257);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 2 Copy Copy

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);

    // Layer 2 Copy Copy Copy

    Paint paintFill1 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width, size.height * 0.9995257);
    path_1.lineTo(size.width, size.height * 0.8525018);
    path_1.quadraticBezierTo(size.width * 0.8608000, size.height * 0.8679274,
        size.width * 0.7486000, size.height * 0.8692673);
    path_1.cubicTo(
        size.width * 0.5245250,
        size.height * 0.8666350,
        size.width * 0.6937750,
        size.height * 0.9315746,
        size.width * 0.5397250,
        size.height * 0.9422457);
    path_1.quadraticBezierTo(size.width * 0.0596000, size.height * 0.9538890,
        size.width * 0.4016750, size.height * 0.9995257);
    path_1.lineTo(size.width, size.height * 0.9995257);
    path_1.close();

    canvas.drawPath(path_1, paintFill1);

    // Layer 2 Copy Copy Copy

    Paint paintStroke1 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paintStroke1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
