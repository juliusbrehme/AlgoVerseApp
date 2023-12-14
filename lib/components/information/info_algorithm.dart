import 'package:algo_verse_app/components/information/code_viewer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoAlgorithm extends StatelessWidget {
  InfoAlgorithm({
    super.key,
    required this.name,
    required this.worstCase,
    this.worstCaseBold,
    this.worstCaseTextSize,
    this.worstCaseSubtitle,
    this.worstCaseSubSubtitle,
    required this.averageCase,
    this.averageCaseBold,
    this.averageCaseTextSize,
    this.averageCaseSubtitle,
    this.averageCaseSubSubtitle,
    required this.bestCase,
    this.bestCaseBold,
    this.bestCaseTextSize,
    this.bestCaseSubtitle,
    this.bestCaseSubSubtitle,
    required this.codeContent,
  });

  final String name;
  final String worstCase;
  bool? worstCaseBold;
  final int? worstCaseTextSize;
  final String? worstCaseSubtitle;
  final String? worstCaseSubSubtitle;
  final String averageCase;
  bool? averageCaseBold;
  final int? averageCaseTextSize;
  final String? averageCaseSubtitle;
  final String? averageCaseSubSubtitle;
  final String bestCase;
  bool? bestCaseBold;
  final int? bestCaseTextSize;
  final String? bestCaseSubtitle;
  final String? bestCaseSubSubtitle;
  final String codeContent;

  @override
  Widget build(BuildContext context) {
    worstCaseBold ??= true;
    averageCaseBold ??= true;
    bestCaseBold ??= true;

    return Container(
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
          bottom: 10,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
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
              Text(
                "Time Complexity:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Worst Case:",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worstCase,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: worstCaseBold!
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      worstCaseSubtitle != null
                          ? Text(
                              worstCaseSubtitle!,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(),
                      worstCaseSubSubtitle != null
                          ? Text(
                              worstCaseSubSubtitle!,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Average Case:",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        averageCase,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: averageCaseBold!
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      averageCaseSubtitle != null
                          ? Text(
                              averageCaseSubtitle!,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(),
                      averageCaseSubSubtitle != null
                          ? Text(
                              averageCaseSubSubtitle!,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Best Case:",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bestCase,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: bestCaseBold!
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      bestCaseSubtitle != null
                          ? Text(
                              bestCaseSubtitle!,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Pseudo Code:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CodeViewer(
                codeContent: codeContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
