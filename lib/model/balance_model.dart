class Balance{
  double? availableBalance;

  Balance({this.availableBalance});

  Balance.fromJson(Map<String, dynamic> json) {
    var data = json["data"];
    availableBalance = data['available_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available_balance'] = this.availableBalance;
    return data;
  }
}







void _handleWebSocketData(dynamic message) {
  final data = json.decode(message);
  final orderId = data['id'];
  final closePrice = data['strikePrice']; // Only strikePrice received
  final completedAt = DateTime.parse(data['completedAt']);

  final matchedOrderIndex = _orders.indexWhere((order) => order.id == orderId);

  if (matchedOrderIndex != -1) {
    final order = _orders[matchedOrderIndex];

    // Calculate profit or loss
    double pnl = 0;
    bool isProfit = false;

    if (order.type == 'buy') {
      pnl = (closePrice - order.openPrice) * order.amount;
      isProfit = closePrice > order.openPrice;
    } else if (order.type == 'sell') {
      pnl = (order.openPrice - closePrice) * order.amount;
      isProfit = closePrice < order.openPrice;
    }

    final tradeHistory = TradeHistory(
      id: order.id,
      symbol: order.symbol,
      openPrice: order.openPrice,
      closePrice: closePrice,
      amount: order.amount,
      createdAt: order.createdAt,
      completedAt: completedAt,
      profitOrLoss: pnl,
      isProfit: isProfit,
    );

    _orders.removeAt(matchedOrderIndex);
    notifyListeners();

    // Add to history
    tradeHistoryProvider.addOrderToHistory(tradeHistory);
  }
}
