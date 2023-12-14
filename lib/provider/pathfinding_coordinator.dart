import 'dart:math';

import 'package:algo_verse_app/algorithms/path_finding/location.dart';
import 'package:algo_verse_app/algorithms/path_finding/node.dart';
import 'package:algo_verse_app/algorithms/path_finding/path_history.dart';
import 'package:algo_verse_app/provider/speed.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class PathFindingCoordinator extends ChangeNotifier {
  final Location _size;
  // Stores the starting and ending node
  final List<Node> _nodes = [];
  List<Node> _obstacle = [];
  List<Node> _visitedNodes = [];
  List<Node> _path = [];
  List<PathHistory> _history = [];
  int _animationSpeed = 150;
  Enum _speed = Speed.slow;
  bool _stop = false;
  bool _stopButton = false;

  PathFindingCoordinator(this._size) {
    /* starting Node */
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
    /* ending Node */
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

  int get animationSpeed => _animationSpeed;

  Enum get speed => _speed;

  bool get stop => _stop;

  bool get stopButton => _stopButton;

  List<PathHistory> get history => _history;

  /// Get either the starting or ending node, depending on the location [x] and [y].
  Node? getNode(int x, int y) {
    return _nodes.firstWhereOrNull((p) => x == p.x && y == p.y);
  }

  /// Get obstacle node, depending on the location [x] and [y].
  Node? getObstacle(int x, int y) {
    return _obstacle
        .firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  /// Get visited node, depending on the location [x] and [y].
  Node? getVisitedNode(int x, int y) {
    return _visitedNodes
        .firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  /// Get path node, depending on the location [x] and [y].
  Node? getPathNode(int x, int y) {
    return _path
        .firstWhereOrNull((element) => x == element.x && y == element.y);
  }

  /// Change either start node or end node.
  ///
  /// Change either start node to [newNode] or change end node to [newNode] depending if [oldNode] is the
  /// start or end node.
  void changeNode(Node newNode, Node oldNode) {
    if (oldNode == startNode) {
      _nodes[0] = newNode;
    } else {
      _nodes[1] = newNode;
    }
  }

  void addObstacle(Node node) {
    _obstacle.add(node);
    notifyListeners();
  }

  void removeObstacle(Node node) {
    _obstacle.remove(node);
    notifyListeners();
  }

  bool isObstacle(Node node) {
    return _obstacle.contains(node);
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

  void setSpeed() {
    switch (_speed) {
      case Speed.fast:
        _speed = Speed.slow;
        _animationSpeed = 150;
      case Speed.slow:
        _speed = Speed.fast;
        _animationSpeed = 35;
    }
    notifyListeners();
  }

  void resetPath() {
    _visitedNodes = [];
    _path = [];
    notifyListeners();
  }

  void reset() {
    _nodes[0] = Node(
      location: Location((_size.x - 1) ~/ 2, 1),
      size: Location(_size.x, _size.y),
      icon: const Icon(
        Icons.expand_more,
        size: 35,
      ),
    );
    _nodes[1] = Node(
      location: Location((_size.x - 1) ~/ 2, _size.y - 2),
      size: Location(_size.x, _size.y),
      icon: const Icon(
        Icons.adjust,
        size: 35,
      ),
    );
    _obstacle = [];
    _visitedNodes = [];
    _path = [];
    notifyListeners();
  }

  set stopButton(bool boolean) {
    _stopButton = boolean;
    notifyListeners();
  }

  set stop(bool boolean) {
    _stop = boolean;
    notifyListeners();
  }

  void addToHistory(PathHistory pathHistory) {
    _history.insert(0, pathHistory);
    notifyListeners();
  }

  void clearHistory() {
    _history = [];
    notifyListeners();
  }

  // This methods creates a random maze, but this maze is sometimes not solvable and also does not utilize the best space.
  //Should be updated. Also it would be possible and easy to make an animation to visualize how the maze is generated.
  void createRandomMaze() {
    /* set nodes of board */
    _nodes[0] = Node(location: Location(size.x + 1, size.y + 1));
    _nodes[1] = Node(location: Location(size.x + 2, size.y + 2));
    _obstacle = [];
    _visitedNodes = [];
    _path = [];

    int x = size.x;
    int y = size.y;

    /* make every node an obstacle */
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        addObstacle(Node(location: Location(i, j)));
      }
    }

    Node startNode = Node(
        location:
            Location(Random().nextInt(x - 2) + 1, Random().nextInt(y - 2) + 1));
    removeObstacle(startNode);

    print("StartNode: $startNode");

    List<Node> nextNodes = getNeighbors(startNode);

    Node prevNode = startNode;

    while (nextNodes.isNotEmpty) {
      nextNodes.shuffle();
      Node node = nextNodes.removeLast();

      if (!isNotEdge(node)) {
        continue;
      }

      /* set the new path */
      removeObstacle(node);
      removeObstacle(connectedNode(prevNode, node));

      nextNodes.addAll(getNeighbors(node));
      prevNode = node;
    }

    for (int i = 1; i < size.y - 1; i++) {
      for (int j = 0; j < size.x; j++) {
        Node startNode = Node(
            location: Location(j, i),
            icon: const Icon(
              Icons.expand_more,
              size: 35,
            ));
        if (!isObstacle(startNode)) {
          _nodes[0] = startNode;
          i = size.y;
          break;
        }
      }
    }

    for (int i = size.y - 2; i > 1; i--) {
      for (int j = size.x - 2; j > 1; j--) {
        Node endNode = Node(
          location: Location(j, i),
          icon: const Icon(
            Icons.adjust,
            size: 35,
          ),
        );
        if (!isObstacle(endNode)) {
          _nodes[1] = endNode;
          i = 0;
          break;
        }
      }
    }
    notifyListeners();
  }

  List<Node> getNeighbors(Node node) {
    List<Node> neighbors = [];
    Node north = Node(location: Location(node.x, node.y + 2));
    Node south = Node(location: Location(node.x, node.y - 2));
    Node west = Node(location: Location(node.x - 2, node.y));
    Node east = Node(location: Location(node.x + 2, node.y));

    if (north.x > 0 &&
        north.y > 0 &&
        north.x < size.x &&
        north.y < size.y &&
        isObstacle(north) &&
        isNotEdge(north)) {
      neighbors.add(north);
    }
    if (south.x > 0 &&
        south.y > 0 &&
        south.x < size.x &&
        south.y < size.y &&
        isObstacle(south) &&
        isNotEdge(south)) {
      neighbors.add(south);
    }
    if (west.x > 0 &&
        west.y > 0 &&
        west.x < size.x &&
        west.y < size.y &&
        isObstacle(west) &&
        isNotEdge(west)) {
      neighbors.add(west);
    }
    if (east.x > 0 &&
        east.y > 0 &&
        east.x < size.x &&
        east.y < size.y &&
        isObstacle(east) &&
        isNotEdge(east)) {
      neighbors.add(east);
    }
    return neighbors;
  }

  bool isNotEdge(Node node) {
    return (node.x > 0 &&
        node.x < size.x - 1 &&
        node.y > 0 &&
        node.y < size.y - 1);
  }

  Node connectedNode(Node prevNode, Node node) {
    if (node.x > prevNode.x) {
      return Node(location: Location(node.x - 1, node.y));
    } else if (node.x < prevNode.x) {
      return Node(location: Location(node.x + 1, node.y));
    } else if (node.y > prevNode.y) {
      return Node(location: Location(node.x, node.y - 1));
    } else {
      return Node(location: Location(node.x, node.y + 1));
    }
  }
}
