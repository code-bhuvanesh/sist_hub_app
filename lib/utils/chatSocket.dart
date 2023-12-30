import 'dart:convert';

import 'package:http/http.dart';
import 'package:sist_hub/features/chats_page/bloc/chats_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'constants.dart';

class ChatSocket {
  final String roomkey;
  final ChatsBloc chatsBloc;
  late Uri wsUri;
  late WebSocketChannel ws;

  ChatSocket({required this.roomkey, required this.chatsBloc}) {
    wsUri = Uri.parse("$chatSocketUrl$roomkey/");
    ws = WebSocketChannel.connect(wsUri);
    listen();
  }

  void listen() {
    ws.stream.listen((message) {
      print(message);
      chatsBloc.add(
        MessageReceived(message: jsonDecode(message) as Map<String, dynamic>),
      );
    }).onError((_) => listen);
  }

  void sendMsg(String msg) {
    ws.sink.add(msg);
  }

  void dispose() {
    ws.sink.close();
  }
}
