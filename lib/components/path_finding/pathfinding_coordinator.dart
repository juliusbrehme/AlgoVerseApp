import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// Game Coordinator should be providor and provide all the important stuff, the nodes (start/end node),
// obstacles, path (updated when generated) and visited nodes (updated when generated)
// if any changes happen here, the page will reload. If an algorithm is finished, the results should be
// added to the game coordinator

class PathFindingCoordinator extends ChangeNotifier {
  List<Node> nodes = [];
  List<Node> obstacle = [];
  List<Node> visitedNodes = [];
  List<Node> path = [];

  final Location size;

  PathFindingCoordinator(this.size) {
    // starting Node
    nodes.add(
      Node(
        location: Location(6, 1),
        size: Location(size.x, size.y),
        icon: const Icon(
          Icons.expand_more,
          size: 35,
        ),
      ),
    );
    // ending Node
    nodes.add(
      Node(
        location: Location(6, 18),
        size: Location(size.x, size.y),
        icon: const Icon(
          Icons.adjust,
          size: 35,
        ),
      ),
    );
  }

  Node get getStartNode {
    return nodes.first;
  }

  Node get getEndingNode {
    return nodes.last;
  }

  List<Node> get getAllObstacles {
    return obstacle;
  }

  Location get getSize {
    return size;
  }

  // Get start or ending node
  Node? getNode(int x, int y) {
    return nodes.firstWhereOrNull((p) => x == p.x && y == p.y);
  }

  // Get obstacle node
  Node? getObstacle(int x, int y) {
    return obstacle
        .firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  // Get visitedNode node
  Node? getVisitedNode(int x, int y) {
    return visitedNodes
        .firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  // Get path node
  Node? getPathNode(int x, int y) {
    return path.firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  List<Node> get allNodes => nodes;
  List<Node> get allObstacles => obstacle;

  void addNode(Node node) {
    nodes.add(node);
    notifyListeners();
  }

  void removeNode(Node node) {
    nodes.remove(node);
  }

  // so lassen?
  void addObstacle(Node node) {
    obstacle.add(node);
  }

  void addAllObstacle(List<Node> nodes) {
    obstacle = nodes;
    notifyListeners();
  }

  // so lassen?
  void removeObstacle(Node node) {
    obstacle.remove(node);
  }

  void addVisitedNodes(List<Node> nodes) {
    visitedNodes = nodes;
    notifyListeners();
  }

  // hier auch notifyen?
  void removeVisitedNodes() {
    visitedNodes = [];
    notifyListeners();
  }

  void addPath(List<Node> nodes) {
    path = nodes;
    notifyListeners();
  }

  // hier auch notifyen?
  void removePath() {
    path = [];
    notifyListeners();
  }

  // for debugging
  List<Node> get getAllPath {
    return path;
  }
}

class Location {
  final int x;
  final int y;

  Location(this.x, this.y);

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Location && (x == other.x && y == other.y);
  }

  @override
  String toString() => "Location($x, $y)";
}

class Node {
  final Location location;
  final Widget? icon;
  final Location? size;

  Node({required this.location, this.size, this.icon});

  @override
  int get hashCode => location.x.hashCode ^ location.y.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Node &&
        (location.x == other.location.x && location.y == other.location.y);
  }

  @override
  String toString() => "Location(${location.x}, ${location.y})";

  int get x => location.x;
  int get y => location.y;

  Widget? getIcon() {
    if (icon == null) {
      return null;
    } else {
      return icon;
    }
  }

  bool canMoveTo(
      int x, int y, Location size, List<Node> nodes, List<Node> obstacles) {
    Node nodeLocation = Node(location: Location(x, y));

    return x < size.x &&
        y < size.y &&
        !nodes.contains(nodeLocation) &&
        !obstacles.contains(nodeLocation);
  }
}
