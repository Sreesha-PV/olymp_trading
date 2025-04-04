import 'package:flutter/material.dart';

import '../drawers/sidebar_drawer/trades_drawer.dart';


class DrawerProvider extends ChangeNotifier {
  Widget _selectedDrawer = const TradesDrawer();

  Widget get selectedDrawer => _selectedDrawer;

  void updateDrawerContent(Widget newDrawer) {
    _selectedDrawer = newDrawer;
    notifyListeners();
  }
}





import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/provider/trade_history_provider.dart';
import 'package:olymp_trade/services/order_get_services.dart';
import 'package:web_socket_channel/io.dart';

class ActiveOrderProvider extends ChangeNotifier {
  List<OrderGet> _orders = [];
  IOWebSocketChannel? _channel;
  TradeHistoryProvider? _tradeHistoryProvider;

  List<OrderGet> get orders => _orders;

  void setTradeHistoryProvider(TradeHistoryProvider provider) {
    _tradeHistoryProvider = provider;
  }

  Future<void> fetchOrders() async {
    _orders = await OrderGetServices().getOrdersByStatus(2); // status 2 = active
    notifyListeners();
  }

  void connectWebSocket() {
    _channel = IOWebSocketChannel.connect("wss://your-websocket-url");

    _channel!.stream.listen((message) {
      final data = json.decode(message);
      OrderGet order = OrderGet.fromJson(data);

      if (order.status == 2) {
        // Add to active if not exists
        if (!_orders.any((o) => o.idInt == order.idInt)) {
          _orders.add(order);
          notifyListeners();
        }
      } else if (order.status == 4) {
        // Completed order: move to history
        _orders.removeWhere((o) => o.idInt == order.idInt);
        notifyListeners();
        _tradeHistoryProvider?.addTrade(order);
      }
    });
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }
}




WidgetsBinding.instance.addPostFrameCallback((_) {
  activeOrderProvider.fetchOrders();
  activeOrderProvider.setTradeHistoryProvider(tradeHistoryProvider);
  activeOrderProvider.connectWebSocket();
});



import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';

class TradeHistoryProvider extends ChangeNotifier {
  List<OrderGet> _tradeHistory = [];

  List<OrderGet> get tradeHistory => _tradeHistory;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchTradeHistory() async {
    _isLoading = true;
    notifyListeners();

    // TODO: Replace this with real API call
    await Future.delayed(const Duration(seconds: 2));
    _tradeHistory = []; // Initialize or load from API

    _isLoading = false;
    notifyListeners();
  }

  void addTrade(OrderGet trade) {
    _tradeHistory.add(trade);
    notifyListeners();
  }

  void clearHistory() {
    _tradeHistory.clear();
    notifyListeners();
  }
}
