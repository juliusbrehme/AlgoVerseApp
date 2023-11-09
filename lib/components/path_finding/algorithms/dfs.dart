import 'dart:collection';

import 'package:algo_verse_app/components/path_finding/algorithms/pathfinding_strategy.dart';
import 'package:algo_verse_app/components/path_finding/pathfinding_coordinator.dart';

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

  // I think there is a bug with getNeighbors or how it is put into the nexNode list or something
  @override
  List<List<Node>> findPath() {
    if (startingNode == endingNode) {
      return [
        [startingNode],
        []
      ];
    }

    List<Node> nextNode = [];
    nextNode.add(startingNode);
    List<Node> visitedNodes = [];
    //Map<Node, int> visitedNodesMap = HashMap();
    Map<Node, Node> parent = HashMap();

    while (nextNode.isNotEmpty) {
      Node node = nextNode.removeLast();
      visitedNodes.add(node);
      //visitedNodesMap[node] = 1;
      List<Node> neighbors =
          getNeighbors(node, obstacles, visitedNodes, boardSize);
      for (Node neighbor in neighbors) {
        parent[neighbor] = node;
        // neighbor is not in visited, because of getNeighbor function
        if (!nextNode.contains(neighbor)) {
          if (endingNode == neighbor) {
            visitedNodes.add(neighbor);
            return reconstructPath(
                startingNode, endingNode, visitedNodes, parent);
          }
          nextNode.add(neighbor);
        }
      }
    }

    return [[], visitedNodes];
  }
}
