import 'package:algo_verse_app/algorithms/binary_search_tree/binary_search_tree.dart';
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

  BinarySearchTreeCoordinator(this._binaryTree) {
    binaryTree.calculateNodePositions(_binaryTree.root);
  }

  BinarySearchTree get binaryTree => _binaryTree;
  Map<Node, Node> get treeMap => binaryTree.travers();
  Enum get speed => _speed;
  bool get stop => _stop;
  bool get stopButton => _stopButton;

  int? getSearchValue() {
    return _searchValue;
  }

  set searchValue(int value) {
    _searchValue = value;
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

  Future<bool> binarySearch(int value) {
    return searchRecursive(_binaryTree.root, value);
  }

  Future<bool> searchRecursive(Node? node, int value) async {
    Node? root = node;
    if (stop) {
      stopButton = false;
      return false;
    }
    if (root == null) {
      stopButton = false;
      notifyListeners();
      return false;
    } else if (root.value < value) {
      if (stop) {
        stopButton = false;
        return false;
      }
      root.highlight = true;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: _animationSpeed));
      root.highlight = false;
      return searchRecursive(root.right, value);
    } else if (root.value > value) {
      if (stop) {
        stopButton = false;
        return false;
      }
      root.highlight = true;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: _animationSpeed));
      root.highlight = false;
      return searchRecursive(root.left, value);
    } else {
      if (stop) {
        stopButton = false;
        return false;
      }
      root.found = true;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: _animationSpeed + 400));
      root.found = false;
      notifyListeners();
      stopButton = false;
      return true;
    }
  }

  Future<bool> bfs(int value) async {
    List<Node> nextNode = [];
    if (stop) {
      stopButton = false;
      return false;
    }
    if (binaryTree.root == null) {
      stopButton = false;
      return false;
    } else {
      nextNode.add(binaryTree.root!);
    }

    while (nextNode.isNotEmpty) {
      if (stop) {
        stopButton = false;
        return false;
      }
      Node node = nextNode.removeAt(0);
      if (value == node.value) {
        node.found = true;
        notifyListeners();
        await Future.delayed(Duration(milliseconds: _animationSpeed));
        node.found = false;
        stopButton = false;
        return true;
      } else {
        node.highlight = true;
        notifyListeners();
        await Future.delayed(Duration(milliseconds: _animationSpeed));
        node.highlight = false;

        if (node.left != null) {
          nextNode.add(node.left!);
        }

        if (node.right != null) {
          nextNode.add(node.right!);
        }
      }
    }
    stopButton = false;
    return false;
  }

  Future<bool> dfs(int value) async {
    List<Node> nextNode = [];
    if (stop) {
      stopButton = false;
      return false;
    }
    if (binaryTree.root == null) {
      stopButton = false;
      return false;
    } else {
      nextNode.add(binaryTree.root!);
    }

    while (nextNode.isNotEmpty) {
      if (stop) {
        stopButton = false;
        return false;
      }
      Node node = nextNode.removeLast();
      if (value == node.value) {
        node.found = true;
        notifyListeners();
        await Future.delayed(Duration(milliseconds: _animationSpeed));
        node.found = false;
        stopButton = false;
        return true;
      } else {
        node.highlight = true;
        notifyListeners();
        await Future.delayed(Duration(milliseconds: _animationSpeed));
        node.highlight = false;

        if (node.right != null) {
          nextNode.add(node.right!);
        }

        if (node.left != null) {
          nextNode.add(node.left!);
        }
      }
    }
    stopButton = false;
    return false;
  }
}
