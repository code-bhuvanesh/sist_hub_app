part of 'chat_users_bloc.dart';

sealed class ChatUsersState extends Equatable {
  const ChatUsersState();
  
  @override
  List<Object> get props => [];
}

final class ChatUsersInitial extends ChatUsersState {}

class AllUserChats extends ChatUsersState {
  final List<Map<String, dynamic>> users;

  const AllUserChats({required this.users});
}
