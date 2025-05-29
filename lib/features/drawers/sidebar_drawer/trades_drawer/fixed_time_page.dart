
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:olymp_trade/features/provider/tradesocket_provider.dart';
import 'package:provider/provider.dart';

class FixedTimePage extends StatelessWidget {
   FixedTimePage({super.key});

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Stream<int> _timerStream(int duration, OrderGet order) {
    return Stream.periodic(const Duration(seconds: 1), (tick) {
      final remaining = duration - tick - 1;
      return remaining < 0 ? 0 : remaining;
    });
  }

//   Stream<int> _timerStream(OrderGet order) {
//   int remainingSeconds = order.getRemainingTime().inSeconds;

//   return Stream.periodic(const Duration(seconds: 1), (tick) {
//     int updatedRemaining = remainingSeconds - tick;
//     return updatedRemaining < 0 ? 0 : updatedRemaining;
//   });
// }


// Stream<int> _timerStream(DateTime expiryTime) {
//   return Stream.periodic(const Duration(seconds: 1), (_) {
//     final now = DateTime.now();
//     final remaining = expiryTime.difference(now).inSeconds;
//     return remaining > 0 ? remaining : 0;
//   }).takeWhile((remaining) => remaining >= 0);
// }

  void _showTradeExpiredDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Trade Expired'),
        content: const Text('The trade has expired and moved to history.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.bgColor,
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
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (socketProvider.activeOrders.isEmpty)
          ..._buildNoActiveTradesSection()
        else
          _buildActiveOrdersList(socketProvider),
        // socketProvider.activeOrders.isEmpty
        //     ? ..._buildNoActiveTradesSection()
        //     : _buildActiveOrdersList(socketProvider),
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
            Icon(CupertinoIcons.arrow_up,
                size: 80, color: AppColors.borderColor),
            Icon(CupertinoIcons.arrow_down,
                size: 80, color: AppColors.borderColor),
          ],
        ),
      ),
      const SizedBox(height: 20),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'You have no open Fixed Time trades on this account',
          style: TextStyle(color: AppColors.textColor, fontSize: 15),
        ),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.borderColor,
          ),
          child: TextButton(
            onPressed: () {},
            child: const Text('Explore Assets',
                style: TextStyle(color: AppColors.textColor)),
          ),
        ),
      ),
    ];
  }

  Widget _buildActiveOrdersList(TradeSocketProvider socketProvider) {
    final orders =
        socketProvider.activeOrders.where((o) => o.id.isNotEmpty).toList();
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final createdAt = DateTime.fromMillisecondsSinceEpoch(order.createdAt * 1000); // ensure in milliseconds
        final expiryTime = createdAt.add(Duration(minutes: order.orderDuration!));
       

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.symbol,
                      style:
                          TextStyle(color: AppColors.labelColor, fontSize: 14)),
                  StreamBuilder<int>(
                    stream: _timerStream(order.orderDuration! * 60, order),
                    // stream: _timerStream(order),
                    // stream: getTimerStream(order),

                    builder: (_, snapshot) {
                      final time = snapshot.hasData
                          ? _formatDuration(snapshot.data!)
                          : '00:00';
                      return Text(time,
                          style: TextStyle(
                              color: AppColors.labelColor, fontSize: 14));
                    },
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ð ${order.amount}',
                      style: const TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold)),
                  Text('${order.strikePrice}',
                      style: const TextStyle(
                          color: AppColors.error, fontWeight: FontWeight.bold)),
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
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        if (socketProvider.tradeHistory.isEmpty)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'No trade history available.',
              style: TextStyle(color: AppColors.labelColor, fontSize: 16),
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
        physics: const NeverScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (_, index) {
          final trade = history[index];
          final tradeTime = DateTime.fromMillisecondsSinceEpoch(
            ((trade.timestamp ??
                    trade.orderExecutedTimestamp ??
                    trade.orderPlacedTimestamp ??
                    DateTime.now().millisecondsSinceEpoch ~/ 1000) *
                1000),
          );
          
          final timeStr = '${tradeTime.minute} min';

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${trade.symbol}',
                        style: TextStyle(
                            color: AppColors.labelColor, fontSize: 14)),
                    Text(timeStr,
                        style: TextStyle(
                            color: AppColors.labelColor, fontSize: 14)),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ð ${trade.amount}', style: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text('+Ð${trade.profit ?? 0}', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
                        Text(' / -Ð${trade.loss ?? 0}', style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
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