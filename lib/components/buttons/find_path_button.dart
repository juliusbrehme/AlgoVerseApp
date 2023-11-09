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
    PathFindingCoordinator coordinator =
        Provider.of<PathFindingCoordinator>(context, listen: false);
    return VisualizeButton(
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
        // anstatt hier danach eine Liste zurück zu geben, können wir auch bei dem jedes mal ein visited nodes hinzugeführt wird
        // einfach das in coordinator direkt reinwerfen, den consumer notify und dann direkt rebuilden -> animation
        // das ganze dann auch mit path und dann mal gucken wie schnell das so ist und dementsprechende waits einbauen -> unterbrechen
        // nicht möglich (man könnte das im thread laufen lassen  und sonst den thread killen oder sowas) und die waits geben wir als
        // paramater in den jeweiligen algorithmus mit rein damit man theoretisch die geschwindigkeit ändern kann
        AlgorithmButton(
          onPressed: () {
            DFS dfs = DFS(
              startingNode: coordinator.getStartNode,
              endingNode: coordinator.getEndingNode,
              obstacles: coordinator.allObstacles,
              boardSize: coordinator.getSize,
            );
            dfs.findPath(coordinator);
            // List<List<Node>> pathInformation = dfs.findPath(coordinator);
            // coordinator.addVisitedNodes(pathInformation.last);
            // coordinator.addPath(pathInformation.first);
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
    );
  }
}

class Nodes {}
