class TradeHistory {
  String? id;
  String? orderId;
  int? orderIdInt;
  String? userId;
  int? userIdInt;
  String? symbol;
  int? symbolIdInt;
  String? symbolId;
  double? strikePrice;
  double? finalPrice;
  int? orderType;
  int? tradeOutcome;
  double? amount;
  double? profit;
  double? loss;
  int? orderPlacedTimestamp;
  int? orderExecutedTimestamp;
  int? timestamp;

  DateTime? orderPlacedTime;
  DateTime? orderExecutedTime;
  DateTime? tradeTimestamp;

  TradeHistory({
    this.id,
    this.orderId,
    this.orderIdInt,
    this.userId,
    this.userIdInt,
    this.symbol,
    this.symbolIdInt,
    this.symbolId,
    this.strikePrice,
    this.finalPrice,
    this.orderType,
    this.tradeOutcome,
    this.amount,
    this.profit,
    this.loss,
    this.orderPlacedTimestamp,
    this.orderExecutedTimestamp,
    this.timestamp,
  });
  
  @override
    String toString() {
      return 'TradeHistory(symbol: $symbol, amount: $amount, strikePrice: $strikePrice, profit: $profit, loss: $loss, timestamp: $timestamp)';
    }

  TradeHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    orderIdInt = json['order_id_int'];
    userId = json['user_id'];
    userIdInt = json['user_id_int'];
    symbol = json['symbol'];
    symbolIdInt = json['symbol_id_int'];
    symbolId = json['symbol_id'];
    strikePrice = json['strike_price'];
    finalPrice = json['final_price'];
    orderType = json['order_type'];
    tradeOutcome = json['trade_outcome'];
    amount = json['amount'];
    profit = json['profit'];
    loss = json['loss'];
    orderPlacedTimestamp = json['order_placed_timestamp'];
    orderExecutedTimestamp = json['order_executed_timestamp'];
    timestamp = json['timestamp'];

   
    orderPlacedTime = orderPlacedTimestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(orderPlacedTimestamp! * 1000)
        : null;
    orderExecutedTime = orderExecutedTimestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(orderExecutedTimestamp! * 1000)
        : null;
    tradeTimestamp = timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['order_id_int'] = this.orderIdInt;
    data['user_id'] = this.userId;
    data['user_id_int'] = this.userIdInt;
    data['symbol'] = this.symbol;
    data['symbol_id_int'] = this.symbolIdInt;
    data['symbol_id'] = this.symbolId;
    data['strike_price'] = this.strikePrice;
    data['final_price'] = this.finalPrice;
    data['order_type'] = this.orderType;
    data['trade_outcome'] = this.tradeOutcome;
    data['amount'] = this.amount;
    data['profit'] = this.profit;
    data['loss'] = this.loss;
    data['order_placed_timestamp'] = this.orderPlacedTimestamp;
    data['order_executed_timestamp'] = this.orderExecutedTimestamp;
    data['timestamp'] = this.timestamp;
    return data;
  }

  Duration? getTradeDuration() {
    if (orderPlacedTime != null && orderExecutedTime != null) {
      return orderExecutedTime!.difference(orderPlacedTime!);
    }
    return null;
  }
}



