



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/screens/chart/candle_stick_chart.dart';
import 'package:olymp_trade/screens/drawers/account_drawer.dart';
import 'package:olymp_trade/screens/drawers/payment_drawer.dart';
import 'package:olymp_trade/screens/provider/selected_account_notifier.dart';
import 'package:olymp_trade/screens/sidebar/bottom_side.dart';
import 'package:provider/provider.dart';
import 'provider/drawer_provider.dart';
import 'provider/selected_index_provider.dart';
import 'sidebar/rsidebar_section.dart';
import 'sidebar/sidebar_section.dart';

class TradeScreen extends StatelessWidget {
  final String balance;
  final String accountType;

  TradeScreen({
    super.key,
    this.balance = "AED 0.00",
    this.accountType = "AED Account",
  });

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      drawer: Consumer<DrawerProvider>(
        builder: (context, drawerProvider, child) {
          return drawerProvider.selectedDrawer;
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600; 
          return Column(
            children: [
              Expanded(
                child: isMobile
                    ? Column(
                        children: [
                          const TopSection(),
                          Expanded(child: LiveCandlestickChart()),
                          // Expanded(child: CandlestickChart()),
                          // Right Sidebar at Bottom (Mobile)
                          // RSidebarSection(),
                          const TradeBottomSection()
                        ],
                      )
                    : Row(
                        children: [
                          SidebarSection(
                            onItemSelected: (drawerContent) {
                              Provider.of<DrawerProvider>(context, listen: false)
                                  .updateDrawerContent(drawerContent);
                              scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const TopSection(),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(child: LiveCandlestickChart()),    
                                      // Expanded(child: CandlestickChart()),                                
                                      const RSidebarSection(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),

              // Sidebar at Bottom for Mobile
              if (isMobile)
                SidebarSection(
                  onItemSelected: (drawerContent) {
                    Provider.of<DrawerProvider>(context, listen: false)
                        .updateDrawerContent(drawerContent);
                    scaffoldKey.currentState?.openDrawer();
                  },
                ),
            ],
          );
        },
      ),
      endDrawer: Consumer<SelectedIndexNotifier>(
        builder: (context, selectedIndexNotifier, child) {
          return selectedIndexNotifier.selectedIndex == 0
              ? AccountDrawer(
                  selectedIndex: selectedIndexNotifier.selectedIndex,
                  onSelect: (index) {
                    selectedIndexNotifier.updateSelectedIndex(index);
                  },
                )
              : PaymentDrawer(
                  selectedIndex: selectedIndexNotifier.selectedIndex,
                  onSelect: (index) {
                    selectedIndexNotifier.updateSelectedIndex(index);
                  },
                );
        },
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600; // Mobile condition

        return Padding(
          padding: isMobile ? const EdgeInsets.all(8.0) : const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top row for both Mobile and Web
              Row(
                mainAxisAlignment:
                    isMobile ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceBetween,
                children: [
                  // **Left Section (Mobile: Profile, Web: FAB + Halal Market Axis)**
                  if (!isMobile)
                    Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.grey[900],
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Halal Market Axis",
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  else
                    // Mobile: Profile Icon on Left
                    CircleAvatar(
                      backgroundColor: Colors.grey[850],
                      foregroundColor: Colors.white,
                      radius: 25,
                      child: const Icon(CupertinoIcons.person),
                    ),

                  // **Center Section (Mobile: AED Account, Web: Empty)**
                  if (isMobile)
                    GestureDetector(
                      onTap: () {
                        Provider.of<SelectedIndexNotifier>(context, listen: false)
                            .updateSelectedIndex(0);
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<SelectedAccountNotifier>(
                                  builder: (context, accountNotifier, child) {
                                    return Text(
                                      accountNotifier.selectedAccount,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 163, 185, 179),
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                          ],
                        ),
                      ),
                    ),

                  // **Right Section (Mobile: Wallet Icon, Web: AED + Wallet + Profile)**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align to right for Web
                    children: [
                      // AED Account 
                      if (!isMobile)
                        GestureDetector(
                          onTap: () {
                            Provider.of<SelectedIndexNotifier>(context, listen: false)
                                .updateSelectedIndex(0);
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Consumer<SelectedAccountNotifier>(
                                      builder: (context, accountNotifier, child) {
                                        return Text(
                                          accountNotifier.selectedAccount,
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 163, 185, 179),
                                            fontSize: 12,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),

                      // Wallet Icon (Payments)
                      GestureDetector(
                        onTap: () {
                          Provider.of<SelectedIndexNotifier>(context, listen: false)
                              .updateSelectedIndex(1);
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Container(
                          width: isMobile ? 50 : 100, // Smaller width for mobile
                          height: 50,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 76, 238, 238),
                              Color.fromARGB(255, 74, 231, 43)
                            ]),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: isMobile
                              ? const Icon(
                                  Icons.wallet,
                                  color: Colors.black,
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Payments",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Profile Icon (Only for Web, at the Right End)
                      if (!isMobile)
                        CircleAvatar(
                          backgroundColor: Colors.grey[850],
                          foregroundColor: Colors.white,
                          radius: 25,
                          child: const Icon(CupertinoIcons.person),
                        ),
                    ],
                  ),
                ],
              ),

              // **Mobile Only: Halal Market Axis & FT - 85%**
              if (isMobile)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Halal Market Axis",
                          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "FT - 85%",
                          style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}








