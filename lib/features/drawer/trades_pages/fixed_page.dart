
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/transaction_model.dart';
import 'package:olymp_trade/features/provider/active_order_provider.dart';
import 'package:olymp_trade/features/provider/selected_account_provider.dart';
import 'package:provider/provider.dart';
import '../../../provider/transaction_history_provider.dart';

class FixedTimePage extends StatelessWidget {
  const FixedTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAccountNotifier = Provider.of<SelectedAccountNotifier>(context);

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),
      child: Consumer<ActiveOrderProvider>(
        builder: (context, activeOrderProvider, child) {
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
                      Icon(
                        CupertinoIcons.arrow_down_right_arrow_up_left,
                        size: 80,
                        color: Colors.grey[800],
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
                      style: TextStyle(color: Color.fromARGB(255, 230, 245, 247), fontSize: 15),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'this account',
                      style: TextStyle(color: Color.fromARGB(255, 230, 245, 247), fontSize: 15),
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
                // Display active orders
                for (var order in activeOrderProvider.orders) ...[
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
                            child: Text(
                              'Active Order: ${order.direction} - ${order.amount} AED for ${order.time}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
              if (selectedAccountNotifier.selectedAccount == 'Demo Account') ...[
                _buildTransactionHistory(),
              ]
            ],
          );
        },
      ),
    );
  }
Widget _buildTransactionHistory() {
  return Consumer<TransactionHistoryProvider>(
    builder: (context, transactionProvider, child) {
      return FutureBuilder<List<Transaction>>(
        future: transactionProvider.fetchTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var transactions = snapshot.data!;
            return ListView.builder(
              itemCount: transactions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  color: Colors.grey[850],
                  child: ListTile(
                    title: Text(transaction.title),
                    subtitle: Row(
                      children: [
                        Text(
                          transaction.amount,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          transaction.directionIcon,
                          color: transaction.directionColor,
                          size: 20,
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(transaction.time),
                        const SizedBox(height: 5),
                        Text(
                          transaction.statusAmount,
                          style: TextStyle(
                            color: transaction.statusColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No transaction history available.'),
            );
          }
        },
      );
    },
  );
}
}
