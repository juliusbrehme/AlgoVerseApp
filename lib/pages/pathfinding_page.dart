import 'package:algo_verse_app/components/path_finding/game_coordinator.dart';
import 'package:flutter/material.dart';

class PathFindingPage extends StatefulWidget {
  const PathFindingPage({super.key});

  @override
  State<PathFindingPage> createState() => _PathFindingPageState();
}

class _PathFindingPageState extends State<PathFindingPage> {
  late final double tileWidth = MediaQuery.of(context).size.width / 12.0;

  final int col = 20;
  final int row = 12;

  GameCoordinator coordinator =
      GameCoordinator.createGameCoordinator(Location(20, 12));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 4,
        ),
        _buildGrid(),
      ],
    );
  }

  Widget _buildGrid() {
    return Column(
      children: [
        ...List.generate(
          // Maybe change the tiles down?
          col,
          (y) => Row(
            children: [
              ...List.generate(
                row,
                (x) => _buildDragTarget(x, y),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDragTarget(int x, int y) {
    return DragTarget<Node>(
      onAccept: (node) {
        final capturedNode = coordinator.getNode(x, y);

        setState(() {
          node.location = Location(x, y);
          if (capturedNode != null) {
            coordinator.removeNode(capturedNode);
          }
        });
      },
      onWillAccept: (node) {
        if (node == null) {
          return false;
        }

        return node.canMoveTo(x, y, Location(row, col), coordinator.allNodes,
            coordinator.allObstacles);
      },
      builder: (context, data, rejects) => Container(
        width: tileWidth,
        height: tileWidth,
        decoration: _buildTileDecoration(),
        child: _buildNode(x, y),
      ),
    );
  }

  Decoration _buildTileDecoration() {
    return const BoxDecoration(
      color: Color.fromRGBO(231, 230, 230, 1),
      border: Border(
        top: BorderSide(
          color: Color.fromARGB(255, 79, 115, 156),
          width: 0.5,
        ),
        bottom: BorderSide(
          color: Color.fromARGB(255, 79, 115, 156),
          width: 0.5,
        ),
        right: BorderSide(
          color: Color.fromARGB(255, 79, 115, 156),
          width: 0.5,
        ),
        left: BorderSide(
          color: Color.fromARGB(255, 79, 115, 156),
          width: 0.5,
        ),
      ),
    );
  }

  Widget? _buildNode(int x, int y) {
    final Node? node = coordinator.getNode(x, y);
    if (node != null) {
      final Widget? icon = node.getIcon();
      if (icon != null) {
        final Widget child = icon;
        return Draggable<Node>(
          data: node,
          feedback: child,
          childWhenDragging: const SizedBox.shrink(),
          child: child,
        );
      }
    }
    return null;
  }
}
