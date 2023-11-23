import 'package:algo_verse_app/algorithms/path_finding/dfs.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/visualize_button.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';
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
            print("Dijkstra");
          },
          algorithm: "Dijkstra",
        ),
        AlgorithmButton(
          onPressed: () async {
            DFS dfs = DFS(
              startingNode: coordinator.startNode,
              endingNode: coordinator.endingNode,
              obstacles: coordinator.allObstacles,
              boardSize: coordinator.size,
            );
            dfs.findPath(coordinator);
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
