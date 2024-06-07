part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatState {}

class RoomKey extends ChatState {
  final String roomkey;
  const RoomKey({required this.roomkey});
}

class AllMessages extends ChatState {
  final List<Map<String, dynamic>> allMessages;
  const AllMessages({required this.allMessages});
}

class ReceivedMessage extends ChatState {
  final Map<String, dynamic> message;
  const ReceivedMessage({required this.message});

  @override
  List<Object> get props => [message];
}
