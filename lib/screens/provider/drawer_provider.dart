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





import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:olymp_trade/features/provider/trade_history_provider.dart';
import 'package:olymp_trade/services/order_get_services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const int activeOrderStatus = 2;

class ActiveOrderProvider extends ChangeNotifier {
  List<OrderGet> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;
  StreamSubscription? _socketSubscription;

  List<OrderGet> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final TradeHistoryProvider tradeHistoryProvider;

  ActiveOrderProvider(this.tradeHistoryProvider) {
    connectWebSocket();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orders = await OrderGetServices().getOrdersByStatus(activeOrderStatus);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void connectWebSocket() {
    if (_socketSubscription != null) return;

    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.4.30:4600/ws/1003'),
      );

      _socketSubscription = channel.stream.listen(
        (message) {
          final data = json.decode(message);
          final updatedOrder = OrderGet.fromJson(data);

          // Check if this is a completed order (status 4 or time over)
          if (updatedOrder.status == 4) {
            _moveCompletedOrderToHistory(updatedOrder);
          }
        },
        onError: _handleWebSocketError,
        onDone: () {
          _errorMessage = "WebSocket disconnected";
          notifyListeners();
        },
      );
    } catch (e) {
      _handleWebSocketError(e);
    }
  }

  void _moveCompletedOrderToHistory(OrderGet completedOrder) {
    final index = _orders.indexWhere((order) => order.id == completedOrder.id);
    if (index != -1) {
      final removedOrder = _orders.removeAt(index);

      // Calculate profit or loss here (example logic)
      double profitLoss = (removedOrder.closePrice! - removedOrder.openPrice!) * removedOrder.amount!;
      bool isProfit = profitLoss > 0;

      final history = TradeHistory(
        id: removedOrder.id,
        symbol: removedOrder.symbol,
        amount: removedOrder.amount,
        openPrice: removedOrder.openPrice,
        closePrice: removedOrder.closePrice,
        createdAt: removedOrder.createdAt,
        completedAt: DateTime.now().toString(),
        profitOrLoss: profitLoss,
        isProfit: isProfit,
      );

      tradeHistoryProvider.addOrderToHistory(history);
      notifyListeners();
    }
  }

  void _handleWebSocketError(error) {
    _errorMessage = error is WebSocketException
        ? "WebSocket connection error: ${error.message}"
        : "WebSocket error: $error";
    notifyListeners();
  }

  @override
  void dispose() {
    _socketSubscription?.cancel();
    super.dispose();
  }
}



class TradeHistoryProvider extends ChangeNotifier {
  List<TradeHistory> _history = [];

  List<TradeHistory> get history => _history;

  void addOrderToHistory(TradeHistory order) {
    _history.add(order);
    notifyListeners();
  }
}
