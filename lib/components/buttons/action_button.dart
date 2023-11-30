import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.height,
    required this.radius,
    required this.onTap,
    required this.icon,
  });

  final double height;
  final double radius;
  final VoidCallback onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(70, 40),
            backgroundColor: const Color.fromRGBO(51, 74, 100, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius))),
          ),
          onPressed: onTap,
          child: icon,
        ),
      ),
    );
  }
}
