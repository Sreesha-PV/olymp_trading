class OrderCreationRequest {
  int? userIdInt;
  String? userId;
  String? symbol;
  int? orderType;
  double? amount;
  double? strikePrice;
  int? orderDuration;

  OrderCreationRequest({ 
       this.userIdInt,
       this.userId,
       this.symbol,
       this.orderType,
       this.amount,
       this.strikePrice,
       this.orderDuration,
       });

 

  OrderCreationRequest.fromJson(Map<String, dynamic> json) {
 
    userIdInt = json['user_id_int'];
    userId = json['user_id'];
    symbol = json['symbol'];
    orderType = json['order_type'];
    amount = json['amount'];
    strikePrice = json['strike_price'];
    orderDuration = json['order_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['user_id_int'] = userIdInt;
    data['user_id'] = userId;
    data['symbol'] = symbol;
    data['order_type'] = orderType;
    data['amount'] = amount;
    data['strike_price'] = strikePrice;
    data['order_duration'] = orderDuration;
    return data;
  }
}




