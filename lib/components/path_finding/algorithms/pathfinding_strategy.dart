import 'package:algo_verse_app/components/path_finding/pathfinding_coordinator.dart';
import 'package:collection/collection.dart';

/// The interface for the Strategy. Every new implemented path finding strategy
/// should implement this interface.
abstract class PathFindingStrategy {
  /// This method is generating the path of the path finding algorithm.
  ///
  /// @param board Holds the information of the board.
  /// @return Returns a record of Path, which holds the path and the visited nodes
  List<List<Node>> findPath();

  /// This method is to generate the next neighbors for the path finding algorithm.
  ///
  /// @param node         The node to generate the neighbors from
  /// @param wall         All obstacles, those nodes can not be visited or used
  /// @param visitedNodes All already visited nodes
  /// @param boardSize    The size of the board
  /// @return Returns a list of all neighbors, that still need to be visited
  List<Node> getNeighbors(
      Node node, List<Node> wall, List<Node> visitedNodes, Location boardSize) {
    // if we allow weighted nodes, implement getNeighbors with a priorityQueue (heap),
    // so that we use a priority as an attribute getNeighbors updates that priorityQueue.
    // Changes need to be made to findPath as well

    List<Node> neighbors = [];
    if (0 <= node.x &&
        node.x < boardSize.x &&
        0 <= node.y - 1 &&
        node.y - 1 < boardSize.y) {
      Node neighbor = Node(location: Location(node.x, node.y - 1));
      if (wall.firstWhereOrNull(((element) =>
                  element.x == neighbor.x && element.y == neighbor.y)) ==
              null &&
          visitedNodes.firstWhereOrNull((element) =>
                  element.x == neighbor.x && element.y == neighbor.y) ==
              null) {
        neighbors.add(neighbor);
      }
    }
    if (0 <= node.x - 1 &&
        node.x - 1 < boardSize.x &&
        0 <= node.y &&
        node.y < boardSize.y) {
      Node neighbor = Node(location: Location(node.x - 1, node.y));
      if (wall.firstWhereOrNull(((element) =>
                  element.x == neighbor.x && element.y == neighbor.y)) ==
              null &&
          visitedNodes.firstWhereOrNull((element) =>
                  element.x == neighbor.x && element.y == neighbor.y) ==
              null) {
        neighbors.add(neighbor);
      }
    }
    if (0 <= node.x &&
        node.x < boardSize.x &&
        0 <= node.y + 1 &&
        node.y + 1 < boardSize.y) {
      Node neighbor = Node(location: Location(node.x, node.y + 1));
      if (wall.firstWhereOrNull(((element) =>
                  element.x == neighbor.x && element.y == neighbor.y)) ==
              null &&
          visitedNodes.firstWhereOrNull((element) =>
                  element.x == neighbor.x && element.y == neighbor.y) ==
              null) {
        neighbors.add(neighbor);
      }
    }
    if (0 <= node.x + 1 &&
        node.x + 1 < boardSize.x &&
        0 <= node.y &&
        node.y < boardSize.y) {
      Node neighbor = Node(location: Location(node.x + 1, node.y));
      if (wall.firstWhereOrNull(((element) =>
                  element.x == neighbor.x && element.y == neighbor.y)) ==
              null &&
          visitedNodes.firstWhereOrNull((element) =>
                  element.x == neighbor.x && element.y == neighbor.y) ==
              null) {
        neighbors.add(neighbor);
      }
    }
    return neighbors;
  }

  /// Method to reconstruct the Path from memory.
  ///
  /// @param startingNode The starting node
  /// @param endingNode   The ending node
  /// @param visitedNodes The visited nodes in sequence
  /// @param parent       The memory of which node is the parent node
  /// @return Return the path and the sequence of visited nodes
  List<List<Node>> reconstructPath(Node startingNode, Node endingNode,
      List<Node> visitedNodes, Map<Node, Node> parent) {
    Node node = endingNode;
    List<Node> path = [];
    // check if a solution exist
    if (parent[node] == null) {
      return [[], visitedNodes];
    }

    while (node != startingNode) {
      path.insert(0, node);
      // it should never be null
      Node? nodeOrNull = parent[node];
      if (nodeOrNull != null) {
        node = nodeOrNull;
      }
    }
    path.insert(0, startingNode);

    return [path, visitedNodes];
  }
}
