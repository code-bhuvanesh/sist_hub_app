import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sist_hub/data/repository/posts_repository.dart';

import '../../../data/model/post.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadPosts>(loadPosts);
  }

  Future<FutureOr<void>> loadPosts(
      LoadPosts event, Emitter<HomeState> emit) async {
    emit(PostsLoading());
    var loadedPosts = await PostsRepository().getPosts();
    emit(PostsLoaded(posts: loadedPosts));
  }
}
