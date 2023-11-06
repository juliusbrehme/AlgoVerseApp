import 'package:algo_verse_app/components/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/visualization_fab/visualize_button.dart';
import 'package:flutter/material.dart';

class FindPathButton extends StatelessWidget {
  const FindPathButton({super.key});


  @override
  Widget build(BuildContext context) {
    return VisualizeButton(
      distance: 80,
      children: [
        AlgorithmButton(
          onPressed: () {
            print("Dijkstra");
          },
          algorithm: "Dijkstra",
        ),
        AlgorithmButton(
          onPressed: () {
            print("DFS");
          },
          algorithm: "DFS",
          //closeFabOnTap: true,
        ),
        AlgorithmButton(
          onPressed: () {
            print("BFS");
          },
          algorithm: "BFS",
        ),
        AlgorithmButton(
          onPressed: () {
            print("Astar");
          },
          algorithm: "Astar",
        ),
      ],
    );
  }
}
