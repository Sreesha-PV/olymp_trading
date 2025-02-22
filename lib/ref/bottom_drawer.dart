

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/screens/drawers/sidebar_drawer/events_drawer.dart';
// import 'package:olymp_trade/screens/drawers/sidebar_drawer/help_drawer.dart';
// import 'package:olymp_trade/screens/drawers/sidebar_drawer/trades_drawer.dart';
// import '../drawers/sidebar_drawer/market_drawer.dart';

// class SidebarSection extends StatelessWidget {
//   final Function(Widget) onItemSelected;

//   const SidebarSection({super.key, required this.onItemSelected});

//   @override
//   Widget build(BuildContext context) {
//     bool isMobile = MediaQuery.of(context).size.width < 600;

//     return isMobile ? buildBottomSidebar(context) : buildVerticalSidebar();
//   }

//   /// **Web Sidebar (Vertical)**
//   Widget buildVerticalSidebar() {
//     return Container(
//       width: 80,
//       color: const Color.fromARGB(246, 17, 17, 17),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           const SizedBox(height: 90),
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: SidebarItem(
//                 icon: CupertinoIcons.arrow_down_right_arrow_up_left,
//                 label: "Trades",
//                 onTap: () => onItemSelected(const TradesDrawer())
//                 ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: SidebarItem(
//                 icon: Icons.shopping_bag_outlined,
//                 label: "Market",
//                 onTap: () => onItemSelected(const MarketDrawer())),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: SidebarItem(
//                 icon: Icons.emoji_events_outlined,
//                 label: "Events",
//                 onTap: () => onItemSelected(const EventsDrawer())),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: SidebarItem(
//                 icon: Icons.help_outline,
//                 label: "Help",
//                 onTap: () => onItemSelected(const HelpDrawer())),
//           ),
//         ],
//       ),
//     );
//   }

//   /// **Mobile Sidebar (Bottom)**
//   Widget buildBottomSidebar(BuildContext context) {
//     return Container(
//       height: 70,
//       color: const Color.fromARGB(246, 17, 17, 17),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SidebarItem(
//               icon: CupertinoIcons.arrow_down_right_arrow_up_left,
//               label: "Trades",
//               onTap: () => openBottomDrawer(context)),
//           SidebarItem(
//               icon: Icons.shopping_bag_outlined,
//               label: "Market",
//               onTap: () => onItemSelected(const MarketDrawer())),
//           SidebarItem(
//               icon: Icons.emoji_events_outlined,
//               label: "Events",
//               onTap: () => onItemSelected(const EventsDrawer())),
//           SidebarItem(
//               icon: Icons.help_outline,
//               label: "Help",
//               onTap: () => onItemSelected(const HelpDrawer())),
//         ],
//       ),
//     );
//   }

//   /// Open the bottom drawer when the "Trades" button is tapped in mobile view
//   void openBottomDrawer(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Allow it to cover full height
//       backgroundColor: Colors.transparent, // Transparent background
//       builder: (BuildContext context) {

//         return Container(
//           color: const Color.fromARGB(255, 24, 23, 23), // Drawer background
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 14, top: 15),
//                 child: Row(
//                   children: [
//                     const Text(
//                       'Trades',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 26,
//                       ),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context); // Close the drawer
//                       },
//                       icon: const Icon(Icons.close),
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//               const Expanded(
//                 child: DefaultTabController(
//                   length: 3,
//                   child: Column(
//                     children: [
//                       TabBar(
//                         unselectedLabelColor: Colors.grey,
//                         labelColor: Colors.white,
//                         dividerColor: Colors.grey,
//                         indicatorColor: Colors.white,
//                         tabs: [
//                           Tab(text: 'Fixed Time'),
//                           Tab(text: 'Forex'),
//                           Tab(text: 'Stocks'),
//                         ],
//                       ),
//                       Expanded(
//                         child: TabBarView(
//                           children: [
//                             FixedtimePage(),
//                             ForexPage(),
//                             StocksPage(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// /// **Sidebar Items**
// class SidebarItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;

//   const SidebarItem({super.key, required this.icon, required this.label, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: const Color.fromARGB(255, 163, 185, 179), size: 24),
//           Text(
//             label,
//             style: const TextStyle(color: Color.fromARGB(255, 163, 185, 179), fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }







// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/screens/drawers/sidebar_drawer/events_drawer.dart';
// import 'package:olymp_trade/screens/drawers/sidebar_drawer/help_drawer.dart';
// import 'package:olymp_trade/screens/drawers/sidebar_drawer/trades_drawer.dart';
// import 'package:olymp_trade/screens/drawers/sidebar_drawer/market_drawer.dart';

// class SidebarSection extends StatelessWidget {
//   final Function(Widget) onItemSelected;

//   const SidebarSection({super.key, required this.onItemSelected});

//   @override
//   Widget build(BuildContext context) {
//     bool isMobile = MediaQuery.of(context).size.width < 600;

//     return isMobile ? buildBottomSidebar(context) : buildVerticalSidebar();
//   }

//   /// **Web Sidebar (Vertical)**
//   Widget buildVerticalSidebar() {
//     return Container(
//       width: 80,
//       color: const Color.fromARGB(246, 17, 17, 17),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           const SizedBox(height: 90),
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: SidebarItem(
//                 icon: CupertinoIcons.arrow_down_right_arrow_up_left,
//                 label: "Trades",
//                 onTap: () => onItemSelected(const TradesDrawer())),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: SidebarItem(
//                 icon: Icons.shopping_bag_outlined,
//                 label: "Market",
//                 onTap: () => onItemSelected(const MarketDrawer())),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: SidebarItem(
//                 icon: Icons.emoji_events_outlined,
//                 label: "Events",
//                 onTap: () => onItemSelected(const EventsDrawer())),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 40),
//             child: SidebarItem(
//                 icon: Icons.help_outline,
//                 label: "Help",
//                 onTap: () => onItemSelected(const HelpDrawer())),
//           ),
//         ],
//       ),
//     );
//   }

//   /// **Mobile Sidebar (Bottom)**
//   Widget buildBottomSidebar(BuildContext context) {
//     return Container(
//       height: 70,
//       color: const Color.fromARGB(246, 17, 17, 17),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SidebarItem(
//               icon: CupertinoIcons.arrow_down_right_arrow_up_left,
//               label: "Trades",
//               onTap: () => openBottomDrawer(context, 'Trades')),
//           SidebarItem(
//               icon: Icons.shopping_bag_outlined,
//               label: "Market",
//               onTap: () => openBottomDrawer(context, 'Market')),
//           SidebarItem(
//               icon: Icons.emoji_events_outlined,
//               label: "Events",
//               onTap: () => openBottomDrawer(context, 'Events')),
//           SidebarItem(
//               icon: Icons.help_outline,
//               label: "Help",
//               onTap: () => openBottomDrawer(context, 'Help')),
//         ],
//       ),
//     );
//   }

//   /// Open the bottom drawer for respective items
//   void openBottomDrawer(BuildContext context, String drawerType) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true, // Allow it to cover full height
//       backgroundColor: Colors.transparent, // Transparent background
//       builder: (BuildContext context) {
//         return Container(
//           color: const Color.fromARGB(255, 24, 23, 23), // Drawer background
//           child: Column(
//             children: [
//               // The content of the drawer without extra text and close icon
//               Expanded(
//                 child: getDrawerContent(drawerType),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Get respective drawer content based on the drawerType
//   Widget getDrawerContent(String drawerType) {
//     switch (drawerType) {
//       case 'Trades':
//         return const TradesDrawer();
//       case 'Market':
//         return const MarketDrawer();
//       case 'Events':
//         return const EventsDrawer();
//       case 'Help':
//         return const HelpDrawer();
//       default:
//         return Container();
//     }
//   }
// }

// /// **Sidebar Items**
// class SidebarItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;

//   const SidebarItem({super.key, required this.icon, required this.label, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: const Color.fromARGB(255, 163, 185, 179), size: 24),
//           Text(
//             label,
//             style: const TextStyle(color: Color.fromARGB(255, 163, 185, 179), fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }
