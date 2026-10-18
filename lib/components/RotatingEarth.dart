import 'dart:math' as math;
import 'package:flutter/material.dart';

class RotatingEarth extends StatefulWidget {
  const RotatingEarth({super.key});

  @override
  State<RotatingEarth> createState() => _RotatingEarthState();
}

class _RotatingEarthState extends State<RotatingEarth>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: ClipOval(
        child: Image.asset(
          'assets/images/earth.png',
          fit: BoxFit.cover,
          width: 250,
          height: 250,
        ),
      ),
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
    );
  }
}