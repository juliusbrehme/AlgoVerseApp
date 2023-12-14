class SortingHistory {
  final String _algorithm;
  final List<List<int>> _sortArray;
  final int _swaps;
  final int _size;

  SortingHistory(
    this._algorithm,
    this._sortArray,
    this._swaps,
    this._size,
  );

  String get algorithm => _algorithm;
  List<List<int>> get sortArray => _sortArray;
  int get swaps => _swaps;
  int get size => _size;
}
