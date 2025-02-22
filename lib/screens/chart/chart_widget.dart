import 'dart:convert';
import './candle_ticker_model.dart';
import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'chart_repo.dart';
import 'symbol_search_model.dart';

class CandleChartWidget extends StatefulWidget {
  final BinanceRepository repository;
  final bool initialThemeIsDark;

  const CandleChartWidget({
    Key? key,
    required this.repository,
    this.initialThemeIsDark = false,
  }) : super(key: key);

  @override
  _CandleChartWidgetState createState() => _CandleChartWidgetState();
}

class _CandleChartWidgetState extends State<CandleChartWidget> {
  List<Candle> candles = [];
  WebSocketChannel? _channel;
  bool themeIsDark = false;
  String currentInterval = "1m";
  final intervals = [
    '1m',
    '3m',
    '5m',
    '15m',
    '30m',
    '1h',
    '2h',
    '4h',
    '6h',
    '8h',
    '12h',
    '1d',
    '3d',
    '1w',
    '1M',
  ];
  List<String> symbols = [];
  String currentSymbol = "";

  @override
  void initState() {
    themeIsDark = widget.initialThemeIsDark;
    fetchSymbols().then((value) {
      symbols = value;
      if (symbols.isNotEmpty) fetchCandles(symbols[0], currentInterval);
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_channel != null) _channel!.sink.close();
    super.dispose();
  }

  Future<List<String>> fetchSymbols() async {
    try {
      final data = await widget.repository.fetchSymbols();
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<void> fetchCandles(String symbol, String interval) async {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
    setState(() {
      candles = [];
      currentInterval = interval;
    });

    try {
      final data = await widget.repository
          .fetchCandles(symbol: symbol, interval: interval);
      _channel = widget.repository
          .establishConnection(symbol.toLowerCase(), currentInterval);
      setState(() {
        candles = data;
        currentInterval = interval;
        currentSymbol = symbol;
      });
    } catch (e) {
      return;
    }
  }

  void updateCandlesFromSnapshot(AsyncSnapshot<Object?> snapshot) {
    if (candles.isEmpty) return;
    if (snapshot.data != null) {
      final map = jsonDecode(snapshot.data as String) as Map<String, dynamic>;
      if (map.containsKey("k") == true) {
        final candleTicker = CandleTickerModel.fromJson(map);

        if (candles[0].date == candleTicker.candle.date &&
            candles[0].open == candleTicker.candle.open) {
          candles[0] = candleTicker.candle;
        } else if (candleTicker.candle.date.difference(candles[0].date) ==
            candles[0].date.difference(candles[1].date)) {
          candles.insert(0, candleTicker.candle);
        }
      }
    }
  }

  Future<void> loadMoreCandles() async {
    try {
      final data = await widget.repository.fetchCandles(
          symbol: currentSymbol,
          interval: currentInterval,
          endTime: candles.last.date.millisecondsSinceEpoch);
      candles.removeLast();
      setState(() {
        candles.addAll(data);
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Binance Candles"),
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
          )
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: _channel == null ? null : _channel!.stream,
          builder: (context, snapshot) {
            updateCandlesFromSnapshot(snapshot);
            return Candlesticks(
              key: Key(currentSymbol + currentInterval),
              candles: candles,
              onLoadMoreCandles: loadMoreCandles,
              actions: [
                ToolBarAction(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            width: 200,
                            color: Theme.of(context).indicatorColor,
                            child: Wrap(
                              children: intervals
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 50,
                                          height: 30,
                                          child: RawMaterialButton(
                                            elevation: 0,
                                            fillColor: const Color(0xFF494537),
                                            onPressed: () {
                                              fetchCandles(currentSymbol, e);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                color: Color(0xFFF0B90A),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    currentInterval,
                  ),
                ),
                ToolBarAction(
                  width: 100,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SymbolsSearchModal(
                          symbols: symbols,
                          onSelect: (value) {
                            fetchCandles(value, currentInterval);
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    currentSymbol,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
