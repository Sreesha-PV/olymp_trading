import 'package:flutter/material.dart';

class TabVisibilityProvider with ChangeNotifier {
  bool _isTabBarVisible = false;

  bool get isTabBarVisible => _isTabBarVisible;

  void toggleTabBarVisibility() {
    _isTabBarVisible = !_isTabBarVisible;
    notifyListeners();
  }
}
