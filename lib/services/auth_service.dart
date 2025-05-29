import 'package:flutter/material.dart';
import 'package:olymp_trade/core/constants/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService with ChangeNotifier {

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
    final storedToken = prefs.getString('token');
    print('Retrieved token: $storedToken');
    return storedToken;
  }

  Future<void> checkToken() async {
    token = await getToken();
  }

  Future<bool> register(String username, String email, String password) async {
    final url = Uri.parse(ApiUrl.register);

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

      print('Register response status: ${response.statusCode}');
      print('Register response body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        final responseBody = json.decode(response.body);
        final error = responseBody['errors'] ?? responseBody['message'] ?? 'Unknown error';
        throw Exception('Registration failed: $error');
      }
    } catch (e) {
      throw Exception('Failed to register user: ${e.toString()}');
    }
  }

  Future<bool> login(String email, String password) async {
  final url = Uri.parse(ApiUrl.loginUrl);

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    print('Login response status: ${response.statusCode}');
    print('Login response body: ${response.body}');

    final responseBody = json.decode(response.body);

    if (response.statusCode == 200 && responseBody.containsKey('token')) {
      token = responseBody['token'];
      await saveToken(token!);
      print('Token saved successfully');
      return true;
    } else {
     
      String errorMessage = "Login failed";
      if (responseBody is Map &&
          responseBody['data'] != null &&
          responseBody['data']['errors'] != null &&
          responseBody['data']['errors']['message'] != null) {
        errorMessage = responseBody['data']['errors']['message'];
      } else if (responseBody['message'] != null) {
        errorMessage = responseBody['message'];
      }
      throw Exception(errorMessage);
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
    await prefs.remove('user_id');
    token = null;
    userId = null;
  }
}
