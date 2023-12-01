import 'dart:math';

import 'package:algo_verse_app/algorithms/binary_search_tree/binary_tree_position.dart';

import 'node.dart';

class BinarySearchTree extends BinaryTreePosition {
  Node? root;

  BinarySearchTree({
    this.root,
    required int nodeSize,
    required double siblingDistance,
    required double treeDistance,
    required double screenWidth,
  }) : super(nodeSize, siblingDistance, treeDistance, screenWidth);

  factory BinarySearchTree.fromList(List<int> list, int nodeSize,
      double siblingDistance, double treeDistance, double screenWidth) {
    BinarySearchTree tree = BinarySearchTree(
      nodeSize: nodeSize,
      siblingDistance: siblingDistance,
      treeDistance: treeDistance,
      screenWidth: screenWidth,
    );
    tree.fromList(list);
    return tree;
  }

  void add(int value) {
    root = addRecursive(root, Node(value));
  }

  void fromList(List<int> list) {
    for (var element in list) {
      add(element);
    }
  }

  Node addRecursive(Node? root, Node value) {
    Node? node = root;
    if (node == null) {
      return value;
    } else if (node.value < value.value) {
      node.right = addRecursive(node.right, Node(value.value, node));
    } else if (node.value > value.value) {
      node.left = addRecursive(node.left, Node(value.value, node));
    } else {
      return node;
    }
    return node;
  }

  Map<Node, Node> travers() {
    Map<Node, Node> treeMap = {};
    if (root == null) {
      return {};
    } else {
      root!.visit(treeMap, root!);
      return treeMap;
    }
  }

  void clear() {
    root = null;
  }

  void randomTree() {
    clear();
    fromList(List.generate(
        Random().nextInt(21) + 1, (index) => Random().nextInt(100)));
  }
}
