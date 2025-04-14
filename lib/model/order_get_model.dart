// class OrderGet {
//   String? id;
//   int? idInt;
//   int? userIdInt;
//   String? userId;
//   String? symbol;
//   int? symbolIdInt;
//   int? orderType;
//   int? amount;
//   int? orderDuration;
//   double? strikePrice;

//   OrderGet({
//     this.id,
//     this.idInt,
//     this.userIdInt,
//     this.userId,
//     this.symbol,
//     this.symbolIdInt,
//     this.orderType,
//     this.amount,
//     this.orderDuration,
//     this.strikePrice,
//   });

//   OrderGet.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idInt = json['id_int'];
//     userIdInt = json['user_id_int'];
//     userId = json['user_id'];
//     symbol = json['symbol'];
//     symbolIdInt = json['symbol_id_int'];
//     orderType = json['order_type'];
//     amount = json['amount'];
//     orderDuration = json['order_duration'];
//     strikePrice = json['strike_price'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['id_int'] = idInt;
//     data['user_id_int'] = userIdInt;
//     data['user_id'] = userId;
//     data['symbol'] = symbol;
//     data['symbol_id_int'] = symbolIdInt;
//     data['order_type'] = orderType;
//     data['amount'] = amount;
//     data['order_duration'] = orderDuration;
//     data['strike_price'] = strikePrice;
//     return data;
//   }
// }




// import 'package:olymp_trade/features/model/trade_history_model.dart';

// class OrderGet {
//   String? id;
//   int? idInt;
//   int? userIdInt;
//   String? userId;
//   String? symbol;
//   String? symbolId;
//   int? symbolIdInt;
//   int? orderType;
//   double? amount;
//   String? expiryTime;
//   int? orderDuration;
//   double? strikePrice;
//   int? orderStatus;
//   int? updatedAt;
//   int? createdAt;

//   OrderGet(
//       {this.id,
//       this.idInt,
//       this.userIdInt,
//       this.userId,
//       this.symbol,
//       this.symbolId,
//       this.symbolIdInt,
//       this.orderType,
//       this.amount,
//       this.expiryTime,
//       this.orderDuration,
//       this.strikePrice,
//       this.orderStatus,
//       this.updatedAt,
//       this.createdAt});

//   OrderGet.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     idInt = json['id_int'];
//     userIdInt = json['user_id_int'];
//     userId = json['user_id'];
//     symbol = json['symbol'];
//     symbolId = json['symbol_id'];
//     symbolIdInt = json['symbol_id_int'];
//     orderType = json['order_type'];
//     amount = json['amount'];
//     expiryTime = json['expiry_time'];
//     orderDuration = json['order_duration'];
//     strikePrice = json['strike_price'];
//     orderStatus = json['order_status'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['id_int'] = this.idInt;
//     data['user_id_int'] = this.userIdInt;
//     data['user_id'] = this.userId;
//     data['symbol'] = this.symbol;
//     data['symbol_id'] = this.symbolId;
//     data['symbol_id_int'] = this.symbolIdInt;
//     data['order_type'] = this.orderType;
//     data['amount'] = this.amount;
//     data['expiry_time'] = this.expiryTime;
//     data['order_duration'] = this.orderDuration;
//     data['strike_price'] = this.strikePrice;
//     data['order_status'] = this.orderStatus;
//     data['updated_at'] = this.updatedAt;
//     data['created_at'] = this.createdAt;
//     return data;
//   }

  
//   TradeHistory toTradeHistory() {
//   return TradeHistory(
//     symbol: this.symbol,
//     amount: this.amount,
//     strikePrice: this.strikePrice,
//     timestamp: this.createdAt ?? DateTime.now().millisecondsSinceEpoch, 
//     profit: 0,
//     loss: 0,  
//   );
// }

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
      id: json['order_id'] ?? '',
      // idInt: json['order_id_int'] ?? 0, 
      symbol: json['symbol'] ?? '', 
      amount: json['amount']?.toDouble() ?? 0.0, 
      strikePrice: json['strike_price']?.toDouble() ?? 0.0, 
      orderStatus: json['order_type'] ?? 0, 
      createdAt: json['order_placed_timestamp'] ?? 0, 
      // expiryTime: json['expiry_time'] ?? 0, 
      expiryTime: json['expiry_time']?.toString() ?? '0',
      orderDuration: json['order_duration']??0
      
    );
  }

Duration getRemainingTime() {
  if (expiryTime == null) return Duration.zero;

  final expiry = int.tryParse(expiryTime);
  if (expiry == null) return Duration.zero;

  final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  return Duration(seconds: expiry - currentTime);
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
