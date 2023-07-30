part of 'permission_bloc.dart';

abstract class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => [];
}

class PermissionInitial extends PermissionState {}

class PermissionGranted extends PermissionState {}

class PermissionDenied extends PermissionState {}
