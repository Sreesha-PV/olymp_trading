import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _loggedInUsername;

  String? get loggedInUsername => _loggedInUsername;

  void login(String username, String password) {
    _loggedInUsername = username;
    notifyListeners();
  }

  void logout() {
    _loggedInUsername = null;
    notifyListeners();
  }
}
