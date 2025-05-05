// import 'package:olymp_trade/features/model/trade_history_model.dart';

// class OrderGet {
//   String id;
//   int idInt;
//   String symbol;
//   double amount;
//   double strikePrice;
//   int? orderStatus;
//   int createdAt;
//   String expiryTime;
//   // int expiryTime;
//   int? orderDuration;

  
//   OrderGet({
//     required this.id,
//     required this.idInt,
//     required this.symbol,
//     required this.amount,
//     required this.strikePrice,
//     required this.orderStatus,
//     required this.createdAt,
//     required this.expiryTime,
//     required this.orderDuration,
//   });


// factory OrderGet.fromJson(Map<String, dynamic> json, {required id}) {
//   print('[OrderGet] Parsing order: ${json['id']}');
//   return OrderGet(
//     id: json['id'] ?? json['order_id'] ?? '',
//     idInt: json['id_int'] ?? json['order_id_int'] ?? 0,
//     symbol: json['symbol'] ?? '',
//     amount: (json['amount'] ?? 0).toDouble(),
//     strikePrice: (json['strike_price'] ?? 0).toDouble(),
//     orderStatus: json['order_status'] ?? json['order_type'] ?? 0,
//     createdAt: json['created_at'] ?? json['order_placed_timestamp'] ?? 0,
//     expiryTime: json['expiry_time']?.toString() ?? '0',
//     orderDuration: json['order_duration'] ?? 0,
    
//   );
// }

  
//   Duration getRemainingTime() {
//     if (expiryTime == null) return Duration.zero;

//     final expiry = int.tryParse(expiryTime);
//     if (expiry == null) return Duration.zero;

//     final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//     return Duration(seconds: expiry - currentTime);
//   }
//   TradeHistory toTradeHistory({double? profit, double? loss}) {
//     return TradeHistory(
//       id: id,
//       orderId: id,
//       symbol: symbol,
//       amount: amount,
//       strikePrice: strikePrice,
//       orderPlacedTimestamp: createdAt,
//       orderExecutedTimestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       profit: profit,
//       loss: loss,
//       timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
//     );
//   }
// }




import 'package:olymp_trade/features/model/trade_history_model.dart';

class OrderGet {
  String id;
  // int idInt;
  String symbol;
  double amount;
  double strikePrice;
  int orderStatus;
  int createdAt;
  String expiryTime; 
  int?orderDuration;

  OrderGet({
    required this.id,
    // required this.idInt,
    required this.symbol,
    required this.amount,
    required this.strikePrice,
    required this.orderStatus,
    required this.createdAt,
    required this.expiryTime,
    required this.orderDuration,
  });

factory OrderGet.fromJson(Map<String, dynamic> json) {
  return OrderGet(
    id: json['order_id'] ?? json['id'] ?? '', 
    symbol: json['symbol'] ?? '',
    amount: json['amount']?.toDouble() ?? 0.0,
    strikePrice: json['strike_price']?.toDouble() ?? 0.0,
    orderStatus: json['order_type'] ?? 0,
    createdAt: json['order_placed_timestamp'] ?? 0,
    expiryTime: json['expiry_time']?.toString() ?? '0',
    orderDuration: json['order_duration'] ?? 0,
  );
}

Duration getRemainingTime() {
  try {
    final expiry = DateTime.parse(expiryTime).millisecondsSinceEpoch ~/ 1000;
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return Duration(seconds: expiry - currentTime);
  } catch (e) {
    print('[OrderGet] Error parsing expiryTime: $e');
    return Duration.zero;
  }
}



TradeHistory toTradeHistory({double? profit, double? loss}) {
  return TradeHistory(
    id: id,
    orderId: id,
    symbol: symbol,
    amount: amount,
    strikePrice: strikePrice,
    orderPlacedTimestamp: createdAt,
    orderExecutedTimestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    profit: profit,
    loss: loss,
    timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  );
} 
}

