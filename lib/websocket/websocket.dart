import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:olymp_trade/websocket/helper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:candlesticks/candlesticks.dart';


class LiveCandlestickChart extends StatefulWidget {
  const LiveCandlestickChart({super.key});

  @override
  _LiveCandlestickChartState createState() => _LiveCandlestickChartState();
}

class _LiveCandlestickChartState extends State<LiveCandlestickChart> {
  late WebSocketChannel channel;
  List<Candle> candles = [];

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    String socketUrl = 'wss://stream.binance.com:9443/ws/btcusdt@kline_1m'; // Test URL
    channel = WebSocketHelper.connect(socketUrl);

    channel.stream.listen((message) {
      print("Received: $message"); 
      var data = jsonDecode(message);

      if (data.containsKey('k')) {
        var kline = data['k'];
        Candle newCandle = Candle(
          date: DateTime.fromMillisecondsSinceEpoch(kline['t']),
          open: double.parse(kline['o']),
          high: double.parse(kline['h']),
          low: double.parse(kline['l']),
          close: double.parse(kline['c']),
          volume: double.parse(kline['v']),
        );

        updateChartData(newCandle);
      } else {
        print("Invalid data format: $data");
      }
    }, onError: (error) {
      print("WebSocket Error: $error");
    }, onDone: () {
      print("WebSocket Closed. Reconnecting...");
      connectToWebSocket();
    });
  }

  // void updateChartData(Candle newCandle) {
  //   setState(() {
  //     if (candles.isNotEmpty && candles.last.date == newCandle.date) {
  //       candles[candles.length - 1] = newCandle;
  //     } else {
  //       candles.add(newCandle);
  //       if (candles.length > 50) {
  //         candles.removeAt(0);
  //       }
  //     }
  //   });
  // }

// void updateChartData(Candle newCandle) {
//   setState(() {
//     if (candles.isNotEmpty) {
//       if (candles.last.date == newCandle.date) {
//         candles[candles.length - 1] = newCandle; 
//       } else {
//         candles.add(newCandle);
//         if (candles.length > 50) { // Keep max 50 candles
//           candles.removeAt(0);
//         }
//       }
//     } else {
//       candles.add(newCandle); 
//     }
//   });
// }
void updateChartData(Candle newCandle) {
  setState(() {
    if (candles.isEmpty) {
      candles.add(newCandle); 
    } else {
      if (candles.last.date == newCandle.date) {
        candles[candles.length - 1] = newCandle;
      } else {
        candles.add(newCandle);
        if (candles.length > 50) { 
          candles.removeAt(0);
        }
      }
    }
  });

  print("Updated Candles List Length: ${candles.length}"); 
}


  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Candlestick Chart')),
      body: candles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Candlesticks(candles: candles),
    );
  }
}
