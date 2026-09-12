import 'package:flutter/material.dart';
import 'dart:math';

class ReflexGame extends StatefulWidget {
  const ReflexGame({super.key});

  @override
  State<ReflexGame> createState() => _ReflexGameState();
}

class _ReflexGameState extends State<ReflexGame> {
  final Random  _random = Random();

  //orb properties 
  double orbX = 0;
  double orbY = 0;
  final double orbRadius = 35.0;

  //score tracker 
  int score = 0;
  bool _isInitialized = false;
     
     @override
     void didChangeDependencies() {
    super.didChangeDependencies();
    if(!_isInitialized){
      final Size = MediaQuery.of(context).size;
      _spawnNewOrb(size);
      _isInitialized = true;
    }
  }
  //spawn orb method
  void _spawnNewOrb(Size screenSize){
    final double minX = orbRadius;
    final double maxX = screenSize.width - orbRadius; 
    final double minY=  orbRadius + 60;
    final double maxY =  screenSize.height - orbRadius - 40;

    setState(() {
       orbX = minX + _random.nextDouble() * (maxX - minX);
      orbY = minY + _random.nextDouble() * (maxY - minY);
    });
  }

  void _handleTap(Offset tapPosition , screenSize ){
    
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}