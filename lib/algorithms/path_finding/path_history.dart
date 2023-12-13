import 'package:algo_verse_app/algorithms/path_finding/node.dart';

class PathHistory {
  final String _algorithm;
  final Node _startingNode;
  final Node _targetNode;
  final List<Node> _visitedNodes;

  PathHistory(this._algorithm, this._startingNode, this._targetNode, this._visitedNodes);

  Node get startingNode => _startingNode;
  Node get targetNode => _targetNode;
  List<Node> get visitedNodes => _visitedNodes;
  int get numberOfVisitedNodes => visitedNodes.length;
  String get algorithm => _algorithm;
}