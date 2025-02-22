import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olymp_trade/model/order_model.dart';

Future<List<TradingOrder>> fetchTradingDataFromAPI() async {
  try {
    final response = await http.get(Uri.parse('https://run.mocky.io/v3/cc813103-f35b-4403-803b-ac5aa96e08ef'));

    if (response.statusCode == 200) {
 
      List<dynamic> data = json.decode(response.body);
   
      return data.map((item) => TradingOrder.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load candlestick data: ${response.statusCode}');
    }
  } catch (e) {
    
    throw Exception('Error occurred while fetching data: $e');
  }
}
