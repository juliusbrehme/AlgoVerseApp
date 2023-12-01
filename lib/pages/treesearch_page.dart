import 'dart:math';

import 'package:algo_verse_app/components/buttons/action_button.dart';
import 'package:algo_verse_app/components/input_fields/custom_input_dialog.dart';
import 'package:algo_verse_app/fonts/my_flutter_app_icons.dart';
import 'package:algo_verse_app/painter/tree_painter.dart';
import 'package:algo_verse_app/provider/binary_search_tree_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:flutter/services.dart';

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
            height: small ? 440 : 700,
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
                    size: const Size(2000, 2000),
                    painter: TreePainter(
                      treeMap: coordinator.treeMap,
                      offset: offset,
                      levelSpace: 100,
                      startingHeight: 50,
                    ),
                  ),
                )),
          ),
          // const SizedBox(
          // //   height: 30,
          // ),

          InputField(
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

          Row(
            children: [
              ActionButton(
                height: 40,
                radius: 20,
                onTap: coordinator.clear,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              ActionButton(
                height: 40,
                radius: 20,
                onTap: coordinator.randomTree,
                icon: const Icon(
                  Icons.shuffle,
                  color: Colors.white,
                ),
              ),
              ActionButton(
                height: 40,
                radius: 20,
                onTap: () => coordinator.addNode(
                  Random().nextInt(100),
                ),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              ActionButton(
                height: 40,
                radius: 20,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 150, 157, 162),
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

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.controller,
      required this.onTap,
      required this.onEditingComplete});

  final TextEditingController controller;
  final Function onTap;
  final Function onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(51, 74, 100, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 8,
        ),
        child: TextField(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: false),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[1-9]+[0-9]*')),
            TextInputFormatter.withFunction(
              (oldValue, newValue) => newValue.copyWith(
                text: newValue.text.replaceAll('.', ','),
              ),
            ),
          ],
          textAlign: TextAlign.center,
          controller: controller,
          decoration: const InputDecoration(
              hintMaxLines: 1,
              hintText: "Search Value",
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              enabledBorder: InputBorder.none),
          onTap: () => onTap(),
          onEditingComplete: () => onEditingComplete(),
        ),
      ),
    );
  }
}
