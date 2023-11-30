import 'dart:collection';
import 'dart:math';

import 'node.dart';

class BinarySearchTree {
  Node? root;
  int nodeSize = 56;
  double siblingDistance = 50;
  double treeDistance = 10;
  double screenWidth = 440;

  BinarySearchTree({this.root});

  factory BinarySearchTree.fromList(List<int> list) {
    BinarySearchTree tree = BinarySearchTree();
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
    fromList(
        List.generate(Random().nextInt(21), (index) => Random().nextInt(100)));
  }

  List<Node> bfs() {
    List<Node> result = [];
    List<Node> nextNode = [];
    if (root == null) {
      return result;
    } else {
      nextNode.add(root!);
    }

    while (nextNode.isNotEmpty) {
      Node node = nextNode.removeAt(0);
      result.add(node);

      if (node.left != null) {
        nextNode.add(node.left!);
      }

      if (node.right != null) {
        nextNode.add(node.right!);
      }
    }
    return result;
  }

  void calculateNodePositions() {
    if (root != null) {
      initializeNode(root, 0);
      calculateInitalX(root);
      checkAllChildrenOnScreen(root!);
      calculatePositions(root, 0);
      double movingFactor = root!.x < (screenWidth / 2)
          ? screenWidth / 2 - root!.x
          : root!.x - screenWidth / 2;
      calculateFinalPosition(root, movingFactor);
    }
  }

  void initializeNode(Node? root, int depth) {
    Node? node = root;
    if (node == null) {
      return;
    } else {
      node.x = -1;
      node.y = depth;
      node.mod = 0;

      initializeNode(node.left, depth + 1);
      initializeNode(node.right, depth + 1);
    }
  }

  void calculateInitalX(Node? root) {
    Node? node = root;
    if (node == null) {
      return;
    } else {
      calculateInitalX(node.left);
      calculateInitalX(node.right);

      if (node.isLeaf()) {
        if (node.isLeftChild()) {
          node.x = 0;
        } else {
          node.x = nodeSize + siblingDistance;
        }
      } else if (node.childrenCount() == 1) {
        if (node.left != null) {
          node.x = node.left!.x + ((nodeSize + siblingDistance) / 2);
        } else {
          node.x = node.right!.x - ((nodeSize + siblingDistance) / 2);
        }
      } else {
        node.x = (node.left!.x + node.right!.x) / 2;
      }

      checkForConflicts(node);

      if (!node.isLeaf() && !node.isLeftChild()) {
        checkForConflicts(node);
      }
    }
  }

  void checkForConflicts(Node node) {
    double minDistance = treeDistance + nodeSize;
    double shiftValue = 0;

    if (node.isLeftChild()) {
      return;
    }

    var nodeContour = HashMap<int, double>();
    getLeftContour(node, 0, nodeContour);

    Node? sibling = node.parent!.left;
    var siblingContour = HashMap<int, double>();
    getRightContour(sibling, 0, siblingContour);

    for (int level = node.y;
        level <= min(findMax(siblingContour.keys), findMax(nodeContour.keys));
        level++) {
      var distance = (nodeContour[level]! - siblingContour[level]!);
      if (distance + shiftValue < minDistance) {
        shiftValue = minDistance - distance;
      }
    }
    if (shiftValue > 0) {
      node.x += shiftValue;
      node.mod += shiftValue;
      shiftValue = 0;
    }
  }

  void checkAllChildrenOnScreen(Node node) {
    var nodeCounter = HashMap<int, double>();
    getLeftContour(node, 0, nodeCounter);
    double shiftAmount = 0;
    for (var y in nodeCounter.keys) {
      if (nodeCounter[y]! + shiftAmount < 0) {
        shiftAmount = nodeCounter[y]! * -1;
      }
      if (shiftAmount > 0) {
        node.x += shiftAmount;
        node.mod += shiftAmount;
      }
    }
  }

  void calculatePositions(Node? root, double modSum) {
    Node? node = root;
    if (node == null) {
      return;
    } else {
      node.x += modSum;
      modSum += node.mod;

      calculatePositions(node.left, modSum);
      calculatePositions(node.right, modSum);
    }
  }

  void calculateFinalPosition(Node? root, double movingFactor) {
    Node? node = root;
    if (node == null) {
      return;
    } else {
      node.x += movingFactor;
      calculateFinalPosition(node.left, movingFactor);
      calculateFinalPosition(node.right, movingFactor);
    }
  }

  void getLeftContour(Node? root, double modSum, HashMap<int, double> values) {
    Node? node = root;
    if (node == null) {
      return;
    } else {
      if (!values.containsKey(node.y)) {
        values[node.y] = node.x + modSum;
      } else {
        values[node.y] = min(values[node.y]!, node.x + modSum);
      }

      modSum += node.mod;
      getLeftContour(node.left, modSum, values);
      getLeftContour(node.right, modSum, values);
    }
  }

  void getRightContour(Node? root, double modSum, HashMap<int, double> values) {
    Node? node = root;
    if (node == null) {
      return;
    } else {
      if (!values.containsKey(node.y)) {
        values[node.y] = node.x + modSum;
      } else {
        values[node.y] = max(values[node.y]!, node.x + modSum);
      }
      modSum += node.mod;
      getRightContour(node.left, modSum, values);
      getRightContour(node.right, modSum, values);
    }
  }

  int findMax(Iterable<int> list) {
    int max = 0;
    for (int element in list) {
      if (element > max) {
        max = element;
      }
    }
    return max;
  }

  @override
  String toString() {
    return bfs().toString();
  }
}
