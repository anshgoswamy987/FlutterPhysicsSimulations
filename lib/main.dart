import 'package:flutter/material.dart';
import 'package:flutter_physics/bouncing_ball.dart';
import 'package:flutter_physics/remote_car.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RemoteCar()
    );
  }
}
