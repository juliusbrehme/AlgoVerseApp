import 'package:algo_verse_app/components/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/visualization_fab/visualize_button.dart';
import 'package:flutter/material.dart';

class SearchTreeButton extends StatelessWidget {
  const SearchTreeButton({super.key});

@override
  Widget build(BuildContext context) {
    return VisualizeButton(
      distance: 80,
      children: [
        AlgorithmButton(
          onPressed: () {
            print("DFS");
          },
          algorithm: "DFS",
        ),
        AlgorithmButton(
          onPressed: () {
            print("BFS");
          },
          algorithm: "BFS",
          //closeFabOnTap: true,
        ),
      ],
    );
  }
}