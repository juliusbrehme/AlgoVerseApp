import 'dart:collection';

import 'package:algo_verse_app/algorithms/path_finding/pathfinding_strategy.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';

class Dijkstra extends PathFindingStrategy {
  Dijkstra({
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
    Map<Node, Node> prevNodes = HashMap();
    List<Node> visitedNodes = [];

    // create an adjacentMatrix
    List<List<int>> adjacentMatrix = List<List<int>>.generate(boardSize.y,
        (i) => List<int>.generate(boardSize.x, (index) => -1, growable: false),
        growable: false);

    adjacentMatrix[coordinator.startNode.y][coordinator.startNode.x] = 0;

    List<Node> nextNodes = [];
    nextNodes.add(startingNode);

    // pathfinding algorithm, we will look at every node and don't stop early
    while (nextNodes.isNotEmpty) {
      Node node = nextNodes.removeAt(0);
      visitedNodes.add(node);
      coordinator.addVisitedNodeNode(node);
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
      //vistedNodeMap.put(node, 1);
      List<Node> neighbors =
          getNeighbors(node, obstacles, visitedNodes, boardSize);
      for (Node neighbor in neighbors) {
        if (adjacentMatrix[neighbor.y][neighbor.x] >
                adjacentMatrix[node.y][node.x] + 1 ||
            adjacentMatrix[neighbor.y][neighbor.x] == -1) {
          adjacentMatrix[neighbor.y][neighbor.x] =
              adjacentMatrix[node.y][node.x] + 1;
          prevNodes[neighbor] = node;
          if (neighbor == endingNode) {}
        }
        // already visited and we do not need to visit again
        if (visitedNodes.contains(neighbor) == false) {
          // possible already in nextNodes
          if (!nextNodes.contains(neighbor)) {
            nextNodes.add(neighbor);
          }
        }
      }
    }

    reconstructPath(
        startingNode, endingNode, visitedNodes, prevNodes, coordinator);
    return;
  }
}
