import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final double barHeight;
  final double barWidth;
  final double margin;
  final int animationSpeed;
  final Color? color;

  const Bar({
    super.key,
    required this.barHeight,
    required this.barWidth,
    required this.margin,
    required this.animationSpeed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(left: margin),
      duration: Duration(milliseconds: animationSpeed),
      child: Container(
        height: barHeight,
        width: barWidth,
        decoration: BoxDecoration(
          color: color ?? const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(barWidth / 2),
            topRight: Radius.circular(barWidth / 2),
          ),
        ),
      ),
    );
  }
}
