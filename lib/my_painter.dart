import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class MyPainter extends CustomPainter {
  final Color color;

  const MyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromARGB(255, 76, 144, 201);
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.height / 2, size.width / 2),
            width: size.width,
            height: size.height),
        (180 + 45) * math.pi / 180,
        90 * math.pi / 180,
        true,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}