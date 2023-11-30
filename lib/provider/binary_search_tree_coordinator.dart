import 'dart:math';

import 'package:algo_verse_app/algorithms/binary_search_tree/binary_search_tree.dart';
import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';
import 'package:flutter/material.dart';

class BinarySearchTreeCoordinator extends ChangeNotifier {
  BinarySearchTree _binaryTree = BinarySearchTree();

  BinarySearchTreeCoordinator() {
    _binaryTree = BinarySearchTree.fromList(
        List.generate(15, (index) => Random().nextInt(100)));
    binaryTree.calculateNodePositions();
  }

  BinarySearchTree get binaryTree => _binaryTree;
  Map<Node, Node> get treeMap => binaryTree.travers();

  set binaryTree(BinarySearchTree tree) {
    binaryTree = tree;
    binaryTree.calculateNodePositions();
    notifyListeners();
  }

  void addNode(int value) {
    binaryTree.add(value);
    binaryTree.calculateNodePositions();
    notifyListeners();
  }

  void addNodes(List<int> list) {
    binaryTree.fromList(list);
    binaryTree.calculateNodePositions();
    notifyListeners();
  }

  void clear() {
    binaryTree.clear();
    notifyListeners();
  }

  void randomTree() {
    binaryTree.randomTree();
    binaryTree.calculateNodePositions();
    notifyListeners();
  }
}
