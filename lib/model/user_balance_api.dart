import 'dart:convert';
import 'package:http/http.dart' as http;

class BalanceService {
  static Future<Map<String, String>> fetchBalances() async {
    try {
      final response = await http.get(Uri.parse('https://run.mocky.io/v3/d84d017a-843d-4ad8-8bd6-c7f5471d4407')); 

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return {
          "Demo Account": data["demo"] ?? "Ð10,000.00",
          "AED Account": data["aed"] ?? "AED 0.00",
          "USDT Account": data["usdt"] ?? "USDT 0.00",
        };
      } else {
      return {};
        // print('Failed to load balance');
      }
    } catch (e) {
      return {
        "Demo Account": "Ð10,000.00",
        "AED Account": "AED 0.00",
        "USDT Account": "USDT 0.00",
      };
    }
  }
}

