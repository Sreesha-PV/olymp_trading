// class TradeHistory {
//   String? id;
//   String? orderId;
//   int? orderIdInt;
//   String? userId;
//   int? userIdInt;
//   String? symbol;
//   int? symbolIdInt;
//   String? symbolId;
//   double? strikePrice;
//   double? finalPrice;
//   int? orderType;
//   int? tradeOutcome;
//   double? amount;
//   double? profit;
//   double? loss;
//   int? orderPlacedTimestamp;
//   int? orderExecutedTimestamp;
//   int? timestamp;

//   DateTime? orderPlacedTime;
//   DateTime? orderExecutedTime;
//   DateTime? tradeTimestamp;

//   TradeHistory({
//     this.id,
//     this.orderId,
//     this.orderIdInt,
//     this.userId,
//     this.userIdInt,
//     this.symbol,
//     this.symbolIdInt,
//     this.symbolId,
//     this.strikePrice,
//     this.finalPrice,
//     this.orderType,
//     this.tradeOutcome,
//     this.amount,
//     this.profit,
//     this.loss,
//     this.orderPlacedTimestamp,
//     this.orderExecutedTimestamp,
//     this.timestamp,
//   });
  
//   @override
//     String toString() {
//       return 'TradeHistory(symbol: $symbol, amount: $amount, strikePrice: $strikePrice, profit: $profit, loss: $loss, timestamp: $timestamp)';
//     }

//   TradeHistory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderId = json['order_id'];
//     orderIdInt = json['order_id_int'];
//     userId = json['user_id'];
//     userIdInt = json['user_id_int'];
//     symbol = json['symbol'];
//     symbolIdInt = json['symbol_id_int'];
//     symbolId = json['symbol_id'];
//     strikePrice = json['strike_price'];
//     finalPrice = json['final_price'];
//     orderType = json['order_type'];
//     tradeOutcome = json['trade_outcome'];
//     amount = json['amount'];
//     profit = json['profit'];
//     loss = json['loss'];
//     orderPlacedTimestamp = json['order_placed_timestamp'];
//     orderExecutedTimestamp = json['order_executed_timestamp'];
//     timestamp = json['timestamp'];

   
//     orderPlacedTime = orderPlacedTimestamp != null
//         ? DateTime.fromMillisecondsSinceEpoch(orderPlacedTimestamp! * 1000)
//         : null;
//     orderExecutedTime = orderExecutedTimestamp != null
//         ? DateTime.fromMillisecondsSinceEpoch(orderExecutedTimestamp! * 1000)
//         : null;
//     tradeTimestamp = timestamp != null
//         ? DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['order_id'] = this.orderId;
//     data['order_id_int'] = this.orderIdInt;
//     data['user_id'] = this.userId;
//     data['user_id_int'] = this.userIdInt;
//     data['symbol'] = this.symbol;
//     data['symbol_id_int'] = this.symbolIdInt;
//     data['symbol_id'] = this.symbolId;
//     data['strike_price'] = this.strikePrice;
//     data['final_price'] = this.finalPrice;
//     data['order_type'] = this.orderType;
//     data['trade_outcome'] = this.tradeOutcome;
//     data['amount'] = this.amount;
//     data['profit'] = this.profit;
//     data['loss'] = this.loss;
//     data['order_placed_timestamp'] = this.orderPlacedTimestamp;
//     data['order_executed_timestamp'] = this.orderExecutedTimestamp;
//     data['timestamp'] = this.timestamp;
//     return data;
//   }

//   Duration? getTradeDuration() {
//     if (orderPlacedTime != null && orderExecutedTime != null) {
//       return orderExecutedTime!.difference(orderPlacedTime!);
//     }
//     return null;
//   }
// }




import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TradeSocketProvider with ChangeNotifier {
  late final WebSocketChannel _channel;
  List<OrderGet> _activeOrders = [];
  List<TradeHistory> _tradeHistory = [];
  Map<String, Timer> _orderTimers = {};

  List<OrderGet> get activeOrders => _activeOrders;
  List<TradeHistory> get tradeHistory => _tradeHistory;

  TradeSocketProvider() {
    _connectWebSocket();
  }

  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.4.30:4600/ws/1011'),
    );

    _channel.stream.listen(
    (data) {
    print('[WebSocket] Received: $data');
    try {
      final json = jsonDecode(data);

 
      if (json.containsKey('order_id') && json.containsKey('timestamp') == false) {
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
    _channel.sink.close();
    _orderTimers.values.forEach((timer) => timer.cancel());
    super.dispose();
  }
}



