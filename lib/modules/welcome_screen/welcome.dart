import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPill extends StatefulWidget {
  const AnimatedPill({super.key});

  @override
  State<AnimatedPill> createState() => _AnimatedPillState();
}

class _AnimatedPillState extends State<AnimatedPill>
    with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _openController;
  late final AnimationController _dustController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _openController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _dustController = AnimationController(
      duration: const Duration(milliseconds: 1750),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _openController.dispose();
    _dustController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: -2 * pi * _rotationController.value,
          child: child,
        );
      },
      child: SizedBox(
        width: 150,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTopSide(),
            _buildMedicine(),
            _buildBottomSide(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSide() {
    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFF7C340),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(60)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            offset: Offset(0, -1),
            blurRadius: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSide() {
    return AnimatedBuilder(
      animation: _openController,
      builder: (context, child) {
        double marginTop = Tween(begin: 0.0, end: 100.0)
            .evaluate(CurvedAnimation(parent: _openController, curve: Curves.easeInOut));
        return Container(
          margin: EdgeInsets.only(top: marginTop),
          width: 110,
          height: 150,
          decoration: BoxDecoration(
            color: const Color(0xFFD9680C),
            borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(60)),
            border: Border(top: BorderSide(width: 10, color: Color(0xFF621E1A))),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                offset: Offset(0, 1),
                blurRadius: 6,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMedicine() {
    return Container(
      width: 90,
      height: 130,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: List.generate(20, (index) {
          final rand = Random(index);
          final double size = rand.nextDouble() * 10 + 4;
          final double top = rand.nextDouble() * 100;
          final double left = rand.nextDouble() * 80;

          return AnimatedBuilder(
            animation: _dustController,
            builder: (context, child) {
              double dx = sin(_dustController.value * 2 * pi + index) * 5;
              double dy = cos(_dustController.value * 2 * pi + index) * 5;
              return Positioned(
                top: top + dy,
                left: left + dx,
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4477CC),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}