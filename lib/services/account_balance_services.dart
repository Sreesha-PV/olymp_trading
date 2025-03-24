import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olymp_trade/features/model/balance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceService {

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    print("Token saved successfully.");
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  
  Future<Balance> fetchBalance() async {
    final String? token = await getToken();
    
    if (token == null) {
      throw Exception("Token is missing or expired.");
    }

    final url = Uri.parse('http://192.168.4.30:8080/api/v1/wallets/balance');
    
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',  
        },
      );
      print("Response Status :${response.statusCode}");
    
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
          print("decoded data: ${data}");
         Balance balance = Balance.fromJson(data);
          print(balance.availableBalance); 
        return  balance;
      } else {
        throw Exception('Failed to load balance, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching balance: $e');
    }
  }
}
