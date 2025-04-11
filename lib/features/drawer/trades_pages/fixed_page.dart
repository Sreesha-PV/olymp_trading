// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:olymp_trade/features/model/transaction_model.dart';
// // import 'package:olymp_trade/features/provider/active_order_provider.dart';
// // import 'package:olymp_trade/features/provider/selected_account_provider.dart';
// // import 'package:provider/provider.dart';
// // import '../../../provider/transaction_history_provider.dart';

// // class FixedTimePage extends StatelessWidget {
// //   const FixedTimePage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final selectedAccountNotifier = Provider.of<SelectedAccountNotifier>(context);

// //     return Drawer(
// //       backgroundColor: const Color.fromARGB(255, 24, 23, 23),
// //       child: Consumer<ActiveOrderProvider>(
// //         builder: (context, activeOrderProvider, child) {
// //           return ListView(
// //             padding: const EdgeInsets.only(left: 15),
// //             children: [
// //               const Row(
// //                 children: [
// //                   Padding(
// //                     padding: EdgeInsets.all(10),
// //                     child: Text(
// //                       'Active Trades',
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 24,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 20),
// //               if (activeOrderProvider.orders.isEmpty) ...[
// //                 const SizedBox(height: 30),
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 30),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Icon(
// //                         CupertinoIcons.arrow_down_right_arrow_up_left,
// //                         size: 80,
// //                         color: Colors.grey[800],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20),
// //                 const Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       'You have no open Fixed Time trades on',
// //                       style: TextStyle(color: Color.fromARGB(255, 230, 245, 247), fontSize: 15),
// //                     ),
// //                   ],
// //                 ),
// //                 const Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       'this account',
// //                       style: TextStyle(color: Color.fromARGB(255, 230, 245, 247), fontSize: 15),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 20),
// //                 Padding(
// //                   padding: const EdgeInsets.all(8),
// //                   child: Row(
// //                     children: [
// //                       Container(
// //                         height: 50,
// //                         width: 250,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(12),
// //                           color: Colors.grey[800],
// //                         ),
// //                         child: TextButton(
// //                           onPressed: () {},
// //                           child: const Text(
// //                             'Explore Assets',
// //                             style: TextStyle(color: Colors.white),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ] else ...[
// //                 // Display active orders
// //                 for (var order in activeOrderProvider.orders) ...[
// //                   Padding(
// //                     padding: const EdgeInsets.all(8),
// //                     child: Row(
// //                       children: [
// //                         Container(
// //                           height: 50,
// //                           width: 250,
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(12),
// //                             color: Colors.grey[800],
// //                           ),
// //                           child: TextButton(
// //                             onPressed: () {},
// //                             child: Text(
// //                               'Active Order: ${order.direction} - ${order.amount} AED for ${order.time}',
// //                               style: const TextStyle(color: Colors.white),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ]
// //               ],
// //               if (selectedAccountNotifier.selectedAccount == 'Demo Account') ...[
// //                 _buildTransactionHistory(),
// //               ]
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // Widget _buildTransactionHistory() {
// //   return Consumer<TransactionHistoryProvider>(
// //     builder: (context, transactionProvider, child) {
// //       return FutureBuilder<List<Transaction>>(
// //         future: transactionProvider.fetchTransactions(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(
// //               child: Text(
// //                 snapshot.error.toString(),
// //                 style: const TextStyle(color: Colors.red, fontSize: 16),
// //               ),
// //             );
// //           }

// //           if (snapshot.hasData && snapshot.data!.isNotEmpty) {
// //             var transactions = snapshot.data!;
// //             return ListView.builder(
// //               itemCount: transactions.length,
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemBuilder: (context, index) {
// //                 final transaction = transactions[index];
// //                 return Card(
// //                   color: Colors.grey[850],
// //                   child: ListTile(
// //                     title: Text(transaction.title),
// //                     subtitle: Row(
// //                       children: [
// //                         Text(
// //                           transaction.amount,
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 10),
// //                         Icon(
// //                           transaction.directionIcon,
// //                           color: transaction.directionColor,
// //                           size: 20,
// //                         ),
// //                       ],
// //                     ),
// //                     trailing: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.end,
// //                       children: [
// //                         Text(transaction.time),
// //                         const SizedBox(height: 5),
// //                         Text(
// //                           transaction.statusAmount,
// //                           style: TextStyle(
// //                             color: transaction.statusColor,
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.normal,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           } else {
// //             return const Center(
// //               child: Text('No transaction history available.'),
// //             );
// //           }
// //         },
// //       );
// //     },
// //   );
// // }
// // }











// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/features/model/order_get_model.dart';
// import 'package:olymp_trade/features/provider/active_order_provider.dart';
// import 'package:olymp_trade/features/provider/trade_history_provider.dart';
// import 'package:provider/provider.dart';

// class FixedTimePage extends StatelessWidget {
//   const FixedTimePage({super.key});

//   String _formatDuration(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   Stream<int> _timerStream(
//     int startDuration,
//     OrderGet order,
//     ActiveOrderProvider activeOrderProvider,
//     BuildContext context,
//   ) {
//     bool isMovedToHistory = false;

//     return Stream.periodic(const Duration(seconds: 1), (tick) {
//       int remainingTime = startDuration - tick - 1;

//       if (remainingTime <= 0 && !isMovedToHistory) {
//         activeOrderProvider.moveOrderToHistory(order);
//         isMovedToHistory = true;
//         _showTradeExpiredDialog(context);
//       }
//       return remainingTime < 0 ? 0 : remainingTime;
//     });
//   }

//   void _showTradeExpiredDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Trade Expired'),
//           content: const Text('The trade has expired and moved to history.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tradeHistoryProvider = Provider.of<TradeHistoryProvider>(context, listen: false);
//     final activeOrderProvider = Provider.of<ActiveOrderProvider>(context, listen: false);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       activeOrderProvider.fetchOrders();
//     });

//     return Drawer(
//       backgroundColor: const Color.fromARGB(255, 24, 23, 23),
//       child: Consumer2<ActiveOrderProvider, TradeHistoryProvider>(
//         builder: (context, activeOrderProvider, tradeHistoryProvider, child) {
//           return ListView(
//             padding: const EdgeInsets.only(left: 15),
//             children: [
//               _buildActiveTradesSection(activeOrderProvider, context),
//               _buildTradeHistorySection(tradeHistoryProvider),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildActiveTradesSection(ActiveOrderProvider activeOrderProvider, BuildContext context) {
//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(10),
//           child: Text(
//             'Active Trades',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 24,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         if (activeOrderProvider.orders.isEmpty)
//           ..._buildNoActiveTradesSection()
//         else
//           ..._buildActiveOrdersList(activeOrderProvider, context),
//       ],
//     );
//   }

//   List<Widget> _buildNoActiveTradesSection() {
//     return [
//       const SizedBox(height: 30),
//       Padding(
//         padding: const EdgeInsets.only(top: 30),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 CupertinoIcons.arrow_up,
//                 size: 80,
//                 color: Colors.grey[800],
//               ),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 CupertinoIcons.arrow_down,
//                 size: 80,
//                 color: Colors.grey[800],
//               ),
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(height: 20),
//       const Padding(
//         padding: EdgeInsets.all(10),
//         child: Text(
//           'You have no open Fixed Time trades on this account',
//           style: TextStyle(
//             color: Color.fromARGB(255, 230, 245, 247),
//             fontSize: 15,
//           ),
//         ),
//       ),
//       const SizedBox(height: 20),
//       Padding(
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           children: [
//             Container(
//               height: 50,
//               width: 250,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.grey[800],
//               ),
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Explore Assets',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ];
//   }

//   List<Widget> _buildActiveOrdersList(ActiveOrderProvider activeOrderProvider, BuildContext context) {
//     return [
//       ListView.builder(
//         shrinkWrap: true,
//         itemCount: activeOrderProvider.orders.length,
//         itemBuilder: (context, index) {
//           final order = activeOrderProvider.orders[index];
//           return Padding(
//             padding: const EdgeInsets.all(8),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: ListTile(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${order.symbol}',
//                       style: const TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                     const SizedBox(width: 10),
//                     StreamBuilder<int>(
//                       stream: _timerStream(order.orderDuration! * 60, order, activeOrderProvider, context),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return const CircularProgressIndicator();
//                         } else if (snapshot.hasData) {
//                           return Text(
//                             _formatDuration(snapshot.data!),
//                             style: const TextStyle(color: Colors.grey, fontSize: 14),
//                           );
//                         } else {
//                           return const Text(
//                             '00:00',
//                             style: TextStyle(color: Colors.grey, fontSize: 14),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//                 subtitle: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Ð ${order.amount}',
//                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       '${order.strikePrice}',
//                       style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 onTap: () {},
//               ),
//             ),
//           );
//         },
//       ),
//     ];
//   }

//   Widget _buildTradeHistorySection(TradeHistoryProvider tradeHistoryProvider) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.all(10),
//           child: Text(
//             'History',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 24,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         if (tradeHistoryProvider.isLoading)
//           const Center(child: CircularProgressIndicator())
//         else if (tradeHistoryProvider.tradeHistory.isEmpty)
//           const Padding(
//             padding: EdgeInsets.all(10),
//             child: Text(
//               'No trade history available.',
//               style: TextStyle(color: Colors.grey, fontSize: 16),
//             ),
//           )
//         else
//           ..._buildTradeHistoryList(tradeHistoryProvider),
//       ],
//     );
//   }

//   List<Widget> _buildTradeHistoryList(TradeHistoryProvider tradeHistoryProvider) {
//     return [
//       ListView.builder(
//         shrinkWrap: true,
//         itemCount: tradeHistoryProvider.tradeHistory.length,
//         itemBuilder: (context, index) {
//           final trade = tradeHistoryProvider.tradeHistory[index];
//           DateTime tradeTime = DateTime.fromMillisecondsSinceEpoch(trade.timestamp! * 1000);
//           String formattedTime = '${tradeTime.minute} min';

//           return Padding(
//             padding: const EdgeInsets.all(8),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: ListTile(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${trade.symbol}',
//                       style: const TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       formattedTime,
//                       style: const TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 subtitle: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Ð ${trade.amount}',
//                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(width: 10),
//                     Row(
//                       children: [
//                         Text(
//                       '+Ð${trade.profit}',
//                       style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       '/ -Ð${trade.loss}',
//                       style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                     ),
//                       ],
//                     )
//                     // Text(
//                     //   '+Ð${trade.profit}',
//                     //   style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//                     // ),
//                     // Text(
//                     //   '/ -Ð${trade.loss}',
//                     //   style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                     // ),
//                   ],
//                 ),
//                 onTap: () {},
//               ),
//             ),
//           );
//         },
//       ),
//     ];
//   }
// }









import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/provider/active_order_provider.dart';
import 'package:olymp_trade/features/provider/trade_history_provider.dart';
import 'package:olymp_trade/services/websocket_services.dart';
import 'package:provider/provider.dart';

class FixedTimePage extends StatelessWidget {
   FixedTimePage({super.key});
  final WebSocketService _webSocketService = WebSocketService('ws://192.168.4.30:4600/ws/1003');

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Stream<int> _timerStream(
    int startDuration,
    OrderGet order,
    ActiveOrderProvider activeOrderProvider,
    BuildContext context,
  ) {
    return Stream.periodic(const Duration(seconds: 1), (tick) {
      int remainingTime = startDuration - tick - 1;
      if (remainingTime <= 0) {
        _showTradeExpiredDialog(context); // Show dialog on expiration
      }
      return remainingTime < 0 ? 0 : remainingTime;
    });
  }

  void _showTradeExpiredDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Trade Expired'),
          content: const Text('The trade has expired and moved to history.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     _webSocketService.listen();
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),
      child: Consumer2<ActiveOrderProvider, TradeHistoryProvider>(
        builder: (context, activeOrderProvider, tradeHistoryProvider, child) {
          return ListView(
            padding: const EdgeInsets.only(left: 15),
            children: [
              _buildActiveTradesSection(activeOrderProvider, context),
              _buildTradeHistorySection(tradeHistoryProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActiveTradesSection(ActiveOrderProvider activeOrderProvider, BuildContext context) {
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
        if (activeOrderProvider.orders.isEmpty)
          ..._buildNoActiveTradesSection()
        else
          ..._buildActiveOrdersList(activeOrderProvider, context),
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

  List<Widget> _buildActiveOrdersList(ActiveOrderProvider activeOrderProvider, BuildContext context) {
    return [
      ListView.builder(
        shrinkWrap: true,
        itemCount: activeOrderProvider.orders.length,
        itemBuilder: (context, index) {
          final order = activeOrderProvider.orders[index];
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
                    StreamBuilder<int>(
                      stream: _timerStream(order.orderDuration! * 60, order, activeOrderProvider, context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          return Text(
                            _formatDuration(snapshot.data!),
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${order.strikePrice}',
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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

  Widget _buildTradeHistorySection(TradeHistoryProvider tradeHistoryProvider) {
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
        if (tradeHistoryProvider.tradeHistory.isEmpty)
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'No trade history available.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          )
        else
          ..._buildTradeHistoryList(tradeHistoryProvider),
      ],
    );
  }

  List<Widget> _buildTradeHistoryList(TradeHistoryProvider tradeHistoryProvider) {
    return [
      ListView.builder(
        shrinkWrap: true,
        itemCount: tradeHistoryProvider.tradeHistory.length,
        itemBuilder: (context, index) {
          final trade = tradeHistoryProvider.tradeHistory[index];
          DateTime tradeTime = DateTime.fromMillisecondsSinceEpoch(trade.timestamp! * 1000);
          String formattedTime = '${tradeTime.minute} min';

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
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          '+Ð${trade.profit}',
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '/ -Ð${trade.loss}',
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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


















import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:olymp_trade/features/provider/tradesocket%20provider.dart';
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
   
    BuildContext context,
  ) {
    return Stream.periodic(const Duration(seconds: 1), (tick) {
      int remainingTime = startDuration - tick - 1;
      if (remainingTime <= 0) {
        _showTradeExpiredDialog(context); 
      }
      return remainingTime < 0 ? 0 : remainingTime;
    });
  }
  
  void _showTradeExpiredDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Trade Expired'),
          content: const Text('The trade has expired and moved to history.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),
      child: Consumer<TradeSocketProvider>(
        builder: (context, socketProvider, _) {
          return ListView(
            padding: const EdgeInsets.only(left: 15),
            children: [
              _buildActiveTradesSection(socketProvider),
              _buildTradeHistorySection(socketProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActiveTradesSection(TradeSocketProvider socketProvider) {
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
          ..._buildActiveOrdersList(socketProvider.activeOrders),
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
    ];  }

  List<Widget> _buildActiveOrdersList(List<OrderGet> orders) {
    return [
      ListView.builder(
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
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
                      stream: _timerStream(order.orderDuration! * 60, order,  context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          return Text(
                            _formatDuration(snapshot.data!),
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${order.strikePrice}',
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
          (trade.timestamp ?? trade.orderExecutedTimestamp ?? trade.orderPlacedTimestamp ?? DateTime.now().millisecondsSinceEpoch ~/ 1000) * 1000,
          );

          String formattedTime = '${tradeTime.minute} min';

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
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          '+Ð${trade.profit}',
                          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '/ -Ð${trade.loss}',
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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

