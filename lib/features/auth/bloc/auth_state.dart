part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthReadUser extends AuthState {
  final OtherUser user;

  AuthReadUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UnAuthenticated extends AuthState {}

class Authenticated extends AuthState {}
