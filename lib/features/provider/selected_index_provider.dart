import 'package:flutter/material.dart';

class SelectedIndexNotifier extends ChangeNotifier {
  int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners(); 
    }
  }
}





