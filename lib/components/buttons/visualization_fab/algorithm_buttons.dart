import 'package:flutter/material.dart';

class AlgorithmButton extends StatelessWidget {
  const AlgorithmButton(
      {super.key,
      required this.onPressed,
      required this.algorithm,
      this.closeFabOnTap = true});

  final VoidCallback? onPressed;
  final String algorithm;
  final bool closeFabOnTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 150,
        height: 70,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(51, 74, 100, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            algorithm,
            style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Outfit',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
