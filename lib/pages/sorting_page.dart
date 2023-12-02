import 'package:algo_verse_app/components/bar.dart';
import 'package:algo_verse_app/components/buttons/action_button.dart';
import 'package:algo_verse_app/components/input_fields/custom_input_dialog.dart';
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
          height: 20,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 2),
              child: SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(51, 74, 100, 1),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onPressed: () {
                    coordinator.setSpeed();
                  },
                  icon: const Icon(
                    Icons.speed,
                    color: Colors.white,
                  ),
                  label: Text(
                    coordinator.speed.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ActionButton(
                    height: 40,
                    radius: 20,
                    onTap: () => coordinator.generateRandomArrayOnClick(),
                    icon: const Icon(
                      Icons.shuffle,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ActionButton(
                    height: 40,
                    radius: 20,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 197, 201, 205),
                              content: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return CustomInputDialog(
                                  title: "Provide elements for the Array",
                                  onSubmit: (List<int> list) =>
                                      coordinator.setArray(list),
                                  smallerHundred: true,
                                );
                              }),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.bar_chart,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: ActionButton(
                height: 40,
                radius: 20,
                onTap: coordinator.reset,
                icon: const Icon(
                  Icons.restart_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 9,
        ),
      ],
    );
  }
}
