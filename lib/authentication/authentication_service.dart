// import 'package:flutter/material.dart';

// class AuthService extends ChangeNotifier {
//   // In-memory user storage (for demo purposes)
//   final Map<String, String> _users = {};

  
//   void register(String username, String password) {
//     if (_users.containsKey(username)) {
//       // User already exists
//       throw Exception("User already exists!");
//     }
//     _users[username] = password;
//     notifyListeners();
//   }

  
//   bool login(String username, String password) {
    
//     if (_users.containsKey(username) && _users[username] == password) {
//       return true;  
//     }
//     return false;  
//   }

//   bool userExists(String username) {
//     return _users.containsKey(username);
//   }
// }
