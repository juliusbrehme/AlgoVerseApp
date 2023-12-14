import 'dart:math';
import 'package:algo_verse_app/algorithms/binary_search_tree/binary_search_tree_history.dart';
import 'package:algo_verse_app/algorithms/binary_search_tree/binary_tree_position.dart';
import 'package:algo_verse_app/provider/binary_search_tree_coordinator.dart';
import 'node.dart';

class BinarySearchTree extends BinaryTreePosition {
  Node? root;

  int size = 0;

  BinarySearchTree({
    this.root,
    required int nodeSize,
    required double siblingDistance,
    required double treeDistance,
    required double screenWidth,
  }) : super(nodeSize, siblingDistance, treeDistance, screenWidth);

  /// Creates a binary tree from a [list].
  ///
  /// To position the tree on the display the [nodeSize], the [siblingsDistance], the [treeDistance] and
  /// the [screenWidth] is needed.
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

  void fromList(List<int> list) {
    for (var element in list) {
      add(element);
      size++;
    }
  }

  void add(int value) {
    root = addRecursive(root, Node(value));
    size++;
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
    size = 0;
  }

  void randomTree() {
    clear();
    fromList(List.generate(
        Random().nextInt(21) + 1, (index) => Random().nextInt(100)));
  }

  Future<bool> bfs(int value, BinarySearchTreeCoordinator coordinator) async {
    List<Node> visitedNodes = [];

    List<Node> nextNode = [];
    if (coordinator.stop) {
      coordinator.stopButton = false;
      return false;
    }
    if (root == null) {
      coordinator.stopButton = false;
      return false;
    } else {
      nextNode.add(root!);
    }

    while (nextNode.isNotEmpty) {
      if (coordinator.stop) {
        coordinator.stopButton = false;
        return false;
      }
      Node node = nextNode.removeAt(0);
      visitedNodes.add(node);
      if (value == node.value) {
        node.found = true;
        coordinator
            .addToHistory(BinarySearchTreeHistory("BFS", visitedNodes, size));
        coordinator.notify();
        await Future.delayed(
            Duration(milliseconds: coordinator.animationSpeed));
        coordinator.stopButton = false;
        return true;
      } else {
        node.highlight = true;
        coordinator.notify();
        await Future.delayed(
            Duration(milliseconds: coordinator.animationSpeed));

        if (node.left != null) {
          nextNode.add(node.left!);
        }

        if (node.right != null) {
          nextNode.add(node.right!);
        }
      }
    }
    coordinator.stopButton = false;
    coordinator
        .addToHistory(BinarySearchTreeHistory("BFS", visitedNodes, size));
    return false;
  }

  Future<bool> dfs(int value, BinarySearchTreeCoordinator coordinator) async {
    List<Node> visitedNodes = [];

    List<Node> nextNode = [];
    if (coordinator.stop) {
      coordinator.stopButton = false;
      return false;
    }
    if (root == null) {
      coordinator.stopButton = false;
      return false;
    } else {
      nextNode.add(root!);
    }

    while (nextNode.isNotEmpty) {
      if (coordinator.stop) {
        coordinator.stopButton = false;
        return false;
      }
      Node node = nextNode.removeLast();
      visitedNodes.add(node);
      if (value == node.value) {
        node.found = true;
        coordinator
            .addToHistory(BinarySearchTreeHistory("DFS", visitedNodes, size));
        coordinator.notify();
        await Future.delayed(
            Duration(milliseconds: coordinator.animationSpeed));
        coordinator.stopButton = false;
        return true;
      } else {
        node.highlight = true;
        coordinator.notify();
        await Future.delayed(
            Duration(milliseconds: coordinator.animationSpeed));

        if (node.right != null) {
          nextNode.add(node.right!);
        }

        if (node.left != null) {
          nextNode.add(node.left!);
        }
      }
    }
    coordinator.stopButton = false;
    coordinator
        .addToHistory(BinarySearchTreeHistory("DFS", visitedNodes, size));
    return false;
  }

  Future<void> binarySearch(
      int value, BinarySearchTreeCoordinator coordinator) async {
    List<Node> visitedNodes = [];
    visitedNodes =
        await searchRecursive(root, value, coordinator, visitedNodes);
    coordinator.addToHistory(
        BinarySearchTreeHistory("BinarySearch", visitedNodes, size));
  }

  Future<List<Node>> searchRecursive(Node? node, int value,
      BinarySearchTreeCoordinator coordinator, List<Node> visitedNodes) async {
    Node? root = node;
    if (coordinator.stop) {
      coordinator.stopButton = false;
      return visitedNodes;
    }
    if (root == null) {
      coordinator.stopButton = false;
      coordinator.notify();
      return visitedNodes;
    } else if (root.value < value) {
      if (coordinator.stop) {
        coordinator.stopButton = false;
        return visitedNodes;
      }
      root.highlight = true;
      coordinator.notify();
      visitedNodes.add(root);
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
      return searchRecursive(root.right, value, coordinator, visitedNodes);
    } else if (root.value > value) {
      if (coordinator.stop) {
        coordinator.stopButton = false;
        return visitedNodes;
      }
      root.highlight = true;
      visitedNodes.add(root);
      coordinator.notify();
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
      return searchRecursive(root.left, value, coordinator, visitedNodes);
    } else {
      if (coordinator.stop) {
        coordinator.stopButton = false;
        return visitedNodes;
      }
      root.found = true;
      visitedNodes.add(root);
      coordinator.notify();
      await Future.delayed(
          Duration(milliseconds: coordinator.animationSpeed + 400));
      coordinator.notify();
      coordinator.stopButton = false;
      return visitedNodes;
    }
  }

  void resetNodes(Node? node) {
    if (node == null) {
      return;
    } else {
      resetNodes(node.left);
      node.highlight = false;
      node.found = false;
      resetNodes(node.right);
    }
  }

  @override
  String toString() {
    List<Node> nodes = [];
    List<Node> nextNode = [];
    if (root == null) {
      return nodes.toString();
    } else {
      nextNode.add(root!);
    }

    while (nextNode.isNotEmpty) {
      Node node = nextNode.removeAt(0);
      nodes.add(node);

      if (node.left != null) {
        nextNode.add(node.left!);
      }

      if (node.right != null) {
        nextNode.add(node.right!);
      }
    }
    return nodes.toString();
  }
}
