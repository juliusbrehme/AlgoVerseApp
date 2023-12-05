import 'dart:math';

import 'package:algo_verse_app/components/buttons/action_button.dart';
import 'package:algo_verse_app/components/input_fields/custom_input_dialog.dart';
import 'package:algo_verse_app/components/input_fields/input_button.dart';
import 'package:algo_verse_app/fonts/my_flutter_app_icons.dart';
import 'package:algo_verse_app/painter/tree_painter.dart';
import 'package:algo_verse_app/provider/binary_search_tree_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_widget/zoom_widget.dart';

class TreeSearchPage extends StatefulWidget {
  const TreeSearchPage({super.key});

  @override
  State<TreeSearchPage> createState() => _TreeSearchPageState();
}

class _TreeSearchPageState extends State<TreeSearchPage> {
  Offset offset = const Offset(0, 0);
  // ignore: unused_field
  double _zoom = 0;
  bool small = false;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<BinarySearchTreeCoordinator>(
      builder: (context, coordinator, child) => Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: small ? 440 : MediaQuery.of(context).size.height - 193,
            child: Zoom(
                opacityScrollBars: 0.0,
                backgroundColor: const Color.fromARGB(255, 79, 115, 156),
                canvasColor: const Color.fromARGB(255, 79, 115, 156),
                onScaleUpdate: (scale, zoom) {
                  setState(() {
                    _zoom = zoom;
                  });
                },
                child: ClipRect(
                  child: CustomPaint(
                    size: const Size(4000, 4000),
                    painter: TreePainter(
                      treeMap: coordinator.treeMap,
                      offset: offset,
                      levelSpace: 100,
                      startingHeight: 50,
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
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
              InputButton(
                controller: _controller,
                onTap: () {
                  setState(() {
                    small = true;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    small = false;
                  });
                  FocusScope.of(context).unfocus();
                  if (_controller.text != "") {
                    coordinator.searchValue = int.parse(_controller.text);
                  }
                },
              ),
              const SizedBox(
                width: 10,
              ),
              ActionButton(
                height: 40,
                radius: 20,
                onTap: () {
                  coordinator.stopButton ? null : coordinator.randomTree();
                },
                icon: const Icon(
                  Icons.shuffle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              ActionButton(
                height: 40,
                radius: 20,
                onTap: () {
                  coordinator.stopButton ? null : coordinator.clear();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ActionButton(
                height: 40,
                radius: 20,
                onTap: () => coordinator.stopButton
                    ? null
                    : coordinator.addNode(
                        Random().nextInt(100),
                      ),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ActionButton(
                height: 40,
                radius: 20,
                onTap: () {
                  coordinator.stopButton
                      ? null
                      : showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 197, 201, 205),
                              content: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return CustomInputDialog(
                                  title:
                                      "Provide elements for the Binarysearch tree",
                                  onSubmitFuture: (List<int> list) =>
                                      coordinator.addNodesAnimated(list),
                                  smallerHundred: false,
                                );
                              }),
                            );
                          });
                },
                icon: const Icon(
                  MyIcon.flowTree,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
