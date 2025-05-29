// import 'package:flutter/material.dart';

// class OrderProvider with ChangeNotifier {
//   bool _isOrderPlaced = false;
//   String _amount = '';

//   bool get isOrderPlaced => _isOrderPlaced;
//   String get amount => _amount;

//   void placeOrder(String amount) {
//     _isOrderPlaced = true;
//     _amount = amount;
//     notifyListeners();
//   }

//   void resetOrder() {
//     _isOrderPlaced = false;
//     _amount = '';
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  bool _isOrderPlaced = false;
  double? _profit;

  bool get isOrderPlaced => _isOrderPlaced;
  double? get profit => _profit;

  void placeOrder(double profit) {
    _profit = profit;
    _isOrderPlaced = true;
    notifyListeners();
  }

  void resetOrder() {
    _isOrderPlaced = false;
    _profit = null;
    notifyListeners();
  }
}
