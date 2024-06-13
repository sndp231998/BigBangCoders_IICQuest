import 'package:flutter/material.dart';

class ScreenProvider extends ChangeNotifier {
  int _hours = 0;

  int get getHours => _hours;

  set setHours(int value) {
    _hours = value;
    notifyListeners();
  }
}
