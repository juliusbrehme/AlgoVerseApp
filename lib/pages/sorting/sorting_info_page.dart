import 'package:algo_verse_app/components/information/info_algorithm.dart';
import 'package:algo_verse_app/components/information/pseudocode.dart';
import 'package:algo_verse_app/components/information/sorting_history_block.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortingInfoPage extends StatelessWidget {
  const SortingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SortingCoordinator>(
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
                      "Sorting History",
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
                itemCount: coordinator.sortingHistory.length,
                itemBuilder: (context, index) {
                  return SortingHistoryBlock(
                      sortingHistory: coordinator.sortingHistory[index]);
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
                name: "BubbleSort",
                worstCase: "O(n²)",
                bestCase: "O(n²)",
                averageCase: "O(n²)",
                codeContent: PseudoCode.BubbleSort(),
              ),
              const SizedBox(height: 20),
              InfoAlgorithm(
                name: "InsertionSort",
                worstCase: "O(n²)",
                bestCase: "O(n)",
                averageCase: "O(n²)",
                codeContent: PseudoCode.InsertionSort(),
              ),
              const SizedBox(height: 20),
              InfoAlgorithm(
                name: "MergeSort",
                worstCase: "O(n*log(n))",
                bestCase: "O(n*log(n))",
                averageCase: "O(n*log(n))",
                codeContent: PseudoCode.MergeSort(),
              ),
              const SizedBox(height: 20),
              InfoAlgorithm(
                name: "QuickSort",
                worstCase: "O(n²)",
                bestCase: "O(n*log(n))",
                averageCase: "O(n*log(n))",
                codeContent: PseudoCode.QuickSort(),
              ),
              const SizedBox(height: 20),
              InfoAlgorithm(
                name: "SelectionSort",
                worstCase: "O(n²)",
                bestCase: "O(n²)",
                averageCase: "O(n²)",
                codeContent: PseudoCode.SelectionSort(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
