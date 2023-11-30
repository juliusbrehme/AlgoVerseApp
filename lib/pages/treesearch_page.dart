import 'dart:math';

import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';
import 'package:algo_verse_app/components/buttons/action_button.dart';
import 'package:algo_verse_app/fonts/my_flutter_app_icons.dart';
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

class TreePainter extends CustomPainter {
  TreePainter({required this.treeMap, required this.offset});

  Map<Node, Node> treeMap;
  Offset offset;

  Offset getOffset(Node key) {
    if (key.value >= 0 && key.value < 10) {
      return Offset(key.x - 6, (key.y.toDouble() * 100) + 50 - 14) + offset;
    } else if (key.value >= 10 && key.value < 100) {
      return Offset(key.x - 15, (key.y.toDouble() * 100) + 50 - 14) + offset;
    } else if (key.value >= 100 && key.value < 1000) {
      return Offset(key.x - 22, (key.y.toDouble() * 100) + 50 - 14) + offset;
    } else if (key.value < 0 && key.value > -10) {
      return Offset(key.x - 13, (key.y.toDouble() * 100) + 50 - 14) + offset;
    } else if (key.value < -10 && key.value > -100) {
      return Offset(key.x - 20.5, (key.y.toDouble() * 100) + 50 - 14) + offset;
    } else {
      return Offset(key.x - 22, (key.y.toDouble() * 100) + 50 - 12) + offset;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    treeMap.forEach(
      (key, value) {
        canvas.drawLine(
            Offset(key.x, (key.y.toDouble() * 100) + 50) + offset,
            Offset(value.x, (value.y.toDouble() * 100) + 50) + offset,
            Paint()
              ..color = Colors.black
              ..strokeWidth = 2);
      },
    );
    treeMap.forEach(
      (key, value) {
        canvas.drawCircle(
          Offset(key.x, (key.y.toDouble() * 100) + 50) + offset,
          28,
          Paint()..color = Colors.black,
        );
        canvas.drawCircle(
          Offset(key.x, (key.y.toDouble() * 100) + 50) + offset,
          25,
          Paint()..color = const Color.fromRGBO(51, 74, 100, 1),
        );
        TextPainter tp = TextPainter(
          text: TextSpan(
            text: key.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: key.value < -99 ? 20 : 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(
          canvas,
          getOffset(key),
        );
      },
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
