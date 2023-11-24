import 'dart:math';

import 'package:algo_verse_app/provider/speed.dart';
import 'package:flutter/material.dart';

class SortingCoordinator extends ChangeNotifier {
  List<int> _startingArr = [];
  List<int> _toSortArr = [];
  List<int> _indexArr = [];
  int _swapI = -1;
  int _swapJ = -1;
  bool _stop = false;
  bool _stopButton = false;
  bool _isSorting = false;
  int _animationSpeed = 1500;
  Enum _speed = Speed.slow;

  SortingCoordinator() {
    setArray(generateRandomArray(10));
  }

  set swapI(int i) {
    _swapI = i;
    notifyListeners();
  }

  set swapJ(int j) {
    _swapJ = j;
    notifyListeners();
  }

  void setStop(bool boolean) {
    _stop = boolean;
    notifyListeners();
  }

  set isSorting(bool boolean) {
    _isSorting = boolean;
    notifyListeners();
  }

  void setArray(List<int> array) {
    _startingArr = List.of(array);
    _toSortArr = List.of(array);
    _indexArr = [for (int i = 0; i < array.length; i++) i];
  }

  void setSpeed() {
    switch (speed) {
      case Speed.fast:
        _speed = Speed.slow;
        _animationSpeed = 1500;
      case Speed.slow:
        _speed = Speed.fast;
        _animationSpeed = 250;
    }
    notifyListeners();
  }

  void setStopButton(bool boolean) {
    _stopButton = boolean;
    notifyListeners();
  }

  bool get stop => _stop;
  bool get isSorting => _isSorting;
  int get swapI => _swapI;
  int get swapJ => _swapJ;
  List<int> get startingArr => _startingArr;
  List<int> get toSortArr => _toSortArr;
  List<int> get indexArr => _indexArr;
  int get animationSpeed => _animationSpeed;
  Enum get speed => _speed;
  bool get stopButton => _stopButton;

  List<int> generateRandomArray(int size) {
    Set<int> set = {};
    while (set.length < size) {
      set.add(Random().nextInt(101));
    }
    return set.toList();
  }

  void resetSwap() {
    _swapI = -1;
    _swapJ = -1;
    notifyListeners();
  }

  void reset() {
    _startingArr = List.of(_startingArr);
    _toSortArr = List.of(_startingArr);
    _indexArr = [for (int i = 0; i < _startingArr.length; i++) i];
    _swapI = -1;
    _swapJ = -1;
    notifyListeners();
  }

  void generateRandomArrayOnClick() {
    _startingArr = generateRandomArray(Random().nextInt(41));
    _toSortArr = List.of(_startingArr);
    _indexArr = [for (int i = 0; i < _startingArr.length; i++) i];
    _swapI = -1;
    _swapJ = -1;
    notifyListeners();
  }

  // wahrscheinlich weglassen
  void generateSizedArrayOnClick(int size) {
    _startingArr = generateRandomArray(size);
    _toSortArr = List.of(_startingArr);
    _indexArr = [for (int i = 0; i < _startingArr.length; i++) i];
    _swapI = -1;
    _swapJ = -1;
    notifyListeners();
  }

  void swap(int i, int j) {
    // getting the index of the value and then swapping the index to
    // the right position
    int indexI = _startingArr.indexOf(_toSortArr[i]);
    int indexJ = _startingArr.indexOf(_toSortArr[j]);

    _swapI = indexI;
    _swapJ = indexJ;
    _indexArr[indexI] = j;
    _indexArr[indexJ] = i;

    int temp = _toSortArr[i];
    _toSortArr[i] = _toSortArr[j];
    _toSortArr[j] = temp;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
