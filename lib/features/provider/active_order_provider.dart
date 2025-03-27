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







import 'dart:async';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/services/order_get_services.dart';
import 'package:olymp_trade/features/providers/trade_history_provider.dart';
import 'package:provider/provider.dart';

const int activeOrderStatus = 2;

class ActiveOrderProvider extends ChangeNotifier {
  List<OrderGet> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;
  final Map<int, Timer> _timers = {}; // To track timers for each order

  List<OrderGet> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orders = await OrderGetServices().getOrdersByStatus(activeOrderStatus);
      _startTimers();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startTimers() {
    for (var order in _orders) {
      if (!_timers.containsKey(order.idInt)) {
        int durationInSeconds = order.duration * 60; // Convert minutes to seconds
        _timers[order.idInt] = Timer(Duration(seconds: durationInSeconds), () {
          _moveOrderToHistory(order);
        });
      }
    }
  }

  void _moveOrderToHistory(OrderGet order) {
    _timers.remove(order.idInt);
    removeOrder(order.idInt);
  }

  void removeOrder(int id) {
    _orders.removeWhere((order) => order.idInt == id);
    notifyListeners();
  }

  void transferToHistory(BuildContext context, OrderGet order) {
    Provider.of<TradeHistoryProvider>(context, listen: false).addTrade(order);
    removeOrder(order.idInt);
  }

  @override
  void dispose() {
    for (var timer in _timers.values) {
      timer.cancel();
    }
    super.dispose();
  }
}

