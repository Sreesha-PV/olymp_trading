import 'package:flutter/material.dart';

class EnableOrderProvider with ChangeNotifier {
  bool _isOrderEnabled = false;

  bool get isOrderEnabled => _isOrderEnabled;

  void toggleOrder() {
    _isOrderEnabled = _isOrderEnabled;
    notifyListeners(); 
  }
}