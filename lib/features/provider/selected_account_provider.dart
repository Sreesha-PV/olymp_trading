import 'package:flutter/material.dart';
import 'package:olymp_trade/services/account_balance_services.dart';

class SelectedAccountNotifier extends ChangeNotifier {
  String _selectedAccount = 'AED Account';
  String _selectedBalance = '0.00';
  bool _isOpen = false;

  String get selectedAccount => _selectedAccount;
  String get selectedBalance => _selectedBalance;
  bool get isOpen => _isOpen;

  void toggleDrawer() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void selectAccount(String account) {
    _selectedAccount = account;
    _isOpen = false;
    notifyListeners();
  }

  SelectedAccountNotifier() {
    BalanceService();
  }
}






import 'package:flutter/material.dart';
import 'package:olymp_trade/services/account_balance_services.dart';

class SelectedAccountNotifier extends ChangeNotifier {
  String _selectedAccount = 'AED Account';
  String _selectedBalance = '0.00';
  bool _isOpen = false;

  String get selectedAccount => _selectedAccount;
  String get selectedBalance => _selectedBalance;
  bool get isOpen => _isOpen;

  void toggleDrawer() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void selectAccount(String account) {
    _selectedAccount = account;
    _isOpen = false;
    notifyListeners();
  }
// ......
    String get currencySymbol {
    switch (_selectedAccount) {
      case 'Demo Account':
        return 'Ð';
      case 'AED Account':
        return 'AED';
      case 'USDT Account':
        return 'USDT';
      default:
        return '';
    }
  }

  SelectedAccountNotifier() {
    BalanceService();
  }
}

