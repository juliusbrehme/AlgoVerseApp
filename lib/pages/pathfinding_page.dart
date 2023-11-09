import 'package:algo_verse_app/components/path_finding/pathfinding_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// sollte irgendwie zum consumer werden, damit wenn beim coordinator sich der path ändert hier dann
// angezeigt werden kann

class PathFindingPage extends StatefulWidget {
  const PathFindingPage({super.key});

  @override
  State<PathFindingPage> createState() => _PathFindingPageState();
}

class _PathFindingPageState extends State<PathFindingPage> {
  late final double tileWidth = MediaQuery.of(context).size.width / 12.0;

  final int col = 20;
  final int row = 12;

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
    return Consumer<PathFindingCoordinator>(
      builder: (context, coordinator, child) => Column(
        children: [
          ...List.generate(
            // Maybe change the tiles down?
            col,
            (y) => Row(
              children: [
                ...List.generate(
                  row,
                  (x) => _buildDragTarget(x, y, coordinator),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // start und end node sind die einzigen nodes auf dem feld, da path visited und obstacle nur die farbe der tile geändert wird
  Widget _buildDragTarget(int x, int y, PathFindingCoordinator coordinator) {
    return DragTarget<Node>(
      onAccept: (node) {
        setState(() {
          coordinator.removeNode(node);
          coordinator
              .addNode(Node(location: Location(x, y), icon: node.getIcon()));
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
        decoration: _buildTileDecoration(x, y, coordinator),
        child: _buildNode(x, y, coordinator),
      ),
    );
  }

  // wenn mit animation nochmal neu gucken, denn dann werden ja path und visited node eventuell anders generiert und obstacle sowieso
  // da dies mit drag passiert, also vllt ähnlich wie bei starting end node
  Decoration _buildTileDecoration(
      int x, int y, PathFindingCoordinator coordinator) {
    final Node? wall = coordinator.getObstacle(x, y);
    final Node? visited = coordinator.getVisitedNode(x, y);
    final Node? path = coordinator.getPathNode(x, y);
    Color tileColor = const Color.fromRGBO(231, 230, 230, 1);

    if (wall != null) {
      tileColor = Colors.black;
    } else if (visited != null) {
      tileColor = const Color.fromRGBO(175, 216, 248, 1);
    }
    if (path != null) {
      tileColor = const Color.fromRGBO(239, 237, 295, 1);
    }

    return BoxDecoration(
      color: tileColor,
      border: const Border(
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

  // hier dann auch path und visited nodes rein bauen? Vllt erstmal am anfang und dann mal gucken,
  // je nachdem wie es mit der animation funktioniert. Am anfang um erstmal zu testen ob die
  // die richtigen sachen auszuprobieren
  Widget? _buildNode(int x, int y, PathFindingCoordinator coordinator) {
    // hier dann auch nach walls fragen falls beim coordinator null ist
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
