import 'package:flutter/material.dart';
import 'dart:math';
import 'car_painter.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_physics/car_controllers.dart';

class RemoteCar extends StatefulWidget {
  const RemoteCar({super.key});

  @override
  State<RemoteCar> createState() => _RemoteCarState();
}

class _RemoteCarState extends State<RemoteCar> 
    with SingleTickerProviderStateMixin {

  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  @override 
  void initState() {
    super.initState();

    _ticker = createTicker((Duration elapsed) {
      final double dt = (elapsed - _lastElapsed).inMicroseconds / 1000000.0;
      _lastElapsed = elapsed;

      //clamp dt 
      final double clampedDt = dt.clamp(0.0, 0.03);

      _updatePhysics(clampedDt);
    });
    _ticker.start();
  }

  @override  
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final size = MediaQuery.of(context).size;

      x = size.width / 2;
      y = size.height / 2;
      _isInitialized = true;
    }
  }

  @override  
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  //inital position of car 
  double x = 0;
  double y = 0;

  //turning angle of car 

  double angle = 0.0;

  // max speed of car
  double maxspeed = 300.0;

  //current speed of car 
  double currentspeed = 0.0;

  // accleration 
  double acc = 200.0;

  //friction 
  double friction = 0.98;

  //turn speed 
  double turnspeed = 3.0;

  bool isAccelerating = false;

  bool isBraking = false;

  bool isTurningLeft = false;

  bool isTurningRight = false;

  bool _isInitialized = false;

  void _updatePhysics(double dt) {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;

    //Steering 
    if (isTurningLeft) {
      angle -= turnspeed * dt;
    }
    if (isTurningRight) {
      angle += turnspeed * dt;
    }

    //speed 
    if (isAccelerating) {
      currentspeed += acc * dt;
    } else if (isBraking) {
      currentspeed -= acc * dt;
    } else {
      //if no button pressed 
      currentspeed *= friction;
    }

    //speed control 
    currentspeed = currentspeed.clamp(-maxspeed / 2, maxspeed);

    // position update 
    x += currentspeed * cos(angle) * dt;
    y += currentspeed * sin(angle) * dt;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      body: SafeArea(
        child: Stack(
          children: [
            //custom paint 
            Positioned.fill(
              child: CustomPaint(
                painter: CarPainter(
                  x: x,
                  y: y,
                  angle: angle,
                ),
              ),
            ),
            //Bottom control layer 
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CarControllers(
                        icon: Icons.arrow_left,
                        onDown: () => isTurningLeft = true,
                        onUp: () => isTurningLeft = false,
                      ),
                      const SizedBox(width: 16),
                      CarControllers(
                        icon: Icons.arrow_right,
                        onDown: () => isTurningRight = true,
                        onUp: () => isTurningRight = false,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CarControllers(
                        icon: Icons.arrow_drop_down,
                        onDown: () => isBraking = true,
                        onUp: () => isBraking = false,
                      ),
                      const SizedBox(width: 16),
                      CarControllers(
                        icon: Icons.arrow_drop_up,
                        onDown: () => isAccelerating = true,
                        onUp: () => isAccelerating = false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}