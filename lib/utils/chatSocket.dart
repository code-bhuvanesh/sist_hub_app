import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/chats_page/bloc/chat_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'constants.dart';

class ChatSocket {
  final String roomkey;
  late Uri wsUri;
  late WebSocketChannel ws;

  ChatSocket({required this.roomkey}) {
    wsUri = Uri.parse("$chatSocketUrl$roomkey/");
    ws = WebSocketChannel.connect(wsUri);
    // listen();
  }

  // void listen() {
  //   ws.stream.listen((message) async {
  //     print(message);
  //     context.read<ChatBloc>().add(
  //           MessageReceived(
  //               message: jsonDecode(message) as Map<String, dynamic>),
  //         );
  //   }).onError((r) {
  //     print("error: $r");
  //     listen();
  //   });
  // }

  void sendMsg(String msg) {
    ws.sink.add(msg);
  }

  void dispose() {
    ws.sink.close();
  }
}
