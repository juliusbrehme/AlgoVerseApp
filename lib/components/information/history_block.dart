import 'package:algo_verse_app/algorithms/path_finding/path_history.dart';
import 'package:flutter/material.dart';

class HistoryBlock extends StatelessWidget {
  const HistoryBlock({
    super.key,
    required this.pathHistory,
  });

  // hier einfach die anderen reinsetzten und je nachdem was gebraucht wird umbauen?

  final PathHistory pathHistory;

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
                pathHistory.algorithm,
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
                        pathHistory.startingNode.toString(),
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
                        pathHistory.targetNode.toString(),
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
                        pathHistory.numberOfVisitedNodes.toString(),
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
