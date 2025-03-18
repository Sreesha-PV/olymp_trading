
import 'package:flutter/material.dart';

class TradeSettingsProvider with ChangeNotifier {
  double _amount = 1.0;
  int _minutes = 1;
  double _strikeprice = 0;
  String _symbols = '';
  int _ordertype = 0;

  String? _userId;
  int _userIdInt = 0;


  double get amount => _amount;
  int get minutes => _minutes;
  double get strikeprice => _strikeprice;
  String get symbol => _symbols;
  int get ordertype => _ordertype;

  String? get userId => _userId;
  int get userIdInt => _userIdInt;




 
  void setAmount(double value) {
    _amount = value;
    notifyListeners();
  }

  void setMinutes(int value) {
    _minutes = value;
    notifyListeners();
  }

  // void setSymbols(String value) {
  //   _symbols = value;
  //   notifyListeners();
  // }
  void setSymbols(String symbol) {
    if (symbol.isEmpty) {
  
    print("Symbol cannot be empty!");
    return;
  }
    _symbols = symbol;
    print("Symbol updated to: $_symbols");
    notifyListeners();
  }
  void setStrikeprice(double value) {
    _strikeprice = value;
    notifyListeners();
  }

  void setOrdertype(int value) {
    _ordertype = value;
    notifyListeners();
  }


  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setUserIdInt(int userIdInt) {
    _userIdInt = userIdInt;
    notifyListeners();
  }


  void resetUser() {
    _userId = null;
    _userIdInt = 0;
    notifyListeners();
  }

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

  


}



