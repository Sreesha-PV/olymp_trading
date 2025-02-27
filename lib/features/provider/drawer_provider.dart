import 'package:flutter/material.dart';
import 'package:olymp_trade/features/drawer/sidebar_drawr/trades_drawer.dart';



class DrawerProvider extends ChangeNotifier {
  Widget _selectedDrawer = const TradesDrawer();

  Widget get selectedDrawer => _selectedDrawer;

  void updateDrawerContent(Widget newDrawer) {
    _selectedDrawer = newDrawer;
    notifyListeners();
  }
}






