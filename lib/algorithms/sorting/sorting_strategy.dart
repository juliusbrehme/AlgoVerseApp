import 'package:algo_verse_app/provider/sorting_coordinator.dart';

/// This is the interface for the different sorting algorithms. Every sorting algorithm should
/// implement this interface.
abstract class SortingStrategy {

  /// This method is to sort the integer array given by the sorting coordinator. This method should mutate
  /// the array that is supposed to be sorted
  ///
  /// @param coordinator The sorting coordinator holding the valuable information of the arrays
  void sort(SortingCoordinator coordinator);
}
