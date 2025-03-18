

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
 

}





