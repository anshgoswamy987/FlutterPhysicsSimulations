/*import 'package:flutter/material.dart';

class CarPainter extends CustomPainter{
 final double x;
 final double y;
 final double angle;

 CarPainter({
  required this.x,
  required this.y,
  required this.angle
 });

 @override
 void paint (Canvas canvas , Size size){
  final paint = Paint()
  ..color = Colors.amberAccent
  ..style = PaintingStyle.fill;

  canvas.save();
  
  canvas.rotate(angle);

  final carRect = Rect.fromCenter(
      center: Offset.zero,
      width: 50,
      height: 26,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(carRect, const Radius.circular(6)),
      paint,
    );

    // Headlights
    final lightPaint = Paint()..color = Colors.white;
    canvas.drawCircle(const Offset(22, -8), 3, lightPaint);
    canvas.drawCircle(const Offset(22, 8), 3, lightPaint);

    // 5. Canvas ko wapas seedha karo
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CarPainter oldDelegate) {
    return true; // Har frame par car naye angle/pos pe redraw hogi
  }
}
 */