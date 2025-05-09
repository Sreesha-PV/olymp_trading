
import 'package:flutter/material.dart';

class TradeBadgeProvider with ChangeNotifier {
  bool _hasNewTrade = false;

  bool get hasNewTrade => _hasNewTrade;

  void showBadge() {
    _hasNewTrade = true;
    notifyListeners();
  }

  void clearBadge() {
    _hasNewTrade = false;
    notifyListeners();
  }
}




