import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sist_hub/utils/constants.dart';
import 'package:sist_hub/utils/secure_storage.dart';

import '../../../data/model/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  var stroage = SecureStorage();

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(appStarted);
    on<AuthLogin>(login);
    on<AuthLogout>(logout);
  }

  FutureOr<void> appStarted(AppStarted event, Emitter<AuthState> emit) async {
    if (await _checkAuthenticated()) {
      CurrentUser.instance.token = await _readToken();
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  FutureOr<void> login(AuthLogin event, Emitter<AuthState> emit) async {
    var user = event.user;
    _storeUser(user.token, user.email);
    print("auth login stored");
    emit(Authenticated());
  }

  FutureOr<void> logout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    _deleteUser();
    CurrentUser.instance.token = null;
    emit(UnAuthenticated());
  }

  Future<FutureOr<void>> _storeUser(String token, email) async {
    await stroage.writeSecureData(keyToken, token);
    await stroage.writeSecureData(keyEmail, email);
  }

  FutureOr<String> _readUserEmail() async {
    var email = await stroage.readSecureData(keyToken);
    return email;
  }

  FutureOr<bool> _checkAuthenticated() async {
    if ((await _readToken()).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  FutureOr<String> _readToken() async {
    var token = await stroage.readSecureData(keyToken);
    return token;
  }

  Future<FutureOr<void>> _deleteUser() async {
    await stroage.deleteSecureData(keyToken);
    await stroage.deleteSecureData(keyEmail);
  }
}
