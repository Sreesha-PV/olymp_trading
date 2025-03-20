// import 'package:flutter/material.dart';
// import 'package:olymp_trade/features/model/transaction_model.dart';
// import 'package:olymp_trade/services/transaction_history_services.dart';

// class TransactionHistoryProvider with ChangeNotifier{
//   final ApiService _apiService = ApiService();

//   // Fetch transactions from the API
//   Future<List<Transaction>> fetchTransactions() async {
//     try {
//       return await _apiService.fetchTransactions();
//     } catch (error) {
//       throw Exception('Failed to load transaction history');
//     }
//   }
// }


// import 'package:flutter/foundation.dart';
// import 'package:olymp_trade/features/model/trade_history_model.dart';
// import 'package:olymp_trade/services/trade_history_services.dart';

// class TradeHistoryProvider extends ChangeNotifier{

//   final TradeHistoryServices _tradeHistoryService= TradeHistoryServices();
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   Future<List<TradeHistory>>getTradeHistory()async{
//    try {
//       return await _tradeHistoryService.getTradeHistory();
//     } catch (error) {
//       throw Exception('Failed to load transaction history');
//     }
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:olymp_trade/features/model/trade_history_model.dart';
// import 'package:olymp_trade/services/trade_history_services.dart';


// class TradeHistoryProvider with ChangeNotifier {
//   List<TradeHistory> _tradeHistory = [];
//   bool _isLoading = false;
//   String _errorMessage = '';

//   List<TradeHistory> get tradeHistory => _tradeHistory;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;

//   Future<void> fetchTradeHistory() async {
//     _isLoading = true;
//     notifyListeners(); 

//     try {
//       TradeHistoryServices tradeHistoryServices = TradeHistoryServices();
//       _tradeHistory = await tradeHistoryServices.getTradeHistory();
//       _isLoading = false;
//     } catch (e) {
//       _errorMessage = e.toString();
//       _isLoading = false;
//     }

//     notifyListeners(); 
//   }
// }





import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:olymp_trade/features/model/trade_history_model.dart';
import 'package:olymp_trade/services/trade_history_services.dart';

class TradeHistoryProvider extends ChangeNotifier {
  final TradeHistoryServices _service = TradeHistoryServices();
  List<TradeHistory> _tradeHistory = [];
  bool _isLoading = false;
  String? _errorMessage;
  late final StreamSubscription _socketSubscription;

  List<TradeHistory> get tradeHistory => _tradeHistory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  TradeHistoryProvider() {
    fetchTrades();
    // _connectWebSocket();
  }

  Future<void> fetchTrades() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tradeHistory = await _service.fetchTrades();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // void _connectWebSocket() {
  //   final channel = _service.connectWebSocket();

  //   _socketSubscription = channel.stream.listen(
  //     (message) {
  //       final data = json.decode(message);
  //       TradeHistory newOrder = TradeHistory.fromJson(data);

  //       _tradeHistory.insert(0, newOrder); 
  //       notifyListeners();
  //     },
  //     onError: (error) {
  //       _errorMessage = "WebSocket error: $error";
  //       notifyListeners();
  //     },
  //     onDone: () {
  //       _errorMessage = "WebSocket disconnected";
  //       notifyListeners();
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   _socketSubscription.cancel();
  //   super.dispose();
  // }
}



