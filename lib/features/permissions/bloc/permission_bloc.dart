import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<GetAllPermissions>(getAllPermission);
  }

  Future<FutureOr<void>> getAllPermission(
      GetAllPermissions event, Emitter<PermissionState> emit) async {
    if (Platform.isAndroid) {
      // print("permission 1 : ${await Permission.storage.request().isGranted}");
      // print("permission 1 : ${await Permission.photos.request().isGranted}");
      emit(PermissionInitial());
      if (await Permission.photos.request().isGranted) {
        emit(PermissionGranted());
      } else {
        emit(PermissionDenied());
      }
    }
  }
}
