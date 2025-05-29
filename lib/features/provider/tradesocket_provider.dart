import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/urls.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:olymp_trade/features/provider/order_provider.dart';
import 'package:olymp_trade/services/order_get_services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// const int activeOrderStatus =2;
// const int executedOrderStatus = 4;

class TradeSocketProvider with ChangeNotifier {

  final OrderGetServices _orderService = OrderGetServices();
  // late final WebSocketChannel _channel;
  WebSocketChannel? _channel ;
  List<OrderGet> _activeOrders = [];
  List<TradeHistory> _tradeHistory = [];
  Map<String, Timer> _orderTimers = {};
  bool _isLoading = false;

  List<OrderGet> get activeOrders => _activeOrders;
  List<TradeHistory> get tradeHistory => _tradeHistory;
  bool get isLoading => _isLoading;

  Future<void> fetchActiveOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
    _activeOrders = await _orderService.getOrdersByStatus(2);
      print('[Provider] Fetched ${_activeOrders.length} active orders');    
    } catch (e) {
      print('[Provider] Error fetching active orders: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  } 
  void clearOrders() {
    _activeOrders = [];
    notifyListeners();
  }
  final OrderProvider orderProvider;

  TradeSocketProvider(this.orderProvider) {
    _connectWebSocket();
  }

 void _connectWebSocket() {
    _channel?.sink.close();
    _channel = WebSocketChannel.connect(
      Uri.parse(ApiUrl.wsUrl),
    );

    _channel!.stream.listen(
    (data) {
    print('[WebSocket] Received: $data');
    try {
      final json = jsonDecode(data);

      if (json.containsKey('order_id') && json.containsKey('timestamp') == false) {
        final newOrderId = json['order_id'];

         if (newOrderId == null || newOrderId.isEmpty) {
            print('[WebSocket] Invalid order_id. Skipping.');
            return;
          }
        if(_activeOrders.any((o)=>o.id == newOrderId)){
            print('[WebSocket] Skipping duplicate active order :$newOrderId');
            return;
        }

        final order = OrderGet.fromJson({
          'order_id': json['order_id'],
          'symbol': json['symbol'],
          'amount': json['amount'],
          'strike_price': json['strike_price'],
          'order_type': json['order_type'],
          'order_placed_timestamp': json['order_placed_timestamp'],
          'expiry_time': json['expiry_time'],
          'order_duration': json['order_duration'],
        });

        _activeOrders.add(order);
        _startOrderTimer(order);
        // print('[WebSocket] Order placed: ${order.id}');
        notifyListeners();
      }

      else if (json['order_id'] != null && json['timestamp'] != null) {
        final completedOrder = OrderGet.fromJson({
          'order_id': json['order_id'],
          'symbol': json['symbol'],
          'amount': json['amount'],
          'strike_price': json['strike_price'],
          'order_type': json['order_type'],
          'order_placed_timestamp': json['order_placed_timestamp'],
          'expiry_time': json['expiry_time'],
          'order_duration': json['order_duration'],
        });

        _activeOrders.removeWhere((order) => order.id == completedOrder.id);
     
        final profit = (json['profit'] ?? 0.0).toDouble();
        final loss = (json['loss'] ?? 0.0).toDouble();

        final trade = completedOrder.toTradeHistory(profit: profit, loss: loss);

        _tradeHistory.insert(0, trade);
        print('[WebSocket] Order expired, moved to history (from WS): ${trade.id}');
        print('[WebSocket] Profit: ${trade.profit}, Loss: ${trade.loss}');

        notifyListeners();
      }
      } catch (e) {
      print('[WebSocket] Error parsing message: $e');
    }
  },
  onDone: () {
    print('[WebSocket] Connection closed. Reconnecting...');
    _connectWebSocket();
  },
  onError: (error) {
    print('[WebSocket] Error: $error');
  },
);
}

  void _startOrderTimer(OrderGet order) {
    Duration remainingTime = order.getRemainingTime();

    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final timeLeft = order.getRemainingTime();

      if (timeLeft.isNegative || timeLeft.inSeconds <= 0) {
        timer.cancel();
        _orderTimers.remove(order.id);
        _moveOrderToHistory(order);


      }
      notifyListeners();
    });

    _orderTimers[order.id] = timer;
  }

void _moveOrderToHistory(OrderGet order) {
  if (_tradeHistory.any((t) => t.orderId == order.id)) {
    print('[Timer] Skipped: Trade already in history for ${order.id}');
    return;
  }

  _activeOrders.removeWhere((o) => o.id == order.id);
  _orderTimers[order.id]?.cancel();
  _orderTimers.remove(order.id);

  final trade = order.toTradeHistory(
    profit: 0.0, 
    loss: 0.0,
  );

  trade.timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  _tradeHistory.insert(0, trade);

  print('[Timer] Order expired and moved to history (fallback): ${trade.id}');
  notifyListeners();
}

 @override
  void dispose() {
    _channel?.sink.close();
    _orderTimers.values.forEach((timer) => timer.cancel());
    super.dispose();
  }
}
// 