import 'package:flutter/material.dart';

class TradeSettingsProvider with ChangeNotifier {
  int _minutes = 1;
  int _amount = 1;

  int get minutes => _minutes;
  int get amount => _amount;

  void increaseMinutes() {
    _minutes++;
    notifyListeners();
  }

  void decreaseMinutes() {
    if (_minutes > 1) {
      _minutes--;
      notifyListeners();
    }
  }

  void increaseAmount() {
    _amount++;
    notifyListeners();
  }

  void decreaseAmount() {
    if (_amount > 1) {
      _amount--;
      notifyListeners();
    }
  }
}
