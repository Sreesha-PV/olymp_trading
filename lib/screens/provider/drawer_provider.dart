import 'package:flutter/material.dart';

import '../drawers/sidebar_drawer/trades_drawer.dart';


class DrawerProvider extends ChangeNotifier {
  Widget _selectedDrawer = const TradesDrawer();

  Widget get selectedDrawer => _selectedDrawer;

  void updateDrawerContent(Widget newDrawer) {
    _selectedDrawer = newDrawer;
    notifyListeners();
  }
}






