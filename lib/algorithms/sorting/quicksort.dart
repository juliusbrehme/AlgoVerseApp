import 'dart:core';

import 'package:algo_verse_app/algorithms/sorting/sorting_strategy.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';

class QuickSort implements SortingStrategy {
  @override
  Future<void> sort(SortingCoordinator coordinator) async {
    await _quickSort(0, coordinator.toSortArr.length - 1, coordinator);
  }

  Future<void> _quickSort(
      int start, int end, SortingCoordinator coordinator) async {
    if (start < end) {
      int pIndex = await _partition(start, end, coordinator);

      await _quickSort(start, pIndex - 1, coordinator);
      await _quickSort(pIndex + 1, end, coordinator);
    }
  }

  Future<int> _partition(
      int start, int end, SortingCoordinator coordinator) async {
    int pivot = coordinator.toSortArr[end];
    int pIndex = start;

    for (int i = start; i < end; ++i) {
      if (coordinator.toSortArr[i] <= pivot) {
        coordinator.swap(i, pIndex);
        await Future.delayed(
            Duration(milliseconds: coordinator.animationSpeed));
        ++pIndex;
      }
    }

    coordinator.swap(pIndex, end);
    await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));

    coordinator.resetSwap();
    return pIndex;
  }
}
