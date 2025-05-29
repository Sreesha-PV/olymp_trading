import 'package:flutter/material.dart';
import '../../services/account_details_services.dart';

class UserProvider extends ChangeNotifier {
  String _email = '';
  String _name = '';
  String _userId = '';
  String _uuid = '';
  bool _isLoading = true;

  String get email => _email;
  String get name => _name;
  String get userId => _userId;
  String get uuid => _uuid;
  bool get isLoading => _isLoading;

  final AccountDetailsServices _accountDetailsServices;

  UserProvider(this._accountDetailsServices) {
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final data = await _accountDetailsServices.getUserData();
      if (data != null) {
        _email = data.email ?? '';
        _name = data.name ?? '';
        _userId = data.userId.toString();
        _uuid = data.userUuid ?? '';
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('Error fetching user data: $e');
    }
  } 

  void clearUser(){
    _email = '';
    _name = '';
    _userId = '';
    _uuid = '';
    _isLoading = false;
  } 
}  
