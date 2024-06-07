part of 'chat_users_bloc.dart';

sealed class ChatUsersEvent extends Equatable {
  const ChatUsersEvent();

  @override
  List<Object> get props => [];
}


class GetAllUsersChats extends ChatUsersEvent {}

