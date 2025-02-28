



import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? registeredEmail;
  String? registeredPassword;
  bool isLoggedIn = false;
  bool rememberMe = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   final formKey = GlobalKey<FormState>();

  // Register method
  void register(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      registeredEmail = email;
      registeredPassword = password;
      emailController.clear();
      passwordController.clear();
      isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception("Please enter both email and password.");
    }
  }

 
  void login(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Please enter both email and password.");
    } else if (registeredEmail == email && registeredPassword == password) {
      isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception("Invalid credentials. Please register first.");
    }
  }

  
  void toggleRememberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }
}
