part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final bool longPressed;

  const LoginButtonPressed({
    required this.email,
    required this.password,
    required this.longPressed,
  });

  @override
  List<Object?> get props => [email, password];
}
