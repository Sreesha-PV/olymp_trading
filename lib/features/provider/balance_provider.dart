import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/balance_model.dart';
import 'package:olymp_trade/features/provider/selected_account_provider.dart';
import 'package:olymp_trade/services/account_balance_services.dart';
import 'package:provider/provider.dart';

class BalanceProvider with ChangeNotifier {
  Balance? _balance;
  bool _isLoading = false;
  final BalanceService _balanceService = BalanceService();

  Balance? get balance => _balance;
  bool get isLoading => _isLoading;
  // Future<void> loadBalance() async {
  //   if (_isLoading) return;
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     _balance = await _balanceService.fetchBalance();
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error loading balance: $e');
  //   }
  // }

  Future<void> loadBalance(BuildContext context) async {
  if (_isLoading) return;
  _isLoading = true;
  notifyListeners();
  try {
    _balance = await _balanceService.fetchBalance();
    final selectedNotifier = Provider.of<SelectedAccountNotifier>(context, listen: false);
    if (selectedNotifier.selectedAccount == 'Demo Account' && _balance != null) {
      selectedNotifier.selectAccount('Demo Account', "Ð${_balance!.availableBalance?.toStringAsFixed(2)}");
    }

    notifyListeners();
  } catch (e) {
    print('Error loading balance: $e');
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  Future<void> updateBalance(double newBalance) async {
    try {
      _balance?.availableBalance = newBalance;
      notifyListeners();
    } catch (e) {
      print('Error updating balance: $e');
    } 
  }
}