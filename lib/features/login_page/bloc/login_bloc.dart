import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sist_hub/data/repository/user_repository.dart';
import 'package:sist_hub/features/auth/bloc/auth_bloc.dart';

import '../../../utils/constants.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;

  LoginBloc({required this.authBloc}) : super(LoginInitial()) {
    on<LoginButtonPressed>(onLoginPressed);
  }
  FutureOr<void> onLoginPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    var email = event.email;
    var password = event.password;
    var user = await userRepository.loginUser(
      email: email,
      password: password,
      longPressed: event.longPressed,
    );
    user.fold(
      (user) {
        print("token : ${user.token}");
        authBloc.add(AuthLogin(user));
        CurrentUser.instance.token = user.token;
        emit(LoginSucessfull());
      },
      (userError) {
        print("token : error");
        emit(LoginFailure(error: userError.error));
      },
    );
  }
}
