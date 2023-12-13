import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/theme_map.dart';

class CodeViewer extends StatelessWidget {
  final String codeContent;

  const CodeViewer({
    super.key,
    required this.codeContent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[800]!,
                    offset: Offset(5, 5),
                    spreadRadius: -10,
                    blurRadius: 10),
                BoxShadow(
                    color: Colors.grey[800]!,
                    offset: Offset(-5, -5),
                    spreadRadius: -10,
                    blurRadius: 10)
              ],
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Stack(
            children: [
              Column(
                children: [
                  HighlightView(
                    codeContent,
                    language: 'dart',
                    theme: themeMap["atom-one-light"]!,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    textStyle: TextStyle(
                      // add google fonts for monospace font!
                      fontFamily: 'Arial',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}