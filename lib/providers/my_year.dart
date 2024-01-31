import 'package:flutter/material.dart';

class MyYearProvider with ChangeNotifier {
  int _myYear = 0;

  int get myYear => _myYear;

  void setMyYear(int value) {
    _myYear = value;
    notifyListeners();
  }
}