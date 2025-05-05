import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:olymp_trade/features/provider/tradesocket_provider.dart';
import 'package:provider/provider.dart';

class FixedTimePage extends StatelessWidget {
  const FixedTimePage({super.key});
 

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Stream<int> _timerStream(
    int startDuration,
    OrderGet order,
    TradeSocketProvider socketProvider,
    BuildContext context,
  )
  {
    return Stream.periodic(const Duration(seconds: 1), (tick) {
      int remainingTime = startDuration - tick - 1;
      if (remainingTime <= 0) {
        // showTradeExpiredDialog(context);
      }
      return remainingTime < 0 ? 0 : remainingTime;
    });
  }
  // void _showTradeExpiredDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Trade Expired'),
  //         content: const Text('The trade has expired and moved to history.'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
           


    return Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),
      child: Consumer<TradeSocketProvider>(
          
        builder: (context, socketProvider, _) {
          print('[UI] Rebuilding Active Orders: ${socketProvider.activeOrders.length}');

          return ListView(
            padding: const EdgeInsets.only(left: 15),
            children: [
              _buildActiveTradesSection(socketProvider, context),
              _buildTradeHistorySection(socketProvider),
            ],
          );
        },
      ),
    );

}
  Widget _buildActiveTradesSection(
     TradeSocketProvider socketProvider, BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Active Trades',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (socketProvider.activeOrders.isEmpty)
          ..._buildNoActiveTradesSection()
        else
          _buildActiveOrdersList(socketProvider, context),
      ],
    );
  }

  List<Widget> _buildNoActiveTradesSection() {
    return [
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.arrow_up,
                size: 80,
                color: Colors.grey[800],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.arrow_down,
                size: 80,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'You have no open Fixed Time trades on this account',
          style: TextStyle(
            color: Color.fromARGB(255, 230, 245, 247),
            fontSize: 15,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[800],
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Explore Assets',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }
  // List<Widget> _buildActiveOrdersList(
  Widget _buildActiveOrdersList(
  TradeSocketProvider socketProvider, BuildContext context) {
    
    final validOrders = socketProvider.activeOrders.where((o) => o.id.isNotEmpty).toList();


    print('[UI] Active Orders Length: ${socketProvider.activeOrders.length}');
    for (var order in socketProvider.activeOrders) {
      print('[UI] Order ID: ${order.id}, Symbol: ${order.symbol}, Duration: ${order.orderDuration}, Amount:${order.amount}');
    }

    return 
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: socketProvider.activeOrders.length,
        itemBuilder: (context, index) {
          final order = socketProvider.activeOrders[index];
          
          // final order = socketProvider.activeOrders.where((o) => o.id != null && o.id.isNotEmpty).toList();

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${order.symbol}',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    // Text(
                    //     _formatRemainingTime(order),
                    //     style: const TextStyle(color: Colors.grey, fontSize: 14),
                    //   ),

                    StreamBuilder<int>(
                      stream: _timerStream(order.orderDuration! * 60, order,
                          socketProvider,context),
                
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          return Text(
                            _formatDuration(snapshot.data!),
                            // _formatDuration(order.getRemainingTime().inSeconds),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          );
                        } else {
                          return const Text(
                            '00:00',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          );
                          
                        }
                      },
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ð ${order.amount}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${order.strikePrice}',
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ), 
                onTap: () {},
              ),
            ),
          );
        },
      ); 
    }


  Widget _buildTradeHistorySection(TradeSocketProvider socketProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'History',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (socketProvider.tradeHistory.isEmpty)
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'No trade history available.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          )
        else
          ..._buildTradeHistoryList(socketProvider.tradeHistory),
      ],
    );
  }

  List<Widget> _buildTradeHistoryList(List<TradeHistory> history) {

    return [
      ListView.builder(
        shrinkWrap: true,
        itemCount: history.length,
        itemBuilder: (context, index) {
          final trade = history[index];
          // DateTime tradeTime = DateTime.fromMillisecondsSinceEpoch(trade.timestamp! * 1000);
          DateTime tradeTime = DateTime.fromMillisecondsSinceEpoch(
            (trade.timestamp ??
                    trade.orderExecutedTimestamp ??
                    trade.orderPlacedTimestamp ??
                    DateTime.now().millisecondsSinceEpoch ~/ 1000) *
                1000,
          );

          String formattedTime = '${tradeTime.minute} min';
          // print(
          //     '[UI] TradeHistory - Profit: ${trade.profit}, Loss: ${trade.loss}');
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${trade.symbol}',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      formattedTime,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ð ${trade.amount}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          '+Ð${trade.profit ?? 0}',
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '/ -Ð${trade.loss ?? 0}',
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    ];
  }
}



