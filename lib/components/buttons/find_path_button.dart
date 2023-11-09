import 'package:algo_verse_app/components/buttons/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/visualize_button.dart';
import 'package:algo_verse_app/components/path_finding/algorithms/dfs.dart';
import 'package:algo_verse_app/components/path_finding/pathfinding_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPathButton extends StatelessWidget {
  const FindPathButton({super.key});

// das wird zum consumer oder so, der dann auf pathfindingcontroller zu greifen kann. dann wird hier
// mit den sachen auch pathfindingcoordintor die entsprechende funktion aufgerufen und dann coordinator
// geupdatet -> dadurch werden alle consumer geupdatet, also sollte sich die page updaten

  @override
  Widget build(BuildContext context) {
    return Consumer<PathFindingCoordinator>(
      builder: (context, coordinator, child) => VisualizeButton(
        distance: 80,
        children: [
          AlgorithmButton(
            onPressed: () {
              // call dijkstra and update path and visited -> it will be printed to screen
              List<Node> nodes = [
                Node(location: Location(0, 0)),
                Node(location: Location(1, 1)),
                Node(location: Location(1, 2)),
                Node(location: Location(2, 2)),
                Node(location: Location(3, 2)),
                Node(location: Location(4, 2)),
                Node(location: Location(5, 2)),
                Node(location: Location(6, 2)),
                Node(location: Location(7, 2)),
                Node(location: Location(8, 2)),
                Node(location: Location(9, 2)),
                Node(location: Location(10, 2)),
              ];
              coordinator.addAllObstacle(nodes);
            },
            algorithm: "Dijkstra",
          ),
          AlgorithmButton(
            onPressed: () {
              DFS dfs = DFS(
                startingNode: coordinator.getStartNode,
                endingNode: coordinator.getEndingNode,
                obstacles: coordinator.getAllObstacles,
                boardSize: coordinator.getSize,
              );
              List<List<Node>> pathInformation = dfs.findPath();
              coordinator.addVisitedNodes(pathInformation.last);
              coordinator.addPath(pathInformation.first);
            },
            algorithm: "DFS",
            //closeFabOnTap: true,
          ),
          AlgorithmButton(
            onPressed: () {
              print("BFS");
            },
            algorithm: "BFS",
          ),
          AlgorithmButton(
            onPressed: () {
              print("Astar");
            },
            algorithm: "Astar",
          ),
        ],
      ),
    );
  }
}

class Nodes {}
