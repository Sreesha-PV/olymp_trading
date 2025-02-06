import 'package:flutter/material.dart';
import 'trades_drawer/fixed_time_drawer.dart';
import 'trades_drawer/forex_drawer.dart';
import 'trades_drawer/stock_drawer.dart';

class TradesDrawer extends StatelessWidget {
  const TradesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          AppBar(
            title: const Text('Trades'),
            automaticallyImplyLeading: false,
            // leading: const Icon(Icons.close),
            leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.close)),
          ),
           const Expanded(
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
                  Expanded(
                    child: TabBarView(
                      children: [
                        FixedtimePage(),
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