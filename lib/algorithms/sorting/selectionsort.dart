import 'package:algo_verse_app/algorithms/sorting/sorting_history.dart';
import 'package:algo_verse_app/algorithms/sorting/sorting_strategy.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';

class SelectionSort implements SortingStrategy {
  int swaps = 0;
  List<List<int>> sortArray = [];

  @override
  Future<void> sort(SortingCoordinator coordinator) async {
    sortArray.add(List.of(coordinator.toSortArr));

    for (int i = 0; i < coordinator.toSortArr.length; ++i) {
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      int smallest = coordinator.toSortArr[i];
      int smallestIndex = i;
      int indexI = coordinator.startingArr.indexOf(smallest);
      coordinator.swapI = indexI;

      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));

      for (int j = (i + 1); j < coordinator.toSortArr.length; ++j) {
        if (coordinator.stop) {
          coordinator.resetSwap();
          coordinator.stopButton = false;
          return;
        }
        if (coordinator.toSortArr[j] < smallest) {
          smallestIndex = j;
          smallest = coordinator.toSortArr[j];

          int indexJ = coordinator.startingArr.indexOf(smallest);
          coordinator.swapJ = indexJ;

          await Future.delayed(
              Duration(milliseconds: coordinator.animationSpeed));
        }
      }

      coordinator.swap(i, smallestIndex);
      swaps++;
      sortArray.add(List.of(coordinator.toSortArr));
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
    }
    coordinator.resetSwap();
    coordinator.stopButton = false;
    coordinator.addToHistory(SortingHistory(
        "SelectionSort", sortArray, swaps, coordinator.toSortArr.length));
  }
}
