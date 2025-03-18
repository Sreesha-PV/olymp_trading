import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:olymp_trade/features/chart/chart_repo.dart';
import 'package:olymp_trade/features/chart/symbol_search_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class CandleChartWidget extends StatefulWidget {
  final BinanceRepository repository;
  final bool initialThemeIsDark;

  const CandleChartWidget({
    super.key,
    required this.repository,
    this.initialThemeIsDark = false,
  });

  @override
  _CandleChartWidgetState createState() => _CandleChartWidgetState();
}

class _CandleChartWidgetState extends State<CandleChartWidget> {
  List<Candle> candles = [];
  WebSocketChannel? _candlestickChannel;
  WebSocketChannel? _priceChannel;
  bool themeIsDark = false;
  List<String> symbols = [];
  String currentSymbol = "";
  double livePrice = 0.0;

  @override
  void initState() {
    super.initState();
    themeIsDark = widget.initialThemeIsDark;

    // Fetch available symbols and initialize WebSocket for the first symbol
    widget.repository.fetchSymbols().then((value) {
      symbols = value;
      if (symbols.isNotEmpty) fetchCandles(symbols[0]);
    });
  }

  @override
  void dispose() {
    _candlestickChannel?.sink.close();
    _priceChannel?.sink.close();
    super.dispose();
  }

  Future<void> fetchCandles(String symbol) async {
    if (_candlestickChannel != null) {
      _candlestickChannel!.sink.close();
      _candlestickChannel = null;
    }
    setState(() {
      candles = [];
    });

    // Fetch initial candles
    final data = await widget.repository.fetchCandles(symbol: symbol, interval: "1m");
    setState(() {
      candles = data;
      currentSymbol = symbol;
    });

    // Establish WebSocket connection for candlesticks
    _candlestickChannel = widget.repository.establishConnection(symbol.toLowerCase(), "1m");

    // Establish WebSocket connection for live price updates
    _priceChannel = widget.repository.establishPriceConnection(symbol.toLowerCase());

    // Listen for candlestick updates
    _candlestickChannel!.stream.listen((data) {
      updateCandlesFromSnapshot(data);
    });

    // Listen for price updates
    _priceChannel!.stream.listen((data) {
      updateLivePriceFromSnapshot(data);
    });
  }

  void updateCandlesFromSnapshot(dynamic snapshot) {
    final map = jsonDecode(snapshot as String) as Map<String, dynamic>;
    if (map.containsKey('k')) {  // Check if kline data is present
      final kline = map['k'] as Map<String, dynamic>;

      final tradeTime = DateTime.fromMillisecondsSinceEpoch(kline['T']);
      final open = double.parse(kline['o']);
      final close = double.parse(kline['c']);
      final high = double.parse(kline['h']);
      final low = double.parse(kline['l']);
      final volume = double.parse(kline['v']);

      // Schedule the setState call to run after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          // Update the latest candle (or append a new one)
          if (candles.isNotEmpty) {
            candles[0] = Candle(
              date: tradeTime,
              open: open,
              high: high > candles[0].high ? high : candles[0].high,
              low: low < candles[0].low ? low : candles[0].low,
              close: close,
              volume: volume,
            );
          } else {
            candles.add(Candle(
              date: tradeTime,
              open: open,
              high: high,
              low: low,
              close: close,
              volume: volume,
            ));
          }
        });
      });
    }
  }

  void updateLivePriceFromSnapshot(dynamic snapshot) {
    final map = jsonDecode(snapshot as String) as Map<String, dynamic>;
    if (map.containsKey('c')) {
      setState(() {
        livePrice = double.parse(map['c']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Binance Live Data"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                themeIsDark = !themeIsDark;
              });
            },
            icon: Icon(
              themeIsDark
                  ? Icons.wb_sunny_sharp
                  : Icons.nightlight_round_outlined,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text(
            //     'Live Price: \$${livePrice.toStringAsFixed(2)}',
            //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //   ),
            // ),
            Expanded(
              child: Candlesticks(
                key: Key(currentSymbol),
                candles: candles,
                actions: [
                  ToolBarAction(
                    width: 100,
                    onPressed: () {
                                 
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SymbolsSearchModal(
                            symbols: symbols,
                            onSelect: (value) {
                              fetchCandles(value);
                            }, 
                         
                          );
                        },
                      );
                    },
                    child: Text(
                      currentSymbol,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
