import 'package:algo_verse_app/algorithms/binary_search_tree/node.dart';
import 'package:flutter/material.dart';

class TreePainter extends CustomPainter {
  TreePainter({
    required this.treeMap,
    required this.offset,
    required this.levelSpace,
    required this.startingHeight,
    this.getOffsetForValue,
  }) {
    getOffsetForValue ??= getOffset;
  }

  Map<Node, Node> treeMap;
  Offset offset;
  final int levelSpace;
  final int startingHeight;
  Offset Function(Node key)? getOffsetForValue;

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
              color: key.highlight ? Colors.orange : key.found ? Colors.green : Colors.white,
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