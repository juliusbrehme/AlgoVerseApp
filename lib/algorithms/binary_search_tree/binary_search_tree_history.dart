import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';

class BinarySearchTreeHistory {
  
  final String algorithm;
  final List<Node> _visitedNodes;
  final int _size;

  BinarySearchTreeHistory(this.algorithm, this._visitedNodes, this._size);

  List<Node> get visitedNodes => _visitedNodes;
  int get size => _size;

}