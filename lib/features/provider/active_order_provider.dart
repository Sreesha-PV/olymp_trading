import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/services/order_get_services.dart';



const int activeOrderStatus =2;
const int executedOrderStatus = 4;


class ActiveOrderProvider extends ChangeNotifier {
  List<OrderGet> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;


  List<OrderGet> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;


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
  void removeOrder(int id) {
    _orders.removeWhere((order) => order.idInt == id);
    notifyListeners();
  }

}






import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import '../models/order.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _activeOrders = [];
  List<Order> _tradeHistory = [];
  late IOWebSocketChannel _channel;

  OrdersProvider() {
    _connectWebSocket();
  }

  List<Order> get activeOrders => _activeOrders;
  List<Order> get tradeHistory => _tradeHistory;

  void _connectWebSocket() {
    _channel = IOWebSocketChannel.connect('wss://your-websocket-url');

    _channel.stream.listen((message) {
      final data = jsonDecode(message);
      _handleWebSocketMessage(data);
    }, onError: (error) {
      print("WebSocket Error: $error");
      _reconnect();
    }, onDone: () {
      print("WebSocket Disconnected");
      _reconnect();
    });
  }

  void _handleWebSocketMessage(Map<String, dynamic> data) {
    if (data['type'] == 'new_order') {
      _activeOrders.add(Order.fromJson(data['order']));
    } else if (data['type'] == 'order_completed') {
      _moveOrderToHistory(data['order_id']);
    }
    notifyListeners();
  }

  void _moveOrderToHistory(String orderId) {
    final order = _activeOrders.firstWhere((o) => o.id == orderId, orElse: () => Order.empty());
    if (order.id.isNotEmpty) {
      _activeOrders.remove(order);
      _tradeHistory.add(order);
      notifyListeners();
    }
  }

  void _reconnect() async {
    await Future.delayed(Duration(seconds: 5));
    _connectWebSocket();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

