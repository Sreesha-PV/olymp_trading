import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  String _selectedAccount = "AED Account";
  String get selectedAccount => _selectedAccount;

  void updateAccount(String account) {
    _selectedAccount = account;
    notifyListeners();
  }
}
