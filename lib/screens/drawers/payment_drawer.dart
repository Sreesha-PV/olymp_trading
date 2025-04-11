import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/selected_index_provider.dart';

class PaymentDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const PaymentDrawer({
    super.key,
    required this.selectedIndex, 
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {



    return Drawer(
  
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
      child: ListView(
        padding: const EdgeInsets.only(left: 15),
        children: [
          const Row(
            children: [
              Text(
                'Payments',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Container(

            height: 70,
            child: Card(
              color: Colors.green,
              child: ListTile(
                leading: const Icon(Icons.wallet),
                iconColor: Colors.black,
                title: const Text(
                  'Deposit',
                  style: TextStyle(color: Colors.black),),
                  onTap: () {
                    Provider.of<SelectedIndexNotifier>(context,listen:false)
                    .updateSelectedIndex(0);
                    Scaffold.of(context).openDrawer();
                    Scaffold.hasDrawer(context);
                  },                  
              ),
            ),
          ),

          Container(
            height: 70,
            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(Icons.wallet_rounded),
                iconColor: Colors.white,
                title: Text('Withdraw',style: TextStyle(color: Colors.white),),
                
              ),
            ),
          ),
          
          Container(
            height: 70,
            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(CupertinoIcons.arrow_right_arrow_left),
                iconColor: Colors.white,
                title: Text('Transfer',style: TextStyle(color: Colors.white),),
               
              ),
            ),
          ),
          Container(
            height: 70,

            child: Card(
              color: Colors.grey[850],
              child: const ListTile(
                leading: Icon(Icons.history),
                iconColor: Colors.white,
                title: Text('Transaction',style: TextStyle(color: Colors.white),),
                
              ),
            ),
          )
        ],
      ),
    );
  }
  
 
}








import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/provider/active_order_provider.dart';
import 'package:olymp_trade/features/provider/trade_history_provider.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final WebSocketChannel channel;

  WebSocketService(String url) : channel = WebSocketChannel.connect(Uri.parse(url));

  // Listen for updates on trade expiry or completion
  void listen(
      BuildContext context,
      ActiveOrderProvider activeOrderProvider,
      TradeHistoryProvider tradeHistoryProvider) {
    channel.stream.listen((message) {
      // Parse the incoming message
      final data = jsonDecode(message);
      _handleTradeUpdate(data, activeOrderProvider, tradeHistoryProvider);
    });
  }

  // Handle the trade update when the WebSocket sends data
  void _handleTradeUpdate(
      Map<String, dynamic> data,
      ActiveOrderProvider activeOrderProvider,
      TradeHistoryProvider tradeHistoryProvider) {
    // Check if the order is completed or expired
    String orderId = data['order_id'];  // You might need to adjust based on actual data
    bool isTradeExpired = data['is_expired'] ?? false;
    double finalPrice = data['final_price'] ?? 0.0;

    // Move to trade history when the trade is expired
    if (isTradeExpired) {
      // Calculate profit or loss
      OrderGet activeOrder = activeOrderProvider.getOrderById(orderId);
      double profitOrLoss = finalPrice - activeOrder.strikePrice!;

      // Create a TradeHistory entry and add it
      TradeHistory newTradeHistory = TradeHistory(
        orderId: activeOrder.id,
        symbol: activeOrder.symbol,
        strikePrice: activeOrder.strikePrice,
        finalPrice: finalPrice,
        amount: activeOrder.amount,
        profit: profitOrLoss > 0 ? profitOrLoss : 0,
        loss: profitOrLoss < 0 ? profitOrLoss : 0,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      tradeHistoryProvider.addTradeHistory(newTradeHistory);

      // Remove the order from active orders
      activeOrderProvider.removeOrder(orderId);
    }
  }

  // Close the WebSocket connection when it's no longer needed
  void close() {
    channel.sink.close();
  }
}




import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';

class ActiveOrderProvider with ChangeNotifier {
  List<OrderGet> orders = [];

  // Get an order by ID
  OrderGet getOrderById(String orderId) {
    return orders.firstWhere((order) => order.id == orderId);
  }

  // Add an active order
  void addOrder(OrderGet order) {
    orders.add(order);
    notifyListeners();
  }

  // Remove an order from active orders
  void removeOrder(String orderId) {
    orders.removeWhere((order) => order.id == orderId);
    notifyListeners();
  }
}



import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';

class TradeHistoryProvider with ChangeNotifier {
  List<TradeHistory> tradeHistory = [];

  // Add a new trade to the history
  void addTradeHistory(TradeHistory tradeHistoryEntry) {
    tradeHistory.add(tradeHistoryEntry);
    notifyListeners();
  }
}





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:olymp_trade/features/provider/active_order_provider.dart';
import 'package:olymp_trade/features/provider/trade_history_provider.dart';
import 'package:olymp_trade/services/websocket_services.dart';

class FixedTimePage extends StatelessWidget {
  final WebSocketService _webSocketService;

  FixedTimePage({super.key})
      : _webSocketService = WebSocketService('ws://192.168.4.30:4600/ws/1003');

  @override
  Widget build(BuildContext context) {
    // Initialize WebSocket to listen for updates
    _webSocketService.listen(
      context,
      Provider.of<ActiveOrderProvider>(context, listen: false),
      Provider.of<TradeHistoryProvider>(context, listen: false),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixed Time Trading'),
      ),
      body: Consumer2<ActiveOrderProvider, TradeHistoryProvider>(
        builder: (context, activeOrderProvider, tradeHistoryProvider, child) {
          return ListView(
            children: [
              _buildActiveTradesSection(activeOrderProvider),
              _buildTradeHistorySection(tradeHistoryProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActiveTradesSection(ActiveOrderProvider activeOrderProvider) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Active Trades',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        if (activeOrderProvider.orders.isEmpty)
          const Text('No active trades.')
        else
          ..._buildActiveOrdersList(activeOrderProvider),
      ],
    );
  }

  Widget _buildTradeHistorySection(TradeHistoryProvider tradeHistoryProvider) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Trade History',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        if (tradeHistoryProvider.tradeHistory.isEmpty)
          const Text('No trade history.')
        else
          ..._buildTradeHistoryList(tradeHistoryProvider),
      ],
    );
  }

  List<Widget> _buildActiveOrdersList(ActiveOrderProvider activeOrderProvider) {
    return activeOrderProvider.orders.map((order) {
      return ListTile(
        title: Text(order.symbol!),
        subtitle: Text('Strike Price: ${order.strikePrice}'),
      );
    }).toList();
  }

  List<Widget> _buildTradeHistoryList(TradeHistoryProvider tradeHistoryProvider) {
    return tradeHistoryProvider.tradeHistory.map((trade) {
      return ListTile(
        title: Text(trade.symbol!),
        subtitle: Text('Profit: ${trade.profit}, Loss: ${trade.loss}'),
      );
    }).toList();
  }
}
