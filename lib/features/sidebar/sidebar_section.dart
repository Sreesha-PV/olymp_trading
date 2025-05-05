import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/drawers/sidebar_drawer/events_drawer.dart';
import 'package:olymp_trade/features/drawers/sidebar_drawer/help_drawer.dart';
import 'package:olymp_trade/features/drawers/sidebar_drawer/market_drawer.dart';
import 'package:olymp_trade/features/drawers/sidebar_drawer/trades_drawer.dart';

class Sidebar extends StatelessWidget {
  final Function(Widget) onItemSelected;

  const Sidebar({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return isMobile ? _buildBottomSidebar(context) : _buildVerticalSidebar();
  }

  Widget _buildVerticalSidebar() {
    final List<Map<String, dynamic>> sidebarItems = [
      {
        "icon": CupertinoIcons.arrow_down_right_arrow_up_left,
        "label": "Trades",
        "drawer": const TradesDrawer(),
      },
      {
        "icon": Icons.shopping_bag_outlined,
        "label": "Market",
        "drawer": const MarketDrawer(),
      },
      {
        "icon": Icons.emoji_events_outlined,
        "label": "Events",
        "drawer": const EventsDrawer(),
      },
      {
        "icon": Icons.help_outline,
        "label": "Help",
        "drawer": const HelpDrawer(),
      },
    ];

    return Container(
      width: 80,
      color: const Color.fromARGB(246, 17, 17, 17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 90),
          ...sidebarItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SidebarItem(
                icon: item['icon'],
                label: item['label'],
                onTap: () => onItemSelected(item['drawer']),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBottomSidebar(BuildContext context) {
    final List<Map<String, dynamic>> sidebarItems = [
      {
        "icon": CupertinoIcons.arrow_down_right_arrow_up_left,
        "label": "Trades",
        "index": 0,
      },
      {
        "icon": Icons.shopping_bag_outlined,
        "label": "Market",
        "index": 1,
      },
      {
        "icon": Icons.emoji_events_outlined,
        "label": "Events",
        "index": 2,
      },
      {
        "icon": Icons.help_outline,
        "label": "Help",
        "index": 3,
      },
    ];

    return Container(
      height: 70,
      color: const Color.fromARGB(246, 17, 17, 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: sidebarItems.map((item) {
          return SidebarItem(
            icon: item['icon'],
            label: item['label'],
            onTap: () => _openBottomDrawer(context, item['index']),
          );
        }).toList(),
      ),
    );
  }

  void _openBottomDrawer(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          color: const Color.fromARGB(255, 24, 23, 23),
          child: Column(
            children: [
              Expanded(child: _getDrawerContent(index)),
            ],
          ),
        );
      },
    );
  }

  Widget _getDrawerContent(int index) {
    switch (index) {
      case 0:
        return const TradesDrawer();
      case 1:
        return const MarketDrawer();
      case 2:
        return const EventsDrawer();
      case 3:
        return const HelpDrawer();
      default:
        return Container();
    }
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color.fromARGB(255, 163, 185, 179), size: 24),
          Text(
            label,
            style: const TextStyle(
                color: Color.fromARGB(255, 163, 185, 179), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
