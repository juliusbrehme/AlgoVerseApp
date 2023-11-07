import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class GameCoordinator {
  List<Node> nodes = [];
  List<Node> obstacle = [];

  GameCoordinator._(Location size) {
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

  static GameCoordinator createGameCoordinator(Location size) {
    return GameCoordinator._(size);
  }

  Node? getNode(int x, int y) {
    return nodes.firstWhereOrNull((p) => x == p.x && y == p.y);
  }

  List<Node> get allNodes => nodes;
  List<Node> get allObstacles => obstacle;

  void addNode(Node node) {
    nodes.add(node);
  }

  void removeNode(Node node) {
    nodes.remove(node);
  }

  void addObstacle(Node node) {
    nodes.add(node);
  }

  void removeObstacle(Node node) {
    nodes.remove(node);
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
  Location location;
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
