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
    on<LikeOrUnlikePost>(likedOrUnlikedPost);
    on<GetCommentsForPost>(getCommentsForPost);
  }

  FutureOr<void> loadPosts(
    LoadPosts event,
    Emitter<HomeState> emit,
  ) async {
    emit(PostsLoading());
    var loadedPosts = await PostsRepository().getPosts();
    emit(PostsLoaded(posts: loadedPosts));
  }

  FutureOr<void> likedOrUnlikedPost(
    LikeOrUnlikePost event,
    Emitter<HomeState> emit,
  ) async {
    var updatedPost = await PostsRepository().likeOrUnlikePost(event.postId);
    print("got updated post like : ${updatedPost.userLiked}");
    emit(PostLikedOrUnliked(updatedPost: updatedPost));
  }

  Future<FutureOr<void>> getCommentsForPost(
    GetCommentsForPost event,
    Emitter<HomeState> emit,
  ) async {
    emit(CommentsLoading());
    List<PostComment> comments =
        await PostsRepository().getPostComments(event.postId);
    emit(CommentsLoaded(comments: comments));
  }
}
