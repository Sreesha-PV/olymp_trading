import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderGetServices {

  
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print("Token saved successfully.");
  }

  
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      print('Retrieved token: $token');
      return token;
    } else {
      print('No token found.');
      return ''; 
    }
  }

  Future<List<OrderGet>> getOrdersByStatus(int status) async {
    final url = Uri.parse('http://192.168.4.30:8080/api/v1/orders?status=$status');
     var authToken = await getToken();

    try {
      final response = await http.get(
        url,
         headers: {
        'Authorization': "Bearer $authToken",
      },
      
        );

        print('Response Status: ${response.statusCode}');  
        print('Response Body: ${response.body}'); 

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((order) => OrderGet.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }
}




