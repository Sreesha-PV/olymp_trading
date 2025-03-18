import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService with ChangeNotifier {
  final String registerUrl = "http://192.168.4.30:8080/api/v1/client/account/register";
  final String loginUrl = "http://192.168.4.30:8080/api/v1/client/auth/login";
  String? userId;

  String? token;
  Future<void> storeUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);  
    print("User ID saved: $userId");  
  }



  
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    print("Retrieved User ID: $userId"); 
    return userId;
  }
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
      print('Retrieved token: $token');  

    return prefs.getString('token');
  }

  Future<void> checkToken() async {
    token = await getToken();
  }

Future<bool> register(String username, String email, String password) async {
  final url = Uri.parse(registerUrl);

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'User_name': username,
        'email': email,
        'password': password,
      }),
    );

    print('Response body: ${response.body}');
    
    if (response.statusCode == 200) {
      return true; 
    } else {
   
      if (response.body.startsWith("Email is")) {
        throw Exception('Registration failed: ${response.body}');
      }
      
      
      try {
        final errorResponse = response.body.isNotEmpty
            ? json.decode(response.body)
            : {'message': 'Unknown error occurred'};
        if (errorResponse.containsKey('errors')) {
          throw Exception('Registration failed: ${errorResponse['errors']}');
        } else {
          throw Exception('Registration failed: ${errorResponse['message']}');
        }
      } catch (e) {
    
        throw Exception('Failed to register user: ${e.toString()}');
      }
    }
  } catch (e) {
    throw Exception('Failed to register user: ${e.toString()}');
  }
}



  Future<bool> login(String email, String password) async {
    final url = Uri.parse(loginUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
    print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        token = responseBody['token'];
        await saveToken(token!); 
    
        return true; 
      } else {
        
        try {
          final errorResponse = response.body.isNotEmpty
              ? json.decode(response.body)
              : {'message': 'Unknown error occurred'};
          throw Exception('Login failed: ${errorResponse['message']}');
        } catch (e) {
          throw Exception('Failed to decode error response: $e');
        }
      }
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    final storedToken = await getToken();
    return storedToken != null && storedToken.isNotEmpty;
  }
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    token = null; 
  }
}
