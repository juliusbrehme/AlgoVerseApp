import 'package:algo_verse_app/algorithms/sorting/sorting_history.dart';
import 'package:flutter/material.dart';

class SortingHistoryBlock extends StatefulWidget {
  const SortingHistoryBlock({
    super.key,
    required this.sortingHistory,
  });

  final SortingHistory sortingHistory;

  @override
  State<SortingHistoryBlock> createState() => _SortingHistoryBlockState();
}

class _SortingHistoryBlockState extends State<SortingHistoryBlock> {
  bool expanded = false;

  Widget showArray(int index, List<int> array) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              (index + 1).toString() + ": ",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          ...List.generate(
            array.length,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                array[index].toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showTrack(SortingHistory sortingHistory) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(sortingHistory.sortArray.length,
                (index) => showArray(index, sortingHistory.sortArray[index])),
          ),
        ),
      ),
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.sortingHistory.algorithm,
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
                        "Array Size",
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      ),
                      Text(
                        widget.sortingHistory.size.toString(),
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Swaps",
                        style: TextStyle(
                            color: const Color.fromRGBO(245, 245, 245, 1)),
                      ),
                      Text(
                        widget.sortingHistory.swaps.toString(),
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
                      child: showTrack(widget.sortingHistory))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
