// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:olymp_trade/features/model/trade_history_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TradeHistoryServices {
    
//   Future<void> saveToken(String token) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('token', token);
//     print("Token saved successfully.");
//   }

  
//   Future<String> getToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     if (token != null) {
//       print('Retrieved token: $token');
//       return token;
//     } else {
//       print('No token found.');
//       return ''; 
//     }
//   }


//   Future<List<TradeHistory>>getTradeHistory()async{
//     final url = Uri.parse('http://192.168.4.30:8080/api/v1/trades');
//     var authToken = await getToken();  

//     try {
//       final response = await http.get(
//         url,
//         headers: {
//         'Authorization': "Bearer $authToken",
//       },
//   );

//         print('Response Status: ${response.statusCode}');  
//         print('Response Body: ${response.body}'); 

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         return jsonData.map((order) => TradeHistory.fromJson(order)).toList();
//       } else {
//         throw Exception('Failed to load histories');
//       }
//     } catch (e) {
//       throw Exception('Error fetching history: $e');
//     }
//   }

  
// }



import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class TradeHistoryServices {

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


   
  Future<List<TradeHistory>> fetchTrades() async {

    final url=Uri.parse('http://192.168.4.30:8080/api/v1/trades');
    var authToken=await getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':"Bearer $authToken"
        }
      );

      print("Response Status :${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => TradeHistory.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load trades');
      }
    } catch (e) {
      throw Exception('Error fetching trades: $e');
    }
  }

 
  //  WebSocketChannel connectWebSocket() {
  //   final channel = WebSocketChannel.connect(
  //     Uri.parse('ws://192.168.4.30:4600'),
  //   );
  //   return channel;
  // }
}
