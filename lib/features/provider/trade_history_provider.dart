

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:olymp_trade/services/trade_history_services.dart';

class TradeHistoryProvider extends ChangeNotifier {
  final TradeHistoryServices _service = TradeHistoryServices();
  List<TradeHistory> _tradeHistory = [];
  bool _isLoading = false;
  String? _errorMessage;
  // late final StreamSubscription _socketSubscription;

  List<TradeHistory> get tradeHistory => _tradeHistory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  TradeHistoryProvider() {
    fetchTrades();
    // _connectWebSocket();
  }

  Future<void> fetchTrades() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _tradeHistory = await _service.fetchTrades();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

    void addTrade(OrderGet order) {
    final trade = TradeHistory(
      symbol: order.symbol,
      amount: order.amount,
      timestamp: DateTime.now().millisecondsSinceEpoch,
  
    );
    _tradeHistory.add(trade);
    notifyListeners();
  }

  // void _connectWebSocket() {
  //   final channel = _service.connectWebSocket();

  //   _socketSubscription = channel.stream.listen(
  //     (message) {
  //       final data = json.decode(message);
  //       TradeHistory newOrder = TradeHistory.fromJson(data);

  //       _tradeHistory.insert(0, newOrder); 
  //       notifyListeners();
  //     },
  //     onError: (error) {
  //       _errorMessage = "WebSocket error: $error";
  //       notifyListeners();
  //     },
  //     onDone: () {
  //       _errorMessage = "WebSocket disconnected";
  //       notifyListeners();
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   _socketSubscription.cancel();
  //   super.dispose();
  // }
}





