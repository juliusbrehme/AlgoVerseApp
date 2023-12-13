import 'dart:collection';

import 'package:algo_verse_app/algorithms/path_finding/location.dart';
import 'package:algo_verse_app/algorithms/path_finding/node.dart';
import 'package:algo_verse_app/algorithms/path_finding/path_history.dart';
import 'package:algo_verse_app/algorithms/path_finding/pathfinding_strategy.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';

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
    if (coordinator.stop) {
      coordinator.stopButton = false;
      return;
    }
    if (startingNode == endingNode) {
      coordinator.addPathNode(startingNode);
      return;
    }

    List<Node> nextNode = [];
    nextNode.add(startingNode);
    List<Node> visitedNodes = [];
    Map<Node, Node> parent = HashMap();

    while (nextNode.isNotEmpty) {
      if (coordinator.stop) {
        coordinator.stopButton = false;
        return;
      }
      Node node = nextNode.removeLast();
      if (visitedNodes.contains(node)) {
        continue;
      }
      visitedNodes.add(node);
      coordinator.addVisitedNodeNode(node);
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));
      List<Node> neighbors =
          getNeighbors(node, obstacles, visitedNodes, boardSize);
      for (Node neighbor in neighbors) {
        if (coordinator.stop) {
          coordinator.stopButton = false;
          return;
        }
        parent[neighbor] = node;
        /* neighbor is not in visited, because of getNeighbor function */
        if (endingNode == neighbor) {
          visitedNodes.add(neighbor);
          coordinator.addVisitedNodeNode(neighbor);
          reconstructPath(
              startingNode, endingNode, visitedNodes, parent, coordinator);
          coordinator.addToHistory(PathHistory("DFS", coordinator.startNode,
              coordinator.endingNode, coordinator.allVisitedNodes));
          return;
        }
        nextNode.add(neighbor);
      }
    }
    coordinator.stopButton = false;
    coordinator.addToHistory(PathHistory("DFS", coordinator.startNode,
        coordinator.endingNode, coordinator.allVisitedNodes));
  }
}
