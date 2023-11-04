import 'package:flutter/material.dart';

class VisualizeButton extends StatelessWidget {
  const VisualizeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      print("Visualize");
    });
  }
}
