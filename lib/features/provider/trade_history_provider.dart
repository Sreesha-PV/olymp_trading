import 'dart:async';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';

class TradeHistoryProvider extends ChangeNotifier {
  List<TradeHistory> _tradeHistory = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TradeHistory> get tradeHistory => _tradeHistory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void addOrderToHistory(TradeHistory tradeHistory) {
    try {
      print("Adding trade: $tradeHistory");
      _tradeHistory.add(tradeHistory);
      print("Current trade history: $_tradeHistory");
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Failed to add order to history: $error';
      print(_errorMessage);
      notifyListeners();
    }
  }

  void clearTradeHistory() {
    _tradeHistory.clear();
    notifyListeners();
  }

  Future<void> fetchTradeHistory() async {
    try {
      _isLoading = true;
      notifyListeners();

      await Future.delayed(Duration(seconds: 2));

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _errorMessage = 'Error fetching trade history: $error';
      notifyListeners();
    }
  }
}










