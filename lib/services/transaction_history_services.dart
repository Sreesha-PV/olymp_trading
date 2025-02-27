import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:olymp_trade/features/model/transaction_model.dart';


class ApiService {

  static const String apiUrl = 'https://run.mocky.io/v3/7643cbc2-a82b-4be2-85be-80544e3d4bf6';

  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Transaction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transaction history');
    }
  }
}

