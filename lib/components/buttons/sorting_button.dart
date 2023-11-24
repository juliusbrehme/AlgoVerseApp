import 'package:algo_verse_app/algorithms/sorting/bubblesort.dart';
import 'package:algo_verse_app/algorithms/sorting/insertionsort.dart';
import 'package:algo_verse_app/algorithms/sorting/mergesort.dart';
import 'package:algo_verse_app/algorithms/sorting/quicksort.dart';
import 'package:algo_verse_app/algorithms/sorting/selectionsort.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/visualize_button.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortingButton extends StatelessWidget {
  const SortingButton({super.key});

  @override
  Widget build(BuildContext context) {
    SortingCoordinator coordinator =
        Provider.of<SortingCoordinator>(context, listen: false);

    return VisualizeButton(
      distance: 80,
      children: [
        AlgorithmButton(
          onPressed: () {
            coordinator.setStop(false);
            coordinator.setStopButton(true);
            SelectionSort selectionSort = SelectionSort();
            selectionSort.sort(coordinator);
          },
          algorithm: "Selectionsort",
        ),
        AlgorithmButton(
          onPressed: () {
            coordinator.setStop(false);
            coordinator.setStopButton(true);
            InsertionSort insertionSort = InsertionSort();
            insertionSort.sort(coordinator);
          },
          algorithm: "Insertionsort",
          //closeFabOnTap: true,
        ),
        AlgorithmButton(
          onPressed: () {
            coordinator.setStop(false);
            coordinator.setStopButton(true);
            BubbleSort bubbleSort = BubbleSort();
            bubbleSort.sort(coordinator);
          },
          algorithm: "Bubblesort",
        ),
        AlgorithmButton(
          onPressed: () {
            coordinator.setStop(false);
            coordinator.setStopButton(true);
            QuickSort quicksort = QuickSort();
            quicksort.sort(coordinator);
          },
          algorithm: "Quicksort",
        ),
        AlgorithmButton(
          onPressed: () {
            coordinator.setStop(false);
            coordinator.setStopButton(true);
            MergeSort mergeSort = MergeSort();
            mergeSort.sort(coordinator);
          },
          algorithm: "Mergesort",
        ),
      ],
    );
  }
}
