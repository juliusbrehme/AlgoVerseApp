import 'package:algo_verse_app/components/buttons/visualization_fab/algorithm_buttons.dart';
import 'package:algo_verse_app/components/buttons/visualization_fab/visualize_button.dart';
import 'package:algo_verse_app/provider/binary_search_tree_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTreeButton extends StatelessWidget {
  const SearchTreeButton({super.key});

  Future showException(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Search Value",
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(255, 197, 201, 205),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Please provide a search value.",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok")),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BinarySearchTreeCoordinator coordinator =
        Provider.of<BinarySearchTreeCoordinator>(context, listen: false);
    return VisualizeButton(
      distance: 80,
      children: [
        AlgorithmButton(
          onPressed: () {
            if (coordinator.getSearchValue() == null) {
              showException(context);
            } else {
              coordinator.stop = false;
              coordinator.stopButton = true;
              coordinator.resetNodes();
              coordinator.dfs(coordinator.getSearchValue()!, coordinator);
            }
          },
          algorithm: "DFS",
        ),
        AlgorithmButton(
          onPressed: () {
            if (coordinator.getSearchValue() == null) {
              showException(context);
            } else {
              coordinator.stop = false;
              coordinator.stopButton = true;
              coordinator.resetNodes();
              coordinator.bfs(coordinator.getSearchValue()!, coordinator);
            }
          },
          algorithm: "BFS",
        ),
        AlgorithmButton(
          onPressed: () {
            if (coordinator.getSearchValue() == null) {
              showException(context);
            } else {
              coordinator.stop = false;
              coordinator.stopButton = true;
              coordinator.resetNodes();
              coordinator.binarySearch(
                  coordinator.getSearchValue()!, coordinator);
            }
          },
          algorithm: "BinarySearch",
        ),
      ],
    );
  }
}
