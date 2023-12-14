import 'package:algo_verse_app/components/information/binary_search_tree_history_block.dart';
import 'package:algo_verse_app/components/information/info_algorithm.dart';
import 'package:algo_verse_app/components/information/pseudocode.dart';
import 'package:algo_verse_app/provider/binary_search_tree_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreeSearchInfoPage extends StatelessWidget {
  const TreeSearchInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BinarySearchTreeCoordinator>(
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
                      "Search History",
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
                itemBuilder: (context, index) {
                  return BinarySearchTreeHistoryBlock(
                      searchHistory: coordinator.history[index]);
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
                name: "BinarySearch in Binarytree",
                worstCase: "O(n)",
                bestCase: "O(h)",
                bestCaseSubtitle: "h height of tree",
                averageCase: "O(h)",
                averageCaseSubtitle: "h height of tree",
                codeContent: PseudoCode.SearchBinarySearchTree(),
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
            ],
          ),
        ),
      ),
    );
  }
}
