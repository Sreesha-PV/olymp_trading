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

const int activeOrderStatus = 2;
const int executedOrderStatus = 4;


class ActiveOrderProvider extends ChangeNotifier {
  List<OrderGet> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _ordersFetched = false;

  StreamSubscription? _socketSubscription;
 
  List<OrderGet> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get ordersFetched => _ordersFetched;

  final TradeHistoryProvider tradeHistoryProvider;

  ActiveOrderProvider(this.tradeHistoryProvider) {
    connectWebSocket();
  }

  void clearOrders() {
    _orders.clear();
    _ordersFetched = false;
    notifyListeners();
  }

  Future<void> fetchOrders() async {
  _isLoading = true;
  _errorMessage = null;
  _orders.clear();
  notifyListeners();

  try {
    List<OrderGet> fetchedOrders = await OrderGetServices().getOrdersByStatus(activeOrderStatus);
    print("Fetched orders from API: ${fetchedOrders.map((order) => order.id)}");  

    
    if (fetchedOrders.isEmpty) {
      print('No orders fetched from API');
    } else {
      print('Fetched ${fetchedOrders.length} orders');
    }

    for (var order in fetchedOrders) {
      if (!_orders.any((existingOrder) => existingOrder.id == order.id)) {
        _orders.add(order);
        print('Added order from API: ${order.id}');
      } else {
        print('Order from API already exists in active list: ${order.id}');
      }
    }

    _ordersFetched = true;
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
      Uri.parse(''), 
    );
    print('Attempting to connect to WebSocket...');

_socketSubscription = channel.stream.listen(
  (message) {
    print('Received WebSocket message: $message');
    try {
      final data = json.decode(message);
      print('Decoded WebSocket message: $data');
      
      if (data != null && data.containsKey('order')) {
        OrderGet completedOrder = OrderGet.fromJson(data['order']);
        print('Parsed order: ${completedOrder.id}, Amount: ${completedOrder.amount}');
        
        if (!_orders.any((order) => order.id == completedOrder.id)) {
          _orders.add(completedOrder);
          print('Added order to active list: $completedOrder');
        } else {
          print('Order with ID ${completedOrder.id} already exists in active list.');
        }

       
        if (_orders.contains(completedOrder)) {
          moveOrderToHistory(completedOrder);
        }
      } else {
        print('Invalid or empty data received. Ignoring.');
      }
    } catch (e) {
      print('Error decoding message: $e');
    }
  },
  onError: (error) {
    _handleWebSocketError(error);
  },
  onDone: () {
    print('WebSocket connection closed');
    _errorMessage = "WebSocket disconnected";
    notifyListeners();
  },
);


channel.sink.add('Hello, WebSocket!');

  (message) {
    print('Received WebSocket message: $message');
  };


  print('WebSocket connection established!');
  } catch (e) {
    _handleWebSocketError(e);
  }
}

void moveOrderToHistory(OrderGet order) {
  print('Current active orders before moving: ${_orders.map((order) => order.id)}');
  if (_orders.contains(order)) {
    _orders.remove(order);  
    TradeHistory tradeHistory = order.toTradeHistory();
    tradeHistoryProvider.addOrderToHistory(tradeHistory);
    print('Moved order to history: ${order.id}');
  } else {
    print('Order not found in active list: ${order.id}');
  }
  print('Active orders after moving: ${_orders.map((order) => order.id)}');
  print('Trade history after moving: ${tradeHistoryProvider.tradeHistory.map((order) => order.symbol)}');
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


