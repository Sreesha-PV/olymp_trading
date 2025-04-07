// import 'package:flutter/material.dart';
// import 'package:olymp_trade/features/model/order_get_model.dart';
// import 'package:olymp_trade/services/order_get_services.dart';



// const int activeOrderStatus =2;
// const int executedOrderStatus = 4;


// class ActiveOrderProvider extends ChangeNotifier {
//   List<OrderGet> _orders = [];
//   bool _isLoading = false;
//   String? _errorMessage;


//   List<OrderGet> get orders => _orders;
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;


//   Future<void> fetchOrders() async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       _orders = await OrderGetServices().getOrdersByStatus(activeOrderStatus);
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//   void removeOrder(int id) {
//     _orders.removeWhere((order) => order.idInt == id);
//     notifyListeners();
//   }

// }





import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:olymp_trade/features/provider/trade_history_provider.dart';
import 'package:olymp_trade/services/order_get_services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const int activeOrderStatus =2;
const int executedOrderStatus = 4;

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
    if (_socketSubscription != null) {
      return;  
    }

    try {
      final channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.4.30:4600/ws/1003'), 
      );

      _socketSubscription = channel.stream.listen(
        (message) {
          final data = json.decode(message);
          OrderGet completedOrder = OrderGet.fromJson(data);
          moveOrderToHistory(completedOrder);
          notifyListeners();
        },
        onError: (error) {
          _handleWebSocketError(error);
        },
        onDone: () {
          _errorMessage = "WebSocket disconnected";
          notifyListeners();
        },
      );
    } catch (e) {
      _handleWebSocketError(e);
    }
  }

  void moveOrderToHistory(OrderGet order) {
    _orders.remove(order);  
    TradeHistory tradeHistory = order.toTradeHistory(); 
    tradeHistoryProvider.addOrderToHistory(tradeHistory);
    notifyListeners(); 
  }

  void _handleWebSocketError(error) {
    if (error is WebSocketException) {
      _errorMessage = "WebSocket connection error: ${error.message}";
    } else {
      _errorMessage = "WebSocket error: $error";
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _socketSubscription?.cancel();
    super.dispose();
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
const int executedOrderStatus = 4;

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
    fetchOrders(); // Fetch existing active orders on init
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

          // Only process if the order is marked as executed
          if (data['status'] == executedOrderStatus) {
            final completedOrder = OrderGet.fromJson(data);
            moveOrderToHistory(completedOrder);
          }
        },
        onError: (error) => _handleWebSocketError(error),
        onDone: () {
          _errorMessage = "WebSocket disconnected";
          notifyListeners();
        },
      );
    } catch (e) {
      _handleWebSocketError(e);
    }
  }

  void moveOrderToHistory(OrderGet order) {
    // Check if the order exists in the active list
    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      final removedOrder = _orders.removeAt(index);
      final tradeHistory = removedOrder.toTradeHistory();
      tradeHistoryProvider.addOrderToHistory(tradeHistory);
      notifyListeners(); // Only notify if list actually changed
    }
  }

  void _handleWebSocketError(error) {
    if (error is WebSocketException) {
      _errorMessage = "WebSocket connection error: ${error.message}";
    } else {
      _errorMessage = "WebSocket error: $error";
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _socketSubscription?.cancel();
    super.dispose();
  }
}


