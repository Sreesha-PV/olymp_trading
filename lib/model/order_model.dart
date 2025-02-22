enum OrderType{
    Put,
    Call,
    Default
  }

  extension FromJson on OrderType {

   OrderType from(String orderType){
      if(orderType=="Put"){
        return OrderType.Put;
      }else{
        return OrderType.Call;
      }
    }

  }
  OrderType? fromString(String orderType) {
  return OrderType.values.firstWhere((e) => e.toString().split('.').last == orderType, orElse: () => OrderType.Default);
}

class TradingOrder {
 late final int minute;  
  late final double amount;  
  late final int duration;   
  late final Enum orderType;        

  TradingOrder({
    required this.amount,
    required this.duration,
    required this.orderType,
  });

  factory TradingOrder.fromJson(Map<String, dynamic> json) {

    return TradingOrder(
    
      // time: json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
      amount: json['amount'] ?? 0.0,
      duration: json['duration'] ?? 0,
      // open: json['open'] ?? 0.0,
      // close: json['close'] ?? 0.0,
      // high: json['high'] ?? 0.0,
      // low: json['low'] ?? 0.0,
      orderType: fromString(json['order_type'] as String)?? OrderType.Default,
    );
  }
}


 
