part of 'chats_bloc.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();
  
  @override
  List<Object> get props => [];
}

final class ChatsInitial extends ChatsState {}


class AllUserChats extends ChatsState {
  final List<Map<String, dynamic>> users;

  const AllUserChats({required this.users});
}

class RoomKey extends ChatsState{
  final String roomkey;
  const RoomKey({required this.roomkey});
}

class AllMessages extends ChatsState {
  final List<Map<String, dynamic>> allMessages;
  const AllMessages({required this.allMessages});
}

class ReceivedMessage extends ChatsState{
  final Map<String , dynamic> message;
  const ReceivedMessage({required this.message});
}