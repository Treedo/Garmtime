import 'package:flutter/material.dart';

class MyNumerologigProvider with ChangeNotifier {
  int _myDay = 0;
  int _myYear = 0;

  int get myDay => _myDay;
  int get myYear => _myYear;

  void setMyDay(int value) {
    _myDay = value;
    notifyListeners();
  }

  void setMyYear(int value) {
    _myYear = value;
    notifyListeners();
  }
}