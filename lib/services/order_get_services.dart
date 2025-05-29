import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:olymp_trade/core/constants/urls.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';

class OrderGetServices {
  static const _tokenKey = 'token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    print("Token saved successfully.");
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    if (token != null) {
      print('Token retrieved successfully');
      return token;
    } else {
      print('No token found.');
      return '';
    }
  }

  Future<List<OrderGet>> getOrdersByStatus(int status) async {
    final url = Uri.parse(ApiUrl.ordersByStatus(status));
    final authToken = await getToken();

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': "Bearer $authToken"},
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => OrderGet.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }
}