part of 'permission_bloc.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class GetAllPermissions extends PermissionEvent {}

class GetPhotosPermission extends PermissionEvent {}
