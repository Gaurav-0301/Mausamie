import 'dart:math' as math;
import 'package:flutter/material.dart';

class GlobeWidget extends StatefulWidget {
  final String cityName;

  const GlobeWidget({
    super.key,
    required this.cityName,
  });

  @override
  State<GlobeWidget> createState() => _GlobeWidgetState();
}

class _GlobeWidgetState extends State<GlobeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.35),
                  blurRadius: 45,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: child,
              );
            },
            child: ClipOval(
              child: Image.asset(
                'assets/images/earth.png',
                width: 245,
                height: 245,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 40,
            child: Column(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.redAccent,
                  size: 34,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.cityName,
                    style: const TextStyle(
                      color: Color(0xFF102342),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}