import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_posts_event.dart';
part 'add_posts_state.dart';

class AddPostsBloc extends Bloc<AddPostsEvent, AddPostsState> {
  AddPostsBloc() : super(AddPostsInitial()) {
    on<AddPostsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
