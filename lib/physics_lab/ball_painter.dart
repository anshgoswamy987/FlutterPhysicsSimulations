/*import 'package:flutter/material.dart';

class MyBallPainter extends CustomPainter{
  final double x;
  final double y;
  final double radius;
  
  MyBallPainter({
    required this.x,
    required this.y,
    required this.radius,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepOrangeAccent
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  @override
  bool shouldRepaint(covariant MyBallPainter oldDelegate) {
    return oldDelegate.x != x || oldDelegate.y != y;
  }
}*/