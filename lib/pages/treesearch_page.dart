import 'dart:math';

import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';
import 'package:algo_verse_app/components/buttons/action_button.dart';
import 'package:algo_verse_app/fonts/my_flutter_app_icons.dart';
import 'package:algo_verse_app/painter/tree_painter.dart';
import 'package:algo_verse_app/provider/binary_search_tree_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreeSearchPage extends StatefulWidget {
  const TreeSearchPage({super.key});

  @override
  State<TreeSearchPage> createState() => _TreeSearchPageState();
}

class _TreeSearchPageState extends State<TreeSearchPage> {
  Offset offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Consumer<BinarySearchTreeCoordinator>(
      builder: (context, coordinator, child) => Column(
        children: [
          SizedBox(
            height: 700,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  offset += details.delta;
                });
              },
              child: SizedBox.expand(
                child: ClipRRect(
                  child: CustomPaint(
                    painter: TreePainter(
                      treeMap: coordinator.treeMap,
                      offset: offset,
                      levelSpace: 100,
                      startingHeight: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
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
                onTap: () => print("Put in List!"),
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


