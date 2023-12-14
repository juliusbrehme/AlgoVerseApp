import 'package:algo_verse_app/algorithms/binary_search_tree/binary_search_tree_history.dart';
import 'package:flutter/material.dart';

class BinarySearchTreeHistoryBlock extends StatelessWidget {
  const BinarySearchTreeHistoryBlock({
    super.key,
    required this.searchHistory,
  });

  final BinarySearchTreeHistory searchHistory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(51, 74, 100, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 10,
            right: 20,
            //bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                searchHistory.algorithm,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Outfit",
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Size of Tree",
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      ),
                      Text(
                        searchHistory.size.toString(),
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Visited Nodes",
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      ),
                      Text(
                        searchHistory.visitedNodes.length.toString(),
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      )
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 80,
                    child: Center(
                        child: Text(
                      "See Track",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(75, 107, 157, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
