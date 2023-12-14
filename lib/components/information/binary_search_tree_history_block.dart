import 'package:algo_verse_app/algorithms/binary_search_tree/binary_search_tree_history.dart';
import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';
import 'package:flutter/material.dart';

class BinarySearchTreeHistoryBlock extends StatefulWidget {
  const BinarySearchTreeHistoryBlock({
    super.key,
    required this.searchHistory,
  });

  final BinarySearchTreeHistory searchHistory;

  @override
  State<BinarySearchTreeHistoryBlock> createState() =>
      _BinarySearchTreeHistoryBlockState();
}

class _BinarySearchTreeHistoryBlockState
    extends State<BinarySearchTreeHistoryBlock> {
  bool expanded = false;
  Widget showNode(int index, Node node) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 79, 115, 156),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: '${(index + 1).toString()}: ',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: "Node( ${node} )",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showTrack(BinarySearchTreeHistory searchHistory) {
    return Wrap(
      children: List.generate(searchHistory.visitedNodes.length,
          (index) => showNode(index, searchHistory.visitedNodes[index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        // height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(51, 74, 100, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 10,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.searchHistory.algorithm,
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
                        widget.searchHistory.size.toString(),
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
                        widget.searchHistory.visitedNodes.length.toString(),
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      )
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      color: expanded
                          ? Colors.red
                          : Color.fromRGBO(75, 107, 157, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            expanded = !expanded;
                          });
                        },
                        child: Text(
                          expanded ? "Hide" : "See Track",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              expanded
                  ? Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: showTrack(widget.searchHistory))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
