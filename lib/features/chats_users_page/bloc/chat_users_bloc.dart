import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sist_hub/data/repository/chats_repository.dart';
import 'package:sist_hub/utils/chatSocket.dart';

part 'chat_users_event.dart';
part 'chat_users_state.dart';

class ChatUsersBloc extends Bloc<ChatUsersEvent, ChatUsersState> {

  var chatsRepository = ChatsRepository();
  ChatSocket? chatSocket;

  ChatUsersBloc() : super(ChatUsersInitial()) {
    on<GetAllUsersChats>(onGetAllUsersChats);
  }

  FutureOr<void> onGetAllUsersChats(
    GetAllUsersChats event,
    Emitter<ChatUsersState> emit,
  ) async {
    var users = await chatsRepository.getAllChats();
    emit(AllUserChats(users: users));
  }
}


