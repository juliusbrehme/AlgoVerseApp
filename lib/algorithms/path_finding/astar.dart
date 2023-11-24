import 'dart:collection';

import 'package:algo_verse_app/algorithms/path_finding/pathfinding_strategy.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';

class Astar extends PathFindingStrategy {
  Astar({
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
      coordinator.setStopButton(false);
      return;
    }
    if (startingNode == endingNode) {
      coordinator.addPathNode(startingNode);
      return;
    }

    List<_Tuple> nextNode = [];
    nextNode.add(_Tuple(startingNode, 0, 0));

    List<Node> visitedNodes = [];
    Map<Node, Node> parent = HashMap();

    while (nextNode.isNotEmpty) {
      if (coordinator.stop) {
        coordinator.setStopButton(false);
        return;
      }
      _Tuple nextTuple = nextNode.removeAt(0);
      Node node = nextTuple.node;
      visitedNodes.add(node);
      coordinator.addVisitedNodeNode(node);
      await Future.delayed(Duration(milliseconds: coordinator.animationSpeed));

      if (node == endingNode) {
        reconstructPath(
            startingNode, endingNode, visitedNodes, parent, coordinator);
        return;
      }
      List<Node> neighbors =
          getNeighbors(node, obstacles, visitedNodes, boardSize);

      for (Node neighbor in neighbors) {
        if (coordinator.stop) {
          coordinator.setStopButton(false);
          return;
        }
        // cost and dist is irrelevant for equality, check if node is in nextNode
        if (!nextNode.contains(_Tuple(neighbor, 0, 0))) {
          parent[neighbor] = node;
          nextNode.add(_Tuple(neighbor, nextTuple.cost + 1,
              _heuristicFunction(neighbor, endingNode)));
        } else {
          int index = nextNode.indexOf(_Tuple(neighbor, 0, 0));
          _Tuple tuple = nextNode[index];
          // if better less cost, change parent and update to nextNode
          if (tuple.cost > nextTuple.cost + 1) {
            parent[neighbor] = node;
            nextNode.add(_Tuple(neighbor, nextTuple.cost + 1,
                _heuristicFunction(neighbor, endingNode)));
          }
        }
        // sort nextNode, so the first element is the best choice
        nextNode.sort();
      }
    }
    reconstructPath(
        startingNode, endingNode, visitedNodes, parent, coordinator);
    return;
  }

  /// Calculates the manhattan distance.
  ///
  /// @param startNode The starting point
  /// @param endNode   The ending point
  /// @return Returns the distance
  int _heuristicFunction(Node startNode, Node endNode) {
    return (startNode.x - endNode.x).abs() + (startNode.y - endNode.y).abs();
  }
}

class _Tuple implements Comparable<_Tuple> {
  final Node _node;
  final int _cost;
  final int _dist;

  _Tuple(this._node, this._cost, this._dist);

  Node get node => _node;

  int get cost => _cost;

  int get dist => _dist;

  // The manhattan distance plus the cost is the comparing factor
  @override
  int compareTo(_Tuple tuple) {
    return (cost + dist).compareTo(tuple.cost + tuple.dist);
  }

  // we need equals only to check if a certain node is in the nextNode list. Therefore, we care
  // only about the coordinate and not the cost or dist
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }
    if (o is! _Tuple) {
      return false;
    }
    return o.node == node;
  }

  @override
  int get hashCode => Object.hash(node, cost);

  @override
  String toString() {
    return "$_node $_cost $_dist";
  }
}
