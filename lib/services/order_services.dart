import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olymp_trade/features/model/order_creation_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRequestService {
  
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
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);  
  }

  Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');  
  print('Retrieved token: $token');  
  return token ?? '';  
  }


Future<String?> createOrder(OrderCreationRequest request) async {
  final url = Uri.parse('http://192.168.4.30:8080/api/v1/orders');  
  var authToken = await getToken();

  if (authToken.isEmpty) {
    print("Error: No token available");
    return 'Error: No token available';
  }

  try {
  
    final payload = {
      'request': request.toJson(),
  
    };

    print('Sending request: ${json.encode(payload)}');  

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $authToken"
      },
      body: json.encode(payload),  
    );

   
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print("Order placed successfully");
      return null; 
    } else {
      print("Failed to place order. Status code: ${response.statusCode}, Body: ${response.body}");
      return 'Error: ${response.statusCode} - ${response.body}';
    }
  } catch (e) {
    print('Error: $e');
    return 'Error: $e';  
  }
}

}