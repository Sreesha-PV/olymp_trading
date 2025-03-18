import 'package:flutter/material.dart';
import 'package:olymp_trade/services/auth_service_api.dart';

class AuthProvider with ChangeNotifier {
  String?registeredUsername;
  String? registeredEmail;
  String? registeredPassword;
  String? token;
  bool isLoggedIn = false;
  bool isRegistering = true;
  bool rememberMe = false;

  final TextEditingController usernameController=TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();  

  // Register method with API call
  Future<void> register(String username,String email, String password) async {
    if (username.isNotEmpty&& email.isNotEmpty && password.isNotEmpty) {
      try {
        bool result = await authService.register(username,email, password);  
        if (result) {
          registeredUsername=username;
          registeredEmail = email;
          registeredPassword = password;
          usernameController.clear();
          emailController.clear();
          passwordController.clear();
          isLoggedIn = true;
          notifyListeners();
        }
      } catch (e) {
        throw Exception("Registration failed: $e");
      }
    } else {
      throw Exception("Please enter both email and password.");
    }
  }

 
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Please enter both email and password.");
    } else {
      try {
        bool result = await authService.login(email, password);  
        if (result) {
          isLoggedIn = true;
          notifyListeners();
        }
      } catch (e) {
        throw Exception("Invalid credentials. Please register first.");
      }
    }
  }

 
  void toggleRememberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }

    void toggleAuthMode() {
    isRegistering = !isRegistering;
    notifyListeners();
  }
}



