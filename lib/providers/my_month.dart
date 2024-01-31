import 'package:flutter/material.dart';

class MyMonthProvider with ChangeNotifier {
  int _myMonth = 0;

  int get myMonth => _myMonth;

  void setMyMonth(int value) {
    _myMonth = value;
    notifyListeners();
  }
}