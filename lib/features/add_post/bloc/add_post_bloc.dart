import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sist_hub/data/repository/posts_repository.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<AddPostToServer>(addPostToServer);
  }

  Future<FutureOr<void>> addPostToServer(
      AddPostToServer event, Emitter<AddPostState> emit) async {
    var response = await PostsRepository().sharePost(
      description: event.discription,
      file: event.file,
    );
    if (response["statuscode"] == 200) {
      emit(PostsAddedSucessfully());
    } else {
      emit(PostsAddedUnsucessful());
    }
  }
}
