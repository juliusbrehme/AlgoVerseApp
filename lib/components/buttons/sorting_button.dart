import 'package:algo_verse_app/components/buttons/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/visualize_button.dart';
import 'package:flutter/material.dart';

class SortingButton extends StatelessWidget {
  const SortingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return VisualizeButton(
      distance: 80,
      children: [
        AlgorithmButton(
          onPressed: () {
            print("Selectionsort");
          },
          algorithm: "Selectionsort",
        ),
        AlgorithmButton(
          onPressed: () {
            print("Insertionsort");
          },
          algorithm: "Insertionsort",
          //closeFabOnTap: true,
        ),
        AlgorithmButton(
          onPressed: () {
            print("Bubblesort");
          },
          algorithm: "Bubblesort",
        ),
        AlgorithmButton(
          onPressed: () {
            print("Quicksort");
          },
          algorithm: "Quicksort",
        ),
        AlgorithmButton(
          onPressed: () {
            print("Mergesort");
          },
          algorithm: "Mergesort",
        ),
      ],
    );
  }
}
