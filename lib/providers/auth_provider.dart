import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  int _id = 0;

  int get getId => _id;

  set setId(int value) {
    _id = value;
    notifyListeners();
  }
}
