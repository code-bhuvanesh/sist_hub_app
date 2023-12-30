import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sist_hub/data/repository/chats_repository.dart';
import 'package:sist_hub/utils/chatSocket.dart';
import 'package:sist_hub/utils/constants.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsRepository chatsRepository = ChatsRepository();

  ChatSocket? chatSocket;

  ChatsBloc() : super(ChatsInitial()) {
    on<GetAllUsersChats>(onGetAllUsersChats);
    on<GetRoomName>(onGetRoomname);
    on<GetAllMessages>(onGetAllMessages);
    on<MessageReceived>(onMessageReceived);
    on<SendMessage>(onSendMessage);
  }

  FutureOr<void> onGetAllUsersChats(
    GetAllUsersChats event,
    Emitter<ChatsState> emit,
  ) async {
    var users = await chatsRepository.getAllChats();
    emit(AllUserChats(users: users));
  }

  FutureOr<void> onGetRoomname(
    GetRoomName event,
    Emitter<ChatsState> emit,
  ) async {
    var roomkey = await chatsRepository.getRoomname(event.userid);
    emit(RoomKey(roomkey: roomkey));
    chatSocket = ChatSocket(roomkey: roomkey, chatsBloc: this);
  }

  FutureOr<void> onGetAllMessages(
    GetAllMessages event,
    Emitter<ChatsState> emit,
  ) async {
    var roomkey = event.roomkey;
    var messages = await chatsRepository.getAllMessages(roomkey);
    emit(AllMessages(allMessages: messages));
  }

  FutureOr<void> onMessageReceived(
    MessageReceived event,
    Emitter<ChatsState> emit,
  ) async {
    print("message received");
    print(event.message);
    if (event.message["sender"] != CurrentUser.instance.userId) {
      var newMsg = {"message": event.message["message"], "isSender": false};
      emit(ReceivedMessage(message: newMsg));
    }
  }

  FutureOr<void> onSendMessage(
    SendMessage event,
    Emitter<ChatsState> emit,
  ) async {
    if (chatSocket != null) {
      chatSocket!.sendMsg(jsonEncode(event.message));
    }
  }
}
