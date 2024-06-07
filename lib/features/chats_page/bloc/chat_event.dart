part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetRoomKey extends ChatEvent {
  final int userid;
  final BuildContext context;

  const GetRoomKey({required this.userid, required this.context});
}

class GetAllMessages extends ChatEvent {
  final String roomkey;
  const GetAllMessages({required this.roomkey});
}

class MessageReceived extends ChatEvent {
  final Map<String, dynamic> message;
  const MessageReceived({required this.message});
}

class SendMessage extends ChatEvent {
  final Map<String, dynamic> message;

  const SendMessage({required this.message});
}
