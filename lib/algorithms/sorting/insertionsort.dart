import 'package:algo_verse_app/algorithms/sorting/sorting_strategy.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';

class InsertionSort implements SortingStrategy {
  @override
  Future<void> sort(SortingCoordinator coordinator) async {
    coordinator.setStopButton(true);
    for (int i = 0; i < coordinator.toSortArr.length; ++i) {
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.setStopButton(false);
        return;
      }
      int temp = coordinator.toSortArr[i];
      int indexI = coordinator.startingArr.indexOf(coordinator.toSortArr[i]);
      coordinator.swapI = indexI;
      int j = i - 1;

      while (j >= 0 && coordinator.toSortArr[j] > temp) {
        if (coordinator.stop) {
          coordinator.resetSwap();
          coordinator.setStopButton(false);
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
      coordinator.notify();
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
    }

    coordinator.resetSwap();
  }
}
