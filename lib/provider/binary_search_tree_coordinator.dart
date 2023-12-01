import 'package:algo_verse_app/algorithms/binary_search_tree/binary_search_tree.dart';
import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';
import 'package:flutter/material.dart';

class BinarySearchTreeCoordinator extends ChangeNotifier {
  final BinarySearchTree _binaryTree;

  // for printing value < value at top left?
  // ignore: unused_field
  bool _searching = false;
  int? _searchValue;

  BinarySearchTreeCoordinator(this._binaryTree) {
    binaryTree.calculateNodePositions(_binaryTree.root);
  }

  BinarySearchTree get binaryTree => _binaryTree;
  Map<Node, Node> get treeMap => binaryTree.travers();
  int? getSearchValue() {
    return _searchValue;
  }

  set searchValue(int value) {
    _searchValue = value;
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

  void addNodes(List<int> list) {
    binaryTree.fromList(list);
    binaryTree.calculateNodePositions(binaryTree.root);
    notifyListeners();
  }

  // For creating own tree with list?
  Future<void> addNodesAnimated(List<int> list) async {
    for (int value in list) {
      addNode(value);
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  void clear() {
    binaryTree.clear();
    notifyListeners();
  }

  void randomTree() {
    binaryTree.randomTree();
    binaryTree.calculateNodePositions(binaryTree.root);
    notifyListeners();
  }

  // searching a value, to highlight the current looked at value
  void repaint() {
    notifyListeners();
  }

  Future<bool> binarySearch(int value) {
    return searchRecursive(binaryTree.root, value);
  }

  Future<bool> searchRecursive(Node? node, int value) async {
    Node? root = node;
    if (root == null) {
      notifyListeners();
      return false;
    } else if (root.value < value) {
      root.highlight = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 200));
      root.highlight = false;
      return searchRecursive(root.right, value);
    } else if (root.value > value) {
      root.highlight = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 200));
      root.highlight = false;
      return searchRecursive(root.left, value);
    } else {
      root.found = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1000));
      root.found = false;
      notifyListeners();
      return true;
    }
  }

  Future<bool> bfs(int value) async {
    List<Node> nextNode = [];
    if (binaryTree.root == null) {
      return false;
    } else {
      nextNode.add(binaryTree.root!);
    }

    while (nextNode.isNotEmpty) {
      Node node = nextNode.removeAt(0);
      if (value == node.value) {
        node.found = true;
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 200));
        node.found = false;
        return true;
      } else {
        node.highlight = true;
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 200));
        node.highlight = false;

        if (node.left != null) {
          nextNode.add(node.left!);
        }

        if (node.right != null) {
          nextNode.add(node.right!);
        }
      }
    }
    return false;
  }

  Future<bool> dfs(int value) async {
    List<Node> nextNode = [];
    if (binaryTree.root == null) {
      return false;
    } else {
      nextNode.add(binaryTree.root!);
    }

    while (nextNode.isNotEmpty) {
      Node node = nextNode.removeLast();
      if (value == node.value) {
        node.found = true;
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 200));
        node.found = false;
        return true;
      } else {
        node.highlight = true;
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 200));
        node.highlight = false;

        if (node.right != null) {
          nextNode.add(node.right!);
        }

        if (node.left != null) {
          nextNode.add(node.left!);
        }
      }
    }
    return false;
  }
}
