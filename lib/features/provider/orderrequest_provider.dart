import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_creation_request.dart';
import 'package:olymp_trade/services/order_services.dart';

class OrderRequestProvider with ChangeNotifier {
  final OrderRequestService _orderRequestService = OrderRequestService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  Future<void> createOrder(OrderCreationRequest request, BuildContext context) async {
    _setLoading(true);
    _resetMessages();

    final result = await _orderRequestService.createOrder(request, context);

    if (result == null) {
    _errorMessage = "Failed to place the order. Please try again.";
    } else { 
      _successMessage = "Order placed successfully!";
    }
    _setLoading(false);
    notifyListeners();
  } 

 void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
  void _resetMessages() {
    _errorMessage = null;
    _successMessage = null;
  }

  double? _lastProfit;
  double? get lastProfit => _lastProfit;

  void setLastProfit(double value) {
    _lastProfit = value;
    notifyListeners();
  }

}

