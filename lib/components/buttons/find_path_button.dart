import 'package:algo_verse_app/algorithms/path_finding/astar.dart';
import 'package:algo_verse_app/algorithms/path_finding/bfs.dart';
import 'package:algo_verse_app/algorithms/path_finding/dfs.dart';
import 'package:algo_verse_app/algorithms/path_finding/dijkstra.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/visualize_button.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindPathButton extends StatelessWidget {
  const FindPathButton({super.key});

  @override
  Widget build(BuildContext context) {
    PathFindingCoordinator coordinator =
        Provider.of<PathFindingCoordinator>(context, listen: false);
    return VisualizeButton(
      distance: 80,
      children: [
        AlgorithmButton(
          onPressed: () {
            Dijkstra dijkstra = Dijkstra(
              startingNode: coordinator.startNode,
              endingNode: coordinator.endingNode,
              obstacles: coordinator.allObstacles,
              boardSize: coordinator.size,
            );
            dijkstra.findPath(coordinator);
          },
          algorithm: "Dijkstra",
        ),
        AlgorithmButton(
          onPressed: () {
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
            BFS bfs = BFS(
              startingNode: coordinator.startNode,
              endingNode: coordinator.endingNode,
              obstacles: coordinator.allObstacles,
              boardSize: coordinator.size,
            );
            bfs.findPath(coordinator);
          },
          algorithm: "BFS",
        ),
        AlgorithmButton(
          onPressed: () {
            Astar astar = Astar(
              startingNode: coordinator.startNode,
              endingNode: coordinator.endingNode,
              obstacles: coordinator.allObstacles,
              boardSize: coordinator.size,
            );
            astar.findPath(coordinator);
          },
          algorithm: "Astar",
        ),
      ],
    );
  }
}
