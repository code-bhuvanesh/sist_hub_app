part of 'bus_map_bloc.dart';

sealed class BusMapState extends Equatable {
  const BusMapState();
  
  @override
  List<Object> get props => [];
}

final class BusMapInitial extends BusMapState {}
