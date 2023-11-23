import 'package:algo_verse_app/components/bar.dart';
import 'package:algo_verse_app/provider/sorting_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortingPage extends StatelessWidget {
  const SortingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SortingCoordinator coordinator = Provider.of<SortingCoordinator>(context);
    // array should contain only values from 1 to 100

    int height = (MediaQuery.of(context).size.height - 240).toInt();
    double division =
        MediaQuery.of(context).size.width / coordinator.startingArr.length;

    List<Widget> bars = List.generate(
      coordinator.startingArr.length,
      (int index) => Bar(
          barHeight:
              height * (coordinator.startingArr[index].toDouble() / 100) + 10,
          barWidth: division * 0.5,
          margin: division * 0.25 + (division * coordinator.indexArr[index]),
          animationSpeed: coordinator.animationSpeed,
          color: index == coordinator.swapI
              ? Colors.green
              : index == coordinator.swapJ
                  ? Colors.red
                  : null),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: bars,
            ),
          ),
        ),
        const SizedBox(
          height: 110,
        ),
      ],
    );
  }
}
