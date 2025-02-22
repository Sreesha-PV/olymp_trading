import 'package:flutter/material.dart';
import 'package:olymp_trade/screens/showDialog/up/tabbar_pages/time_page.dart';
import 'package:provider/provider.dart';
import 'provider/tabbar_provider.dart';
import 'showDialog/up/tabbar_pages/price_page.dart';

class EnableOrder extends StatelessWidget {
  const EnableOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabVisibilityProvider>(
      builder: (context, tabVisibilityProvider, child) {
        if (tabVisibilityProvider.isTabBarVisible) {
          return Container(
            height: 400,
            width: 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(246, 17, 17, 17),
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft, 
                      child: Text(
                        'Order Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    dividerColor: Colors.grey[600],
                    indicatorColor: Colors.white,
                    tabs: const [
                      Tab(text: "By Price"),
                      Tab(text: "By Time"),
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        ByPricePage(),
                        ByTimePage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
