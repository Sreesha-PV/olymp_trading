// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import '../model/order_get_model.dart';
// import '../model/trade_history_model.dart';

// class TradeSocketProvider with ChangeNotifier {
//   late final WebSocketChannel _channel;

//   List<OrderGet> _activeOrders = [];
//   List<TradeHistory> _tradeHistory = [];

//   List<OrderGet> get activeOrders => _activeOrders;
//   List<TradeHistory> get tradeHistory => _tradeHistory;

//   TradeSocketProvider() {
//     _connectWebSocket();
//   }

// void _connectWebSocket() {
//   _channel = WebSocketChannel.connect(
//     Uri.parse('ws://192.168.4.30:4600/ws/1011'),
//   );

//   _channel.stream.listen(
//     (data) {
//       print('[WebSocket] Received: $data');
//       try {
//         final json = jsonDecode(data);

//         // Case 1: Handling order placement
//         if (json.containsKey('order_id') && json.containsKey('timestamp')) {
//           final order = OrderGet.fromJson({
//             'id': json['order_id'],
//             'symbol': json['symbol'],
//             'amount': json['amount'],
//             'strike_price': json['strike_price'],
//             'order_status': json['order_type'],
//             'created_at': json['order_placed_timestamp'],
//             // Add other relevant fields
//           });

//           // Add to active orders
//           _activeOrders.add(order);
//           print('[WebSocket] Order placed: ${order.id}');
//           notifyListeners();
//         }

//         // Case 2: Handling expired order (move to history)
//         else if (json['order_id'] != null && json['symbol'] != null) {
//           final expiredOrder = OrderGet.fromJson({
//             'id': json['order_id'],
//             'symbol': json['symbol'],
//             'amount': json['amount'],
//             'strike_price': json['strike_price'],
//             'order_status': json['order_type'],
//             'created_at': json['order_placed_timestamp'],
//           });

//           _activeOrders.removeWhere((order) => order.id == expiredOrder.id);
//           final trade = expiredOrder.toTradeHistory();

          
//           trade.profit = json['profit'] ?? 0;
//           trade.loss = json['loss'] ?? 0;

       
//           _tradeHistory.insert(0, trade);
//           print('[WebSocket] Order expired, moved to history: ${trade.id}');
//           notifyListeners(); 
//         }

//       } catch (e) {
//         print('[WebSocket] Error parsing message: $e');
//       }
//     },
//     onDone: () {
//       print('[WebSocket] Connection closed. Reconnecting...');
//       _connectWebSocket();
//     },
//     onError: (error) {
//       print('[WebSocket] Error: $error');
//     },
//   ); 
// }

//   @override
//   void dispose() {
//     _channel.sink.close();
//     super.dispose();
//   }
// }








// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/features/model/order_get_model.dart';
// import 'package:olymp_trade/features/model/trade_history_model.dart';
// import 'package:web_socket_channel/web_socket_channel.dart'; 

// class TradeSocketProvider with ChangeNotifier {
//   late final WebSocketChannel _channel;
//   List<OrderGet> _activeOrders = [];
//   List<TradeHistory> _tradeHistory = [];
//   Map<String, Timer> _orderTimers = {}; 

//   List<OrderGet> get activeOrders => _activeOrders;
//   List<TradeHistory> get tradeHistory => _tradeHistory;

//   TradeSocketProvider() {
//     _connectWebSocket();
//   }

//   void _connectWebSocket() {
//     _channel = WebSocketChannel.connect(
//       Uri.parse('ws://192.168.4.30:4600/ws/1011'),
//     );

//     _channel.stream.listen(
//       (data) {
//         print('[WebSocket] Received: $data');
//         try {
//           final json = jsonDecode(data);

          
//           if (json.containsKey('order_id') && json.containsKey('timestamp')) {
//             final order = OrderGet.fromJson({
//               'id': json['order_id'],
//               'symbol': json['symbol'],
//               'amount': json['amount'],
//               'strike_price': json['strike_price'],
//               'order_status': json['order_type'],
//               'created_at': json['order_placed_timestamp'],
//               'expiry_time': json['expiry_time'], 
//             });

//             _activeOrders.add(order);
//             _startOrderTimer(order); 

//             print('[WebSocket] Order placed: ${order.id}');
//             notifyListeners();
//           }

      
//           else if (json['order_id'] != null && json['symbol'] != null) {
//             final expiredOrder = OrderGet.fromJson({
//               'id': json['order_id'],
//               'symbol': json['symbol'],
//               'amount': json['amount'],
//               'strike_price': json['strike_price'],
//               'order_status': json['order_type'],
//               'created_at': json['order_placed_timestamp'],
//             });

//             _activeOrders.removeWhere((order) => order.id == expiredOrder.id);
//             final trade = expiredOrder.toTradeHistory();

//             trade.profit = json['profit'] ?? 0;
//             trade.loss = json['loss'] ?? 0;

//             _tradeHistory.insert(0, trade);
//             print('[WebSocket] Order expired, moved to history: ${trade.id}');
//             notifyListeners();
//           }
//         } catch (e) {
//           print('[WebSocket] Error parsing message: $e');
//         }
//       },
//       onDone: () {
//         print('[WebSocket] Connection closed. Reconnecting...');
//         _connectWebSocket();
//       },
//       onError: (error) {
//         print('[WebSocket] Error: $error');
//       },
//     );
//   }

// void _startOrderTimer(OrderGet order) {
//   Duration remainingTime = order.getRemainingTime();

//   Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
//     final timeLeft = order.getRemainingTime();

//     if (timeLeft.isNegative || timeLeft.inSeconds <= 0) {
//       timer.cancel();
//       _orderTimers.remove(order.id);
//       _moveOrderToHistory(order);
//     }

//     notifyListeners(); 
//   });

//   _orderTimers[order.id] = timer;
// }

// void _moveOrderToHistory(OrderGet order) {
//   _activeOrders.removeWhere((o) => o.id == order.id);
//   _orderTimers[order.id]?.cancel(); 
//   _orderTimers.remove(order.id);

//   final trade = order.toTradeHistory();
//   trade.timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//   _tradeHistory.insert(0, trade);
//   print('[WebSocket] Order expired, moved to history: ${trade.id}');

//   notifyListeners();
// }
//   @override
//   void dispose() {
//     _channel.sink.close();
//     _orderTimers.values.forEach((timer) => timer.cancel());
//     super.dispose();
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











