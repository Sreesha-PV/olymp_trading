import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:olymp_trade/features/model/order_creation_request.dart';
import 'package:olymp_trade/features/model/order_get_model.dart';
import 'package:olymp_trade/features/provider/active_order_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRequestService {
  
 
Future<Map<String, dynamic>> getUserIdentifiers() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  int userIdInt = prefs.getInt('user_id') ?? 0;
  String userId = prefs.getString('user_uuid') ?? '';
  
  print("User ID (int): $userIdInt");
  print("User ID (string): $userId");

  return {
    'user_id_int': userIdInt,
    'user_id': userId
  };
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

Future<String?> createOrder(OrderCreationRequest request,BuildContext context) async {
  final url = Uri.parse('http://192.168.4.30:8080/api/v1/orders');
  var authToken = await getToken();

  if (authToken.isEmpty) {
    print("Error: No token available");
    return 'Error: No token available';
  }


  var userIdentifiers = await getUserIdentifiers();


  String? userId = userIdentifiers['user_id'];
  if (userId != null && !isValidGuid(userId)) {
    print('Error: user_id is not a valid GUID.');
    return 'Error: user_id is not a valid GUID.';
  }

 
  final payload = {
   
      'user_id_int': userIdentifiers['user_id_int'],
      'user_id': userId,  
      'symbol': request.symbol?.toLowerCase(),
      'order_type': request.orderType,
      'amount': request.amount,
      'strike_price': request.strikePrice,
      'order_duration': request.orderDuration,
    
  };

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $authToken",
      },
      body: json.encode(payload),
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // final activeOrderProvider = Provider.of<ActiveOrderProvider>(context, listen: false);
      // activeOrderProvider.addOrder(request); 
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

bool isValidGuid(String guid) {
  RegExp guidRegex = RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
  return guidRegex.hasMatch(guid);
}

}

// void main () {
//   var order_service = OrderRequestService();
  
//   var order_request = OrderCreationRequest.fromJson({
//   "user_id_int": 1001,
//   "user_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//   "symbol": "btcusdt",
//   "order_type": 0,
//   "amount": 10,
//   "strike_price": 120,
//   "order_duration": 1
// });

//   order_service.createOrder(order_request,);
// }





