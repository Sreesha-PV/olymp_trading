import 'package:flutter/material.dart';



class ProfitabilityProvider extends ChangeNotifier {
  String _selectedValue = 'any';
  
  String get selectedValue => _selectedValue;

  set selectedValue(String value) {
    _selectedValue = value;
    notifyListeners();
  }
}
