import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sist_hub/data/repository/chats_repository.dart';
import 'package:sist_hub/utils/chatSocket.dart';
import 'package:sist_hub/utils/constants.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatsRepository chatsRepository = ChatsRepository();

  ChatSocket? chatSocket;

  ChatBloc() : super(ChatsInitial()) {
    on<GetRoomKey>(onGetRoomname);
    on<GetAllMessages>(onGetAllMessages);
    on<MessageReceived>(onMessageReceived);
    on<SendMessage>(onSendMessage);
  }

  FutureOr<void> onGetRoomname(
    GetRoomKey event,
    Emitter<ChatState> emit,
  ) async {
    var roomkey = await chatsRepository.getRoomname(event.userid);
    chatSocket = ChatSocket(roomkey: roomkey);
    emit(RoomKey(roomkey: roomkey));
  }

  FutureOr<void> onGetAllMessages(
    GetAllMessages event,
    Emitter<ChatState> emit,
  ) async {
    var roomkey = event.roomkey;
    var messages = await chatsRepository.getAllMessages(roomkey);
    emit(AllMessages(allMessages: messages));
    chatSocket!.ws.stream.listen((message) async {
      print(message);
      add(
        MessageReceived(message: jsonDecode(message) as Map<String, dynamic>),
      );
    });
  }

  FutureOr<void> onMessageReceived(
    MessageReceived event,
    Emitter<ChatState> emit,
  ) async {
    print("message received");
    // print(event.message);
    if (event.message["sender"] != CurrentUser.instance.userId) {
      var newMsg = {"message": event.message["message"], "isSender": false};
      emit(ReceivedMessage(message: newMsg));
    }
  }

  FutureOr<void> onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    if (chatSocket != null) {
      chatSocket!.sendMsg(jsonEncode(event.message));
    }
  }
}
