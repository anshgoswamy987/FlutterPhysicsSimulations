/*
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_physics/ball_painter.dart';

class BouncingBall extends StatefulWidget {
 
  
  const BouncingBall({super.key});

  @override
  State<BouncingBall> createState() => _BouncingBallState();
}

class _BouncingBallState extends State<BouncingBall> 
with SingleTickerProviderStateMixin {
//ticker and time tracking varaible 

  late final Ticker _ticker;
  Duration _lastElapsed = Duration.zero;

  @override 
  void initState(){
    super.initState();
 
  

    //createTicker meets with mixin
    _ticker = createTicker((Duration elapsed){
      //differnce between this frame and last frame
      final double dt = (elapsed - _lastElapsed).inMicroseconds/1000000.0;
      _lastElapsed = elapsed;
      //clamp dt for safety 
      final double clampedDT = dt.clamp(0.0,0.033);

      _updatePhysics(clampedDT);
    });
    _ticker.start();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isIniatialized) {
      final size = MediaQuery.of(context).size;
      x = size.width / 2; // Center me set ho gaya
      _isIniatialized = true;
    }
  }

  @override void dispose(){
    _ticker.dispose();
    super.dispose();
  }
     void _updatePhysics(double dt){
      if(!mounted) return;
      final size = MediaQuery.of(context).size;


    //acc -> velocity 
    vy += gravity * dt;

    // velocity -> position
    x+= vx*dt;
    y += vy*dt;

    // 3. Floor Collision
  final double floorY = size.height - radius;
  if (y > floorY) {
    y = floorY;
    vy = -vy * 0.75;
  }

  // left wall collison 
  if(x< radius){ // when touches left corner
    x=radius; // so the ball doesnt get stuck to wall
    vx= -vx * 0.75; // bounce back with less speed 
  }

  // right wall collision 
  if(x> size.width-radius){// when ball right edge cross right boundary
    x = size.width-radius;//stop the ball at edge 
    vx = -vx *0.75;//bounce back with less speed 
  }

  //UI redraw
  setState(() {
    
  });

     }

  //current position of ball
  double x = 0.0;
  double y = 100;

  //current speed of ball
  double vx = 200;
  double vy = 100;

  //radius of ball
  double radius = 20.0;
  //gravity(automatic down pull)
  double gravity = 1400.0;
 bool _isIniatialized = false;

 bool _isDragging = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: CustomPaint(
      painter: MyBallPainter(
        x: x,
       y: y, 
       radius: radius),
        size: Size.infinite
      
     ),
    );
  }
}*/