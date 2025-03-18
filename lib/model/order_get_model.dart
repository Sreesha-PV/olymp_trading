class OrderGet {
  String? id;
  int? idInt;
  int? userIdInt;
  String? userId;
  String? symbol;
  int? symbolIdInt;
  int? orderType;
  int? amount;
  int? orderDuration;
  double? strikePrice;

  OrderGet({
    this.id,
    this.idInt,
    this.userIdInt,
    this.userId,
    this.symbol,
    this.symbolIdInt,
    this.orderType,
    this.amount,
    this.orderDuration,
    this.strikePrice,
  });

  OrderGet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idInt = json['id_int'];
    userIdInt = json['user_id_int'];
    userId = json['user_id'];
    symbol = json['symbol'];
    symbolIdInt = json['symbol_id_int'];
    orderType = json['order_type'];
    amount = json['amount'];
    orderDuration = json['order_duration'];
    strikePrice = json['strike_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_int'] = idInt;
    data['user_id_int'] = userIdInt;
    data['user_id'] = userId;
    data['symbol'] = symbol;
    data['symbol_id_int'] = symbolIdInt;
    data['order_type'] = orderType;
    data['amount'] = amount;
    data['order_duration'] = orderDuration;
    data['strike_price'] = strikePrice;
    return data;
  }
}
