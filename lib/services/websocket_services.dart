// import 'dart:async';
// import 'dart:convert';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class WebSocketService {
//   final WebSocketChannel _channel;
//   final StreamController<WebSocketMessage> _controller = StreamController<WebSocketMessage>();

//   WebSocketService(String url) : _channel = WebSocketChannel.connect(Uri.parse(url));

//   void listen() {
//     _channel.stream.listen((message) {
//       final jsonData = json.decode(message);
//       final messageType = WebSocketMessageType.values.firstWhere(
//         (e) => e.toString() == 'WebSocketMessageType.' + jsonData['type'],
//       );
//       final data = jsonData['data'];

//       _controller.add(WebSocketMessage(type: messageType, data: data));
//     });
//   }


//   Stream<WebSocketMessage> get stream => _controller.stream;

//   void dispose() {
//     _controller.close();
//     _channel.sink.close();
//   }
// }





// enum WebSocketMessageType {
//   newOrder, // for new orders
//   orderExpired, // for expired orders
//   tradeCompleted, // for completed trades
// }

// class WebSocketMessage {
//   final WebSocketMessageType type;
//   final dynamic data; 

//   WebSocketMessage({
//     required this.type,
//     required this.data,
//   });
// }


