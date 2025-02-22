import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/html.dart'; // For Web
import 'package:flutter/foundation.dart' show kIsWeb;

class WebSocketHelper {
  static WebSocketChannel connect(String url) {
    if (kIsWeb) {
      return HtmlWebSocketChannel.connect(url); // WebSockets for Flutter Web
    } else {
      return IOWebSocketChannel.connect(url); // WebSockets for Mobile (Android/iOS)
    }
  }
}
