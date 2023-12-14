import 'package:algo_verse_app/components/information/path_history_block.dart';
import 'package:algo_verse_app/components/information/info_algorithm.dart';
import 'package:algo_verse_app/components/information/pseudocode.dart';
import 'package:algo_verse_app/provider/pathfinding_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PathFindingInfoPage extends StatelessWidget {
  const PathFindingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PathFindingCoordinator>(
      builder: (context, coordinator, child) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pathfinding History",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Outfit",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () => coordinator.clearHistory(),
                      icon: Icon(
                        Icons.restart_alt,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: coordinator.history.length,
                itemBuilder: (context, count) {
                  return PathHistoryBlock(
                      pathHistory: coordinator.history[count]);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Algorithms in Detail",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Outfit",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InfoAlgorithm(
                name: "A*",
                worstCase: "O(b^d)",
                worstCaseSubtitle: "b the branching factor",
                worstCaseSubSubtitle: "d the number of nodes",
                bestCase: "depends on heurstic function",
                bestCaseBold: false,
                averageCase: "depends on heurstic function",
                averageCaseBold: false,
                codeContent: PseudoCode.Astar(),
              ),
              const SizedBox(height: 20),
              InfoAlgorithm(
                name: "BFS",
                worstCase: "O(V + E)",
                worstCaseSubtitle: "V Vertices",
                worstCaseSubSubtitle: " E Edges",
                bestCase: "O(V + E)",
                bestCaseSubtitle: "V Vertices",
                bestCaseSubSubtitle: "E Edges",
                averageCase: "O(V + E)",
                averageCaseSubtitle: "V Vertices",
                averageCaseSubSubtitle: "E Edges",
                codeContent: PseudoCode.BFS(),
              ),
              const SizedBox(height: 20),
              InfoAlgorithm(
                name: "DFS",
                worstCase: "O(V + E)",
                worstCaseSubtitle: "V Vertices",
                worstCaseSubSubtitle: " E Edges",
                bestCase: "O(V + E)",
                bestCaseSubtitle: "V Vertices",
                bestCaseSubSubtitle: "E Edges",
                averageCase: "O(V + E)",
                averageCaseSubtitle: "V Vertices",
                averageCaseSubSubtitle: "E Edges",
                codeContent: PseudoCode.DFS(),
              ),
              const SizedBox(height: 20),
              InfoAlgorithm(
                name: "Dijkstra",
                worstCase: "O(V²)",
                worstCaseSubtitle: "V Vertices",
                bestCase: "O(V²)",
                bestCaseSubtitle: "V Vertices",
                averageCase: "O(V²)",
                averageCaseSubtitle: "V Vertices",
                codeContent: PseudoCode.Dijkstra(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
