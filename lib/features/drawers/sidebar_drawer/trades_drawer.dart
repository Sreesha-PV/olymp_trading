import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/app_colors.dart';
import 'trades_drawer/fixed_time_page.dart';
import 'trades_drawer/forex_page.dart';
import 'trades_drawer/stock_page.dart';

class TradesDrawer extends StatelessWidget {
  const TradesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.bgColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 15),
            child: Row(
              children: [
                const Text(
                  'Trades',
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                const SizedBox(width: 150),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: AppColors.textColor,
                )
              ],
            ),
          ),
          Flexible(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    unselectedLabelColor: AppColors.labelColor,
                    labelColor: AppColors.textColor,
                    dividerColor: AppColors.labelColor,
                    indicatorColor: AppColors.textColor,
                    tabs: const [
                      Tab(text: 'Fixed Time'),
                      Tab(text: 'Forex'),
                      Tab(text: 'Stocks'),
                    ],
                  ),
                  Flexible(
                    child: TabBarView(
                      children: [
                        FixedTimePage(),
                        const ForexPage(),
                        const StocksPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
