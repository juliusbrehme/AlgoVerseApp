import 'dart:collection';

import 'package:algo_verse_app/algorithms/path_finding/pathfinding_strategy.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';

class BFS extends PathFindingStrategy {
  BFS({
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
      coordinator.addPathNode(startingNode);
      return;
    }

    List<Node> nextNode = [];
    nextNode.add(startingNode);
    List<Node> visitedNodes = [];
    Map<Node, Node> parent = HashMap();

    while (nextNode.isNotEmpty) {
      Node node = nextNode.removeAt(0);
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
            await Future.delayed(const Duration(milliseconds: 200));
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
