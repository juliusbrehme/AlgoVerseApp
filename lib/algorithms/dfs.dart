import 'dart:collection';

import 'package:algo_verse_app/algorithms/pathfinding_strategy.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';

/// Implementation of BFS algorithm.
class DFS extends PathFindingStrategy {
  DFS({
    required this.startingNode,
    required this.endingNode,
    required this.obstacles,
    required this.boardSize,
  });

  final Node startingNode;
  final Node endingNode;
  final List<Node> obstacles;
  final Location boardSize;

  @override
  Future<void> findPath(PathFindingCoordinator coordinator) async {
    if (startingNode == endingNode) {
      return;
    }

    List<Node> nextNode = [];
    nextNode.add(startingNode);
    List<Node> visitedNodes = [];
    Map<Node, Node> parent = HashMap();

    while (nextNode.isNotEmpty) {
      Node node = nextNode.removeLast();
      visitedNodes.add(node);
      coordinator.addVisitedNodeNode(node);
      await Future.delayed(const Duration(milliseconds: 200));
      List<Node> neighbors =
          getNeighbors(node, obstacles, visitedNodes, boardSize);
      for (Node neighbor in neighbors) {
        parent[neighbor] = node;
        // neighbor is not in visited, because of getNeighbor function
        if (!nextNode.contains(neighbor)) {
          if (endingNode == neighbor) {
            visitedNodes.add(neighbor);
            coordinator.addVisitedNodeNode(neighbor);
            reconstructPath(
                startingNode, endingNode, visitedNodes, parent, coordinator);
            return;
          }
          nextNode.add(neighbor);
        }
      }
    }
  }
}
