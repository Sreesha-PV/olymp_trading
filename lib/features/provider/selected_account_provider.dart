import 'package:flutter/material.dart';
import 'package:olymp_trade/services/user_balance.dart';


class SelectedAccountNotifier extends ChangeNotifier {
  bool _isOpen = false;
  String _selectedAccount = "AED Account";
  Map<String, String> _balances = {
    "Demo Account": "Ð10,000.00",
    "AED Account": "AED 0.00",
    "USDT Account": "USDT 0.00",
  };

  bool get isOpen => _isOpen;
  String get selectedAccount => _selectedAccount;
  String get selectedBalance => _balances[_selectedAccount] ?? "0.00"; 

  SelectedAccountNotifier() {
    fetchBalanceFromAPI();
  }

  void toggleDrawer() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
  void selectAccount(String account) {
    _selectedAccount = account;
    _isOpen = false;
    notifyListeners();
  }

  Future<void> fetchBalanceFromAPI() async {
    _balances = await BalanceService.fetchBalances();
    notifyListeners();
  }
}

