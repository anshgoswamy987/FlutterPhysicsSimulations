
import 'package:flutter/material.dart';

class CarControllers extends StatelessWidget {
  final IconData icon;
  final VoidCallback onDown;
  final VoidCallback onUp;

  const CarControllers({super.key,
  required this.icon,
  required this.onDown,
  required this.onUp,
  });

  @override
  Widget build(BuildContext context) {
 return GestureDetector(
  behavior: HitTestBehavior.opaque,
  onTapDown: (_) => onDown(),
  onTapUp: (_) => onUp(),
      onTapCancel: () => onUp(),
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
       shape: BoxShape.circle,
       border: Border.all(color: Colors.white38, width:2)

      ),
      child: Icon(icon, color: Colors.white, size: 32)
      )
 );
  }
}