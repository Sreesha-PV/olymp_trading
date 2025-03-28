import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/provider/active_order_provider.dart';
import 'package:olymp_trade/features/provider/trade_history_provider.dart';
import 'package:provider/provider.dart';

class FixedTimePage extends StatelessWidget {
  const FixedTimePage({super.key});

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final activeOrderProvider =
        Provider.of<ActiveOrderProvider>(context, listen: false);
    final tradeHistoryProvider =
        Provider.of<TradeHistoryProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      activeOrderProvider.fetchOrders();
    });

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),
      child: Consumer2<ActiveOrderProvider, TradeHistoryProvider>(
        builder: (context, activeOrderProvider, tradeHistoryProvider, child) {
          return ListView(
            padding: const EdgeInsets.only(left: 15),
            children: [
              const Row(
                children: [
                  Padding(
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
                ],
              ),
              const SizedBox(height: 20),
              if (activeOrderProvider.orders.isEmpty) ...[
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have no open Fixed Time trades on',
                      style: TextStyle(
                          color: Color.fromARGB(255, 230, 245, 247),
                          fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'this account',
                      style: TextStyle(
                          color: Color.fromARGB(255, 230, 245, 247),
                          fontSize: 15),
                    ),
                  ],
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
              ] else ...[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: activeOrderProvider.orders.length,
                  itemBuilder: (context, index) {
                    final order = activeOrderProvider.orders[index];

                    Stream<int> _timerStream(int startDuration) {
                      return Stream.periodic(const Duration(seconds: 1),
                          (tick) {
                        int remainingTime = startDuration - tick - 1;
                        if (remainingTime <= 0) {
                          _moveOrderToHistory(
                              order, activeOrderProvider, tradeHistoryProvider);
                        }
                        return remainingTime < 0 ? 0 : remainingTime;
                      });
                    }

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
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(width: 10),
                              StreamBuilder<int>(
                                stream: _timerStream(order.orderDuration! * 60),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasData) {
                                    return Text(
                                      _formatDuration(snapshot.data!),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    );
                                  } else {
                                    return const Text(
                                      '00:00',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  Text(
                                    '${order.strikePrice}',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
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
              ],
              const SizedBox(height: 20),
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
               const SizedBox(width: 20),
             
              const SizedBox(height: 20),
              if (tradeHistoryProvider.isLoading) ...[
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ] else if (tradeHistoryProvider.tradeHistory.isEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'No trade history available.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              ] else ...[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tradeHistoryProvider.tradeHistory.length,
                  itemBuilder: (context, index) {
                    final trade = tradeHistoryProvider.tradeHistory[index];

                    DateTime tradeTime = DateTime.fromMillisecondsSinceEpoch(
                        trade.timestamp! * 1000);
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
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                formattedTime,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ð ${trade.amount}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  Text(
                                    'Ð${trade.loss}',
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
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
              ],
            ],
          );
        },
      ),
    );
  }

  void _moveOrderToHistory(
      OrderGet order,
      ActiveOrderProvider activeOrderProvider,
      TradeHistoryProvider tradeHistoryProvider) {
    tradeHistoryProvider.addTrade(order);
    activeOrderProvider.removeOrder(order.idInt!);
  }
}












// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/features/model/transaction_model.dart';
// import 'package:olymp_trade/features/provider/active_order_provider.dart';
// import 'package:olymp_trade/features/provider/selected_account_provider.dart';
// import 'package:provider/provider.dart';
// import '../../../provider/transaction_history_provider.dart';

// class FixedTimePage extends StatelessWidget {
//   const FixedTimePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final selectedAccountNotifier = Provider.of<SelectedAccountNotifier>(context);

//     return Drawer(
//       backgroundColor: const Color.fromARGB(255, 24, 23, 23),
//       child: Consumer<ActiveOrderProvider>(
//         builder: (context, activeOrderProvider, child) {
//           return ListView(
//             padding: const EdgeInsets.only(left: 15),
//             children: [
//               const Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       'Active Trades',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               if (activeOrderProvider.orders.isEmpty) ...[
//                 const SizedBox(height: 30),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Icon(
//                         CupertinoIcons.arrow_down_right_arrow_up_left,
//                         size: 80,
//                         color: Colors.grey[800],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'You have no open Fixed Time trades on',
//                       style: TextStyle(color: Color.fromARGB(255, 230, 245, 247), fontSize: 15),
//                     ),
//                   ],
//                 ),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'this account',
//                       style: TextStyle(color: Color.fromARGB(255, 230, 245, 247), fontSize: 15),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 50,
//                         width: 250,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: Colors.grey[800],
//                         ),
//                         child: TextButton(
//                           onPressed: () {},
//                           child: const Text(
//                             'Explore Assets',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ] else ...[
//                 // Display active orders
//                 for (var order in activeOrderProvider.orders) ...[
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 50,
//                           width: 250,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: Colors.grey[800],
//                           ),
//                           child: TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               'Active Order: ${order.direction} - ${order.amount} AED for ${order.time}',
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]
//               ],
//               if (selectedAccountNotifier.selectedAccount == 'Demo Account') ...[
//                 _buildTransactionHistory(),
//               ]
//             ],
//           );
//         },
//       ),
//     );
//   }
// Widget _buildTransactionHistory() {
//   return Consumer<TransactionHistoryProvider>(
//     builder: (context, transactionProvider, child) {
//       return FutureBuilder<List<Transaction>>(
//         future: transactionProvider.fetchTransactions(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 snapshot.error.toString(),
//                 style: const TextStyle(color: Colors.red, fontSize: 16),
//               ),
//             );
//           }

//           if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//             var transactions = snapshot.data!;
//             return ListView.builder(
//               itemCount: transactions.length,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 final transaction = transactions[index];
//                 return Card(
//                   color: Colors.grey[850],
//                   child: ListTile(
//                     title: Text(transaction.title),
//                     subtitle: Row(
//                       children: [
//                         Text(
//                           transaction.amount,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Icon(
//                           transaction.directionIcon,
//                           color: transaction.directionColor,
//                           size: 20,
//                         ),
//                       ],
//                     ),
//                     trailing: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(transaction.time),
//                         const SizedBox(height: 5),
//                         Text(
//                           transaction.statusAmount,
//                           style: TextStyle(
//                             color: transaction.statusColor,
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(
//               child: Text('No transaction history available.'),
//             );
//           }
//         },
//       );
//     },
//   );
// }
// }














import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/providers/active_order_provider.dart';
import 'package:olymp_trade/features/providers/trade_history_provider.dart';
import 'package:provider/provider.dart';

class FixedTimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fixed Time Trades")),
      body: Column(
        children: [
          Expanded(child: _buildActiveTrades(context)),
          Divider(),
          Expanded(child: _buildTradeHistory(context)),
        ],
      ),
    );
  }

  Widget _buildActiveTrades(BuildContext context) {
    return Consumer<ActiveOrderProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (provider.orders.isEmpty) {
          return Center(child: Text("No active trades."));
        }

        return ListView.builder(
          itemCount: provider.orders.length,
          itemBuilder: (context, index) {
            final order = provider.orders[index];
            return ListTile(
              title: Text(order.symbol),
              subtitle: Text("Amount: ${order.amount} | Duration: ${order.duration} min"),
              trailing: _buildTimer(order, provider, context),
            );
          },
        );
      },
    );
  }

  Widget _buildTimer(OrderGet order, ActiveOrderProvider provider, BuildContext context) {
    return StreamBuilder<int>(
      stream: _countdownStream(order.duration),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int remainingTime = snapshot.data!;
          if (remainingTime <= 0) {
            // Move order to history when time expires
            Future.microtask(() => provider.transferToHistory(context, order));
            return Text("Moving to history...");
          }
          return Text("Time left: ${remainingTime}s", style: TextStyle(color: Colors.red));
        }
        return Text("Loading...");
      },
    );
  }

  Stream<int> _countdownStream(int durationInMinutes) async* {
    int durationInSeconds = durationInMinutes * 60;
    for (int i = durationInSeconds; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  Widget _buildTradeHistory(BuildContext context) {
    return Consumer<TradeHistoryProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (provider.tradeHistory.isEmpty) {
          return Center(child: Text("No trade history."));
        }

        return ListView.builder(
          itemCount: provider.tradeHistory.length,
          itemBuilder: (context, index) {
            final trade = provider.tradeHistory[index];
            return ListTile(
              title: Text(trade.symbol),
              subtitle: Text("Amount: ${trade.amount} | Time: ${DateTime.fromMillisecondsSinceEpoch(trade.timestamp)}"),
            );
          },
        );
      },
    );
  }
}

