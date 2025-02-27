
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_model.dart';


class ActiveOrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}


