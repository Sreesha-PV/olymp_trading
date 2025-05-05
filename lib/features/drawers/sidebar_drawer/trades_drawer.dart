import 'package:flutter/material.dart';
import 'trades_drawer/fixed_time_page.dart';
import 'trades_drawer/forex_page.dart';
import 'trades_drawer/stock_page.dart';

class TradesDrawer extends StatelessWidget {
  const TradesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 24, 23, 23),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 15),
            child: Row(
              children: [
                const Text(
                  'Trades',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                const SizedBox(width: 150),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                )
              ],
            ),
          ),
          const Flexible(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.white,
                    dividerColor: Colors.grey,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(text: 'Fixed Time'),
                      Tab(text: 'Forex'),
                      Tab(text: 'Stocks'),
                    ],
                  ),
                  Flexible(
                    child: TabBarView(
                      children: [
                        FixedTimePage(),
                        ForexPage(),
                        StocksPage(),
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
