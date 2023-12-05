import 'package:algo_verse_app/components/buttons/action_button.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PathFindingPage extends StatefulWidget {
  const PathFindingPage({super.key});

  @override
  State<PathFindingPage> createState() => _PathFindingPageState();
}

class _PathFindingPageState extends State<PathFindingPage> {
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
            coordinator.size.y,
            (y) => Row(
              children: [
                ...List.generate(
                  coordinator.size.x,
                  (x) => _buildDragTarget(x, y, coordinator),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(51, 74, 100, 1),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    onPressed: () {
                      coordinator.setSpeed();
                    },
                    icon: const Icon(
                      Icons.speed,
                      color: Colors.white,
                    ),
                    label: Text(
                      coordinator.speed.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ActionButton(
                  height: 40,
                  radius: 20,
                  onTap: () => coordinator.stopButton
                      ? null
                      : coordinator.createRandomMaze(),
                  icon: const Icon(
                    Icons.stairs,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ActionButton(
                  height: 40,
                  radius: 20,
                  onTap: () =>
                      coordinator.stopButton ? null : coordinator.reset(),
                  icon: const Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(int x, int y, PathFindingCoordinator coordinator) {
    return DragTarget<Node>(
      onAccept: (node) {
        setState(() {
          coordinator.changeNode(
              Node(location: Location(x, y), icon: node.getIcon()), node);
        });
      },
      onWillAccept: (node) {
        if (node == null) {
          return false;
        }

        return node.canMoveTo(x, y, coordinator.size, coordinator.allNodes,
            coordinator.allObstacles);
      },
      builder: (context, data, rejects) => Container(
        width: MediaQuery.of(context).size.width / coordinator.size.x,
        height: MediaQuery.of(context).size.width / coordinator.size.x,
        decoration: _buildTileDecoration(x, y, coordinator),
        child: _buildNode(x, y, coordinator),
      ),
    );
  }

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

  Widget? _buildNode(int x, int y, PathFindingCoordinator coordinator) {
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
    } else {
      return GestureDetector(
        onTap: () {
          if (coordinator.getObstacle(x, y) == null) {
            coordinator.addObstacle(Node(location: Location(x, y)));
          } else {
            coordinator.removeObstacle(Node(location: Location(x, y)));
          }
        },
      );
    }
    return null;
  }
}
