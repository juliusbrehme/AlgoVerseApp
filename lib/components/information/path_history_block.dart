import 'package:algo_verse_app/algorithms/path_finding/node.dart';
import 'package:algo_verse_app/algorithms/path_finding/path_history.dart';
import 'package:flutter/material.dart';

class PathHistoryBlock extends StatefulWidget {
  const PathHistoryBlock({
    super.key,
    required this.pathHistory,
  });

  final PathHistory pathHistory;

  @override
  State<PathHistoryBlock> createState() => _PathHistoryBlockState();
}

class _PathHistoryBlockState extends State<PathHistoryBlock> {
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
                    text: "(${node.x}, ${node.y})",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showTrack(PathHistory pathHistory) {
    return Wrap(
      children: List.generate(pathHistory.visitedNodes.length,
          (index) => showNode(index, pathHistory.visitedNodes[index])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
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
                widget.pathHistory.algorithm,
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
                        "Start",
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      ),
                      Text(
                        widget.pathHistory.startingNode.toString(),
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Target",
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      ),
                      Text(
                        widget.pathHistory.targetNode.toString(),
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
                        widget.pathHistory.numberOfVisitedNodes.toString(),
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
                      child: showTrack(widget.pathHistory))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
