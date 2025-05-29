import 'package:flutter/material.dart';

class TabVisibilityProvider with ChangeNotifier {
  bool _isTabBarVisible = false;
  bool _isPricePage = false;
  bool _isTimePage = false;

  bool get isTabBarVisible => _isTabBarVisible;
  bool get isPricePage => _isPricePage;
  bool get isTimePage => _isTimePage;

  void toggleTabBarVisibility() {
    _isTabBarVisible = !_isTabBarVisible;
    notifyListeners();
  }

  void togglePage(){
    _isPricePage = isPricePage;
    notifyListeners();
  }
  
}
