import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

// Game Coordinator should be providor and provide all the important stuff, the nodes (start/end node),
// obstacles, path (updated when generated) and visited nodes (updated when generated)
// if any changes happen here, the page will reload. If an algorithm is finished, the results should be
// added to the game coordinator

class PathFindingCoordinator extends ChangeNotifier {
  final List<Node> _nodes = [];
  List<Node> _obstacle = [];
  List<Node> _visitedNodes = [];
  List<Node> _path = [];

  final Location _size;

  PathFindingCoordinator(this._size) {
    // starting Node
    _nodes.add(
      Node(
        location: Location((_size.x - 1) ~/ 2, 1),
        size: Location(_size.x, _size.y),
        icon: const Icon(
          Icons.expand_more,
          size: 35,
        ),
      ),
    );
    // ending Node
    _nodes.add(
      Node(
        location: Location((_size.x - 1) ~/ 2, _size.y - 2),
        size: Location(_size.x, _size.y),
        icon: const Icon(
          Icons.adjust,
          size: 35,
        ),
      ),
    );
  }

  Node get startNode => _nodes.first;

  Node get endingNode => _nodes.last;

  Location get size => _size;

  List<Node> get allNodes => _nodes;

  List<Node> get allObstacles => _obstacle;

  List<Node> get allVisitedNodes => _visitedNodes;

  List<Node> get allPathNodes => _path;

  // Get start or ending node
  Node? getNode(int x, int y) {
    return _nodes.firstWhereOrNull((p) => x == p.x && y == p.y);
  }

  // Get obstacle node
  Node? getObstacle(int x, int y) {
    return _obstacle
        .firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  // Get visitedNode node
  Node? getVisitedNode(int x, int y) {
    return _visitedNodes
        .firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  // Get path node
  Node? getPathNode(int x, int y) {
    return _path
        .firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  // for dragging nodes
  void addNode(Node node) {
    _nodes.add(node);
    notifyListeners();
  }

  // for dragging nodes
  void removeNode(Node node) {
    _nodes.remove(node);
  }

  void addObstacle(Node node) {
    _obstacle.add(node);
    notifyListeners();
  }

  void removeObstacle(Node node) {
    _obstacle.remove(node);
    notifyListeners();
  }

  // for testing with walls, this will probably change
  void addAllObstacle(List<Node> nodes) {
    _obstacle = nodes;
    notifyListeners();
  }

  void addVisitedNodes(List<Node> nodes) {
    _visitedNodes = nodes;
    notifyListeners();
  }

  void addPath(List<Node> nodes) {
    _path = nodes;
    notifyListeners();
  }

  void addPathNode(Node node) {
    _path.add(node);
    notifyListeners();
  }

  void addVisitedNodeNode(Node node) {
    _visitedNodes.add(node);
    notifyListeners();
  }
}

class Location {
  final int _x;
  final int _y;

  Location(this._x, this._y);

  int get x => _x;
  int get y => _y;

  @override
  int get hashCode => _x.hashCode ^ _y.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Location && (_x == other.x && _y == other.y);
  }

  @override
  String toString() => "Location($_x, $_y)";
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
