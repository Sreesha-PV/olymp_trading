
import 'dart:convert';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceRepository {
  // Fetch historical candlestick data from Binance
  Future<List<Candle>> fetchCandles({required String symbol, required String interval, int? endTime}) async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval" +
            (endTime != null ? "&endTime=$endTime" : ""));
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  // Fetch available symbols from Binance
  Future<List<String>> fetchSymbols() async {
    final uri = Uri.parse("https://api.binance.com/api/v3/ticker/price");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => e["symbol"] as String)
        .toList();
  }

  // Establish WebSocket connection for candlestick updates
  WebSocketChannel establishConnection(String symbol, String interval) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );
    // Send the subscription message to the WebSocket server
    channel.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": ["$symbol@kline_$interval"],  // Symbol and interval (e.g., 'btcusdt@kline_1m')
          "id": 1,
        },
      ),
    );
    return channel;
  }

  // Establish WebSocket connection for live price updates
  WebSocketChannel establishPriceConnection(String symbol) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/${symbol.toLowerCase()}@miniTicker'),
    );
    return channel;
  }
}
