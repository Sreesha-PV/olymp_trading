
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/transaction_model.dart';
import 'package:olymp_trade/services/transaction_history_services.dart';

class TransactionHistoryProvider with ChangeNotifier{
  final ApiService _apiService = ApiService();

  // Fetch transactions from the API
  Future<List<Transaction>> fetchTransactions() async {
    try {
      return await _apiService.fetchTransactions();
    } catch (error) {
      throw Exception('Failed to load transaction history');
    }
  }
}