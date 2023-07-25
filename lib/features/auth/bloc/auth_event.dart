part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class ReadUser extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final User user;

  AuthLogin(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthLogout extends AuthEvent {}
