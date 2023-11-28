import 'package:algo_verse_app/algorithms/sorting/sorting_strategy.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';

class BubbleSort implements SortingStrategy {
  @override
  Future<void> sort(SortingCoordinator coordinator) async {
    for (int i = coordinator.toSortArr.length; i > 0; i--) {
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      int index = 1;
      int max = 0;
      while (index < i) {
        if (coordinator.stop) {
          coordinator.resetSwap();
          coordinator.stopButton = false;
          return;
        }
        if (coordinator.toSortArr[max] < coordinator.toSortArr[index]) {
          max = index;
        }
        index++;
      }
      coordinator.swap(max, index - 1);
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
    }
    coordinator.resetSwap();
  }
}
