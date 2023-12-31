import 'package:algo_verse_app/algorithms/sorting/sorting_history.dart';
import 'package:algo_verse_app/algorithms/sorting/sorting_strategy.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';

class InsertionSort implements SortingStrategy {
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
      int temp = coordinator.toSortArr[i];
      int indexI = coordinator.startingArr.indexOf(coordinator.toSortArr[i]);
      coordinator.swapI = indexI;
      int j = i - 1;

      while (j >= 0 && coordinator.toSortArr[j] > temp) {
        if (coordinator.stop) {
          coordinator.resetSwap();
          coordinator.stopButton = false;
          return;
        }
        int indexJ = coordinator.startingArr.indexOf(coordinator.toSortArr[j]);
        coordinator.indexArr[indexJ] = j + 1;
        coordinator.toSortArr[j + 1] = coordinator.toSortArr[j];
        --j;
        coordinator.swapJ = indexJ;
        await Future.delayed(
            Duration(milliseconds: coordinator.animationSpeed));
      }
      coordinator.indexArr[indexI] = j + 1;
      coordinator.toSortArr[j + 1] = temp;

      swaps++;
      sortArray.add(List.of(coordinator.toSortArr));

      coordinator.notify();
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
    }

    coordinator.resetSwap();
    coordinator.stopButton = false;
    coordinator.addToHistory(SortingHistory(
        "InsertionSort", sortArray, swaps, coordinator.toSortArr.length));
  }
}
