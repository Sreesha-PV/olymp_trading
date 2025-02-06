import 'package:flutter/material.dart';

import '../drawers/sidebar_drawer/events_drawer.dart';
import '../drawers/sidebar_drawer/help_drawer.dart';


import '../drawers/sidebar_drawer/market_drawer.dart';
// import '../drawers/sidebar_drawer/market_drawer/drawer_screen.dart';
import '../drawers/sidebar_drawer/trades_drawer.dart';



class SidebarSection extends StatelessWidget {
  final Function(Widget) onItemSelected;

  const SidebarSection({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SidebarItem(icon: Icons.show_chart, label: "Trades", onTap: () => onItemSelected(const TradesDrawer())),
          SidebarItem(icon: Icons.shopping_bag_outlined, label: "Market", onTap: () => onItemSelected(const MarketDrawer())),
          SidebarItem(icon: Icons.emoji_events_outlined, label: "Events", onTap: () => onItemSelected(const EventsDrawer())),
          SidebarItem(icon: Icons.help_outline, label: "Help", onTap: () => onItemSelected(const HelpDrawer())),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const SidebarItem({super.key, required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, color: Colors.grey[350], size: 26),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: Colors.grey[350], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

