import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ReflexGame extends StatefulWidget {
  const ReflexGame({super.key});

  @override
  State<ReflexGame> createState() => _ReflexGameState();
}

class _ReflexGameState extends State<ReflexGame> {
  final Random _random = Random();

  // Orb properties 
  double orbX = 0;
  double orbY = 0;
  final double orbRadius = 35.0;

  // Level & Game State
  int level = 1;
  int misses = 0;
  Timer? _orbTimer;
  int score = 0;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final size = MediaQuery.of(context).size;
      _spawnNewOrb(size);
      _isInitialized = true;
    }
  }

  void _handleMiss(Size screenSize) {
    setState(() {
      misses++;
      if (misses >= 3) {
        level = 1;
        score = 0;
        misses = 0;
      }
    });
    _spawnNewOrb(screenSize);
  }

  void _startOrbTimer(Size screenSize) {
    _orbTimer?.cancel();

    if (level == 1) return;

    final Duration duration = (level == 2)
        ? const Duration(seconds: 2)
        : const Duration(seconds: 1);

    _orbTimer = Timer(duration, () {
      _handleMiss(screenSize);
    });
  }

  @override
  void dispose() {
    _orbTimer?.cancel();
    super.dispose();
  }

  // Spawn orb method
  void _spawnNewOrb(Size screenSize) {
    final double minX = orbRadius;
    final double maxX = screenSize.width - orbRadius;
    final double minY = orbRadius + 60;
    final double maxY = screenSize.height - orbRadius - 40;

    setState(() {
      orbX = minX + _random.nextDouble() * (maxX - minX);
      orbY = minY + _random.nextDouble() * (maxY - minY);
    });
    _startOrbTimer(screenSize);
  }

  void _handleTap(Offset tapPosition, Size screenSize) {
    final double dx = tapPosition.dx - orbX;
    final double dy = tapPosition.dy - orbY;

    // Distance squared <= Radius squared
    final bool isHit = (dx * dx + dy * dy) <= (orbRadius * orbRadius);

    if (isHit) {
      _orbTimer?.cancel();

      setState(() {
        score++;

        // Level Promotion Logic
        if (score >= 25) {
          level = 3;
        } else if (score >= 10) {
          level = 2;
        }
      });

      // Next orb spawn
      _spawnNewOrb(screenSize);
    } // if (isHit) closed
  } // _handleTap closed

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF12121E),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) => _handleTap(details.localPosition, size),
          child: Stack(
            children: [
              // Score, Level & Misses Display
              Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      'Score: $score   |   Level: $level',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Misses: $misses / 3',
                      style: TextStyle(
                        color: misses > 0 ? Colors.redAccent : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Orb Canvas Layer
              Positioned.fill(
                child: CustomPaint(
                  painter: OrbPainter(
                    x: orbX,
                    y: orbY,
                    radius: orbRadius,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrbPainter extends CustomPainter {
  final double x;
  final double y;
  final double radius;

  OrbPainter({
    required this.x,
    required this.y,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00E5FF)
      ..style = PaintingStyle.fill;

    // Glowing border
    final strokePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(Offset(x, y), radius, paint);
    canvas.drawCircle(Offset(x, y), radius, strokePaint);
  }

  @override
  bool shouldRepaint(covariant OrbPainter oldDelegate) {
    return oldDelegate.x != x || oldDelegate.y != y;
  }
}