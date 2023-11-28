import 'package:algo_verse_app/algorithms/sorting/sorting_strategy.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';

class MergeSort implements SortingStrategy {
  @override
  Future<void> sort(SortingCoordinator coordinator) async {
    if (coordinator.stop) {
      coordinator.resetSwap();
      coordinator.stopButton = false;
      return;
    }
    await _mergeSort(0, coordinator.toSortArr.length - 1, coordinator);
  }

  Future<void> _mergeSort(
      int start, int end, SortingCoordinator coordinator) async {
    if (coordinator.stop) {
      coordinator.resetSwap();
      coordinator.stopButton = false;
      return;
    }
    if (start < end) {
      int mid = (start + end) ~/ 2;
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      await _mergeSort(start, mid, coordinator);
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      await _mergeSort(mid + 1, end, coordinator);
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }

      await _merge(start, mid, end, coordinator);
    }

    coordinator.resetSwap();
  }

  Future<void> _merge(
      int start, int mid, int end, SortingCoordinator coordinator) async {
    if (coordinator.stop) {
      coordinator.resetSwap();
      coordinator.stopButton = false;
      return;
    }
    int m = (mid - start) + 1;
    int n = (end - mid);

    List<int> arr1 = List<int>.filled(m, 0, growable: true);
    List<int> arr2 = List<int>.filled(n, 0, growable: true);

    int i, j, k = start;

    for (i = 0; i < m; ++i) {
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      arr1[i] = coordinator.toSortArr[k++];
    }

    for (j = 0; j < n; ++j) {
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      arr2[j] = coordinator.toSortArr[k++];
    }

    i = j = 0;
    k = start;

    while (i != m && j != n) {
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      int index;

      if (arr1[i] < arr2[j]) {
        index = coordinator.startingArr.indexOf(arr1[i]);
        coordinator.swapI = index;
        coordinator.indexArr[index] = k;

        coordinator.toSortArr[k++] = arr1[i++];
      } else {
        index = coordinator.startingArr.indexOf(arr2[j]);
        coordinator.swapJ = index;
        coordinator.indexArr[index] = k;

        coordinator.toSortArr[k++] = arr2[j++];
      }

      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
    }

    while (i != m) {
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      int index = coordinator.startingArr.indexOf(arr1[i]);
      coordinator.swapI = index;
      coordinator.indexArr[index] = k;

      coordinator.toSortArr[k++] = arr1[i++];

      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
    }

    while (j != n) {
      if (coordinator.stop) {
        coordinator.resetSwap();
        coordinator.stopButton = false;
        return;
      }
      int index = coordinator.startingArr.indexOf(arr2[j]);
      coordinator.swapJ = index;
      coordinator.indexArr[index] = k;

      coordinator.toSortArr[k++] = arr2[j++];

      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
    }

    coordinator.resetSwap();
  }
}
