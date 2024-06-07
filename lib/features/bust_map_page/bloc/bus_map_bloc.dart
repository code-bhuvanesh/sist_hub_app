import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bus_map_event.dart';
part 'bus_map_state.dart';

class BusMapBloc extends Bloc<BusMapEvent, BusMapState> {
  BusMapBloc() : super(BusMapInitial()) {
    on<BusMapEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
