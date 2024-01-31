import 'package:flutter/material.dart';

class MyDayProvider with ChangeNotifier {
  int _myDay = 0;

  int get myDay => _myDay;

  void setMyDay(int value) {
    _myDay = value;
    notifyListeners();
  }
}