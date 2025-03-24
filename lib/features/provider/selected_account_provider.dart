// import 'package:flutter/material.dart';
// import 'package:olymp_trade/services/user_balance.dart';


// class SelectedAccountNotifier extends ChangeNotifier {
//   bool _isOpen = false;
//   String _selectedAccount = "AED Account";
//   Map<String, String> _balances = {
//     "Demo Account": "Ð10,000.00",
//     "AED Account": "AED 0.00",
//     "USDT Account": "USDT 0.00",
//   };

//   bool get isOpen => _isOpen;
//   String get selectedAccount => _selectedAccount;
//   String get selectedBalance => _balances[_selectedAccount] ?? "0.00"; 

//   SelectedAccountNotifier() {
//     fetchBalanceFromAPI();
//   }

//   void toggleDrawer() {
//     _isOpen = !_isOpen;
//     notifyListeners();
//   }
//   void selectAccount(String account) {
//     _selectedAccount = account;
//     _isOpen = false;
//     notifyListeners();
//   }

//   Future<void> fetchBalanceFromAPI() async {
//     _balances = await BalanceService.fetchBalances();
//     notifyListeners();
//   }
// }













import 'package:flutter/material.dart';
import 'package:olymp_trade/services/account_balance_services.dart';


class SelectedAccountNotifier extends ChangeNotifier {
  String _selectedAccount = '';
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

