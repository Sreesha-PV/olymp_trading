import 'package:flutter/material.dart';

class TradeSettingsProvider with ChangeNotifier {
  double _amount = 1.0;
  int _minutes = 1;

  double get amount => _amount;
  int get minutes => _minutes;

  void increaseAmount() {
    _amount += 1;
    notifyListeners();
  }

  void decreaseAmount() {
    if (_amount > 0) {
      _amount -= 1;
      notifyListeners();
    }
  }

  void increaseMinutes() {
    _minutes += 1;
    notifyListeners();
  }

  void decreaseMinutes() {
    if (_minutes > 1) {
      _minutes -= 1;
      notifyListeners();
    }
  }

  void setMinutes(int value){
    _minutes=value;
    notifyListeners();
  }

  void setAmount(double value){
    _amount=value;
    notifyListeners();
  }
}


