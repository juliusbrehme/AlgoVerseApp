import 'package:algo_verse_app/algorithms/binary_search_tree/binary_search_tree.dart';
import 'package:algo_verse_app/algorithms/binary_search_tree/binary_search_tree_history.dart';
import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';
import 'package:algo_verse_app/provider/speed.dart';
import 'package:flutter/material.dart';

class BinarySearchTreeCoordinator extends ChangeNotifier {
  final BinarySearchTree _binaryTree;

  int? _searchValue;
  Enum _speed = Speed.slow;
  int _animationSpeed = 600;
  bool _stop = false;
  bool _stopButton = false;
  List<BinarySearchTreeHistory> _history = [];

  BinarySearchTreeCoordinator(this._binaryTree) {
    binaryTree.calculateNodePositions(_binaryTree.root);
  }

  BinarySearchTree get binaryTree => _binaryTree;
  Map<Node, Node> get treeMap => binaryTree.travers();
  Enum get speed => _speed;
  bool get stop => _stop;
  bool get stopButton => _stopButton;
  int get animationSpeed => _animationSpeed;
  List<BinarySearchTreeHistory> get history => _history;

  int? getSearchValue() {
    return _searchValue;
  }

  set searchValue(int value) {
    _searchValue = value;
    notifyListeners();
  }

  set stop(bool boolean) {
    _stop = boolean;
    notifyListeners();
  }

  set stopButton(bool boolean) {
    _stopButton = boolean;
    notifyListeners();
  }

  set binaryTree(BinarySearchTree tree) {
    binaryTree = tree;
    binaryTree.calculateNodePositions(binaryTree.root);
    notifyListeners();
  }

  void addNode(int value) {
    binaryTree.add(value);
    binaryTree.calculateNodePositions(binaryTree.root);
    notifyListeners();
  }

  /// Adds a [list] of nodes to the tree.
  void addNodes(List<int> list) {
    binaryTree.fromList(list);
    binaryTree.calculateNodePositions(binaryTree.root);
    notifyListeners();
  }

  void clearHistory() {
    _history = [];
    notifyListeners();
  }

  void addToHistory(BinarySearchTreeHistory searchHistory) {
    _history.insert(0, searchHistory);
    notifyListeners();
  }

  /// Adds a [list] of nodes to the tree.
  ///
  /// After adding one node to the tree, the tree will be repainted, therefore, animted.
  Future<void> addNodesAnimated(List<int> list) async {
    stopButton = true;
    stop = false;
    if (stop) {
      stopButton = false;
      stop = false;
    }
    for (int i = 0; i < list.length; i++) {
      if (stop) {
        stopButton = false;
        stop = false;
        addNodes(list.sublist(i));
        return;
      }
      addNode(list[i]);
      await Future.delayed(Duration(milliseconds: _animationSpeed));
    }
    stopButton = false;
    stop = false;
  }

  /// Deletes all the nodes of a tree.
  void clear() {
    binaryTree.clear();
    notifyListeners();
  }

  void randomTree() {
    binaryTree.randomTree();
    binaryTree.calculateNodePositions(binaryTree.root);
    notifyListeners();
  }

  void setSpeed() {
    switch (speed) {
      case Speed.fast:
        _speed = Speed.slow;
        _animationSpeed = 600;
      case Speed.slow:
        _speed = Speed.fast;
        _animationSpeed = 200;
    }
    notifyListeners();
  }

  Future<void> binarySearch(
      int value, BinarySearchTreeCoordinator coordinator) async{
    binaryTree.binarySearch(value, coordinator);
  }

  Future<bool> bfs(
      int searchValue, BinarySearchTreeCoordinator coordinator) async {
    return binaryTree.bfs(searchValue, coordinator);
  }

  Future<bool> dfs(
      int searchValue, BinarySearchTreeCoordinator coordinator) async {
    return binaryTree.dfs(searchValue, coordinator);
  }

  void notify() {
    notifyListeners();
  }

  void resetNodes() {
    binaryTree.resetNodes(binaryTree.root);
    notifyListeners();
  }
}
