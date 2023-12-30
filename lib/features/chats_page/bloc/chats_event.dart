part of 'chats_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersChats extends ChatsEvent {}

class GetRoomName extends ChatsEvent {
  final int userid;

  const GetRoomName({required this.userid});
}

class GetAllMessages extends ChatsEvent {
  final String roomkey;
  const GetAllMessages({required this.roomkey});

}


class MessageReceived extends ChatsEvent{
  final Map<String , dynamic> message;
  const MessageReceived({required this.message});
}

class SendMessage extends ChatsEvent{
  final Map<String , dynamic> message;
   
  const SendMessage({required this.message});
}