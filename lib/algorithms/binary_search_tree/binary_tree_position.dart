import 'dart:collection';
import 'dart:math';

import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';

abstract class BinaryTreePosition {
  int nodeSize;
  double siblingDistance;
  double treeDistance;
  double screenWidth;

  BinaryTreePosition(
      this.nodeSize, this.siblingDistance, this.treeDistance, this.screenWidth);

  /// Calculates all the nodes position of the tree.
  void calculateNodePositions(Node? root) {
    if (root != null) {
      initializeNode(root, 0);
      calculateInitalX(root);
      //checkAllChildrenOnScreen(root);
      calculatePositions(root, 0);
      double movingFactor = root.x < (screenWidth / 2)
          ? screenWidth / 2 - root.x
          : -(root.x - screenWidth / 2);
      calculateFinalPosition(root, movingFactor);
      checkAllChildrenOnScreen(root);
    }
  }

  /// The x value of each node will be set to zero and the y value will be set to the level of the node in the tree.
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

  /// The x value will be updated to 0 or 1, depending if the tree is a left or right child.
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

  /// Checks if two subtrees overlap.
  /// 
  /// Takes the rightmost nodes postions of the left subtree and checks if the leftmost nodes position of the
  /// right subtree overlap. If they do, a shiftvalue will be calculated and added to the right subtree's nodes.
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

  /// Checks if all nodes are visible on the screen.
  /// 
  /// Selects the leftmost node in a tree and checks if the position is grater 0. The tree's node will be updated 
  /// by the leftmost node position * -1 + [nodeSize].
  void checkAllChildrenOnScreen(Node? root) {
    Node? node = root;
    if (node == null) {
      return;
    }
    while (node!.left != null) {
      node = node.left;
    }

    double shiftValue = 0;

    if (node.x <= 0) {
      shiftValue = node.x * -1 + nodeSize + 10;

      List<Node> nextNode = [];
      if (root == null) {
        return;
      } else {
        nextNode.add(root);
      }
      while (nextNode.isNotEmpty) {
        Node node = nextNode.removeAt(0);
        node.x += shiftValue;
        if (node.left != null) {
          nextNode.add(node.left!);
        }
        if (node.right != null) {
          nextNode.add(node.right!);
        }
      }
      return;
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
}
