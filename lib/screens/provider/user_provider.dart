

import 'package:flutter/material.dart';
import 'package:olymp_trade/model/user_balance_model.dart';



class UserProvider with ChangeNotifier {
  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  void login(String username, String password) {
    _loggedInUser = mockUsers.firstWhere((user) => user.username == username);
    notifyListeners();
  }

  // void logout() {
  //   _loggedInUser = null;
  //   notifyListeners();
  // }
}
