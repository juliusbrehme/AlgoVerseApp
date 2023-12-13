import 'package:algo_verse_app/algorithms/path_finding/location.dart';
import 'package:flutter/material.dart';

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
  String toString() => "(${location.x}, ${location.y})";

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
