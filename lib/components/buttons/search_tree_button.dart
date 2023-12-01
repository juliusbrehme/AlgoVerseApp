import 'package:algo_verse_app/components/buttons/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/visualize_button.dart';
import 'package:algo_verse_app/provider/binary_search_tree_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTreeButton extends StatelessWidget {
  const SearchTreeButton({super.key});

  @override
  Widget build(BuildContext context) {
    BinarySearchTreeCoordinator coordinator =
        Provider.of<BinarySearchTreeCoordinator>(context, listen: false);
    return VisualizeButton(
      distance: 80,
      children: [
        AlgorithmButton(
          onPressed: () {
            coordinator.dfs(coordinator.getSearchValue()!);
          },
          algorithm: "DFS",
        ),
        AlgorithmButton(
          onPressed: () {
            coordinator.bfs(coordinator.getSearchValue()!);
          },
          algorithm: "BFS",
        ),
        AlgorithmButton(
          onPressed: () {
            coordinator.binarySearch(coordinator.getSearchValue()!);
          },
          algorithm: "BinarySearch",
        ),
      ],
    );
  }
}
