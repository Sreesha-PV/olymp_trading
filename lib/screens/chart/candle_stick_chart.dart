// import 'dart:math';
// import 'package:candlesticks/candlesticks.dart';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/model/api_services.dart';
// import 'package:olymp_trade/model/order_model.dart';


// class TradingScreen extends StatefulWidget {
//   const TradingScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _TradingScreenState createState() => _TradingScreenState();
// }

// class _TradingScreenState extends State<TradingScreen> {
//   late Future<List<TradingOrder>> _orders;

//   @override
//   void initState() {
//     super.initState();
//     _orders = fetchTradingDataFromAPI();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text('Candlestick Chart'),
//       ),
//       body: FutureBuilder<List<TradingOrder>>(
//         future: _orders,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return const Center(child: Text('Error loading data'));
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No data available'));
//           }

//           List<TradingOrder> orders = snapshot.data!;

         
//           // List<Candle> candles = orders.map((order) {
//           // orders.map((order) {
//           //   return Candle(
//           //     open: order.open,
//           //     close: order.close,
//           //     high: order.high,
//           //     low: order.low,
//           //     date: order.time, 
//           //     volume: 2, 
//           //   );
//           // }).toList();

//           return const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: CandlestickChart(
//               // candles: candles,
//               // style: ChartStyle(
//               //   gridLineStyle: GridLineStyle(),
//               //   axisLineStyle: AxisLineStyle(),
//               //   gridStyle: GridStyle(),
//               // ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




// List<Candle> generateMockCandlestickData(int count) {
//   List<Candle> data = [];
//   DateTime now = DateTime.now();
//   double lastClose = 100.0;

//   for (int i = 0; i < count; i++) {
//     DateTime time = now.subtract(Duration(minutes: i * 5));
//     double open = lastClose;
//     double high = open + Random().nextDouble() * 5;
//     double low = open - Random().nextDouble() * 5;
//     double close = low + Random().nextDouble() * (high - low);
//     double volume = Random().nextDouble() * 1000;

//     data.add(Candle(
//       date: time,
//       open: open,
//       high: high,
//       low: low,
//       close: close,
//       volume: volume,
//     ));

//     lastClose = close;
//   }

//   return data.reversed.toList();
// }


// class CandlestickChart extends StatelessWidget {
//   const CandlestickChart({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Candle> mockData = generateMockCandlestickData(50);
//     return Scaffold(
//       backgroundColor: Colors.black, 
//       body: Column(
//         children: [
//           Expanded(
//           child: Candlesticks(
//           candles: mockData,
//           onLoadMoreCandles: () async {}, 
//         ),
//         ),
//         ],
//       ),
//     );
//   }
// }






// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:olymp_trade/websocket/helper.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:candlesticks/candlesticks.dart';

// class LiveCandlestickChart extends StatefulWidget {
//   @override
//   _LiveCandlestickChartState createState() => _LiveCandlestickChartState();
// }

// class _LiveCandlestickChartState extends State<LiveCandlestickChart> {
//   late WebSocketChannel channel;
//   List<Candle> candles = [];

//   @override
//   void initState() {
//     super.initState();
//     connectToWebSocket();
//   }

//   void connectToWebSocket() {
//     String socketUrl = 'wss://stream.binance.com:9443/ws/btcusdt@kline_1m'; // Use Binance WebSocket for testing
//     channel = WebSocketHelper.connect(socketUrl);

//     channel.stream.listen((message) {
//       print("Received: $message"); // Debugging: Print incoming WebSocket data
//       var data = jsonDecode(message);

//       if (data.containsKey('k')) {
//         var kline = data['k'];
//         Candle newCandle = Candle(
//           date: DateTime.fromMillisecondsSinceEpoch(kline['t']),
//           open: double.parse(kline['o']),
//           high: double.parse(kline['h']),
//           low: double.parse(kline['l']),
//           close: double.parse(kline['c']),
//           volume: double.parse(kline['v']),
//         );

//         updateChartData(newCandle);
//       } else {
//         print("Invalid data format: $data"); // Debugging: Print unexpected data
//       }
//     }, onError: (error) {
//       print("WebSocket Error: $error");
//     }, onDone: () {
//       print("WebSocket Closed. Reconnecting...");
//       connectToWebSocket();
//     });
//   }

//   void updateChartData(Candle newCandle) {
//     setState(() {
//       if (candles.isNotEmpty && candles.last.date == newCandle.date) {
//         candles[candles.length - 1] = newCandle;
//       } else {
//         candles.add(newCandle);
//         if (candles.length > 50) {
//           candles.removeAt(0);
//         }
//       }
//     });
//   }



//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Live Candlestick Chart')),
//       body: candles.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : Candlesticks(candles: candles),
//     );
//   }
// }
