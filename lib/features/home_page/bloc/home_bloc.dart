import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sist_hub/data/repository/posts_repository.dart';

import '../../../data/model/post.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PostsRepository postsRepository = PostsRepository();
  HomeBloc() : super(HomeInitial()) {
    on<LoadPosts>(loadPosts);
    on<LikeOrUnlikePost>(likedOrUnlikedPost);
    on<GetCommentsForPost>(getCommentsForPost);
    on<AddCommentOnPost>(addCommnetOnPost);
  }

  FutureOr<void> loadPosts(
    LoadPosts event,
    Emitter<HomeState> emit,
  ) async {
    emit(PostsLoading());
    var loadedPosts = await postsRepository.getPosts();
    emit(PostsLoaded(posts: loadedPosts));
  }

  FutureOr<void> likedOrUnlikedPost(
    LikeOrUnlikePost event,
    Emitter<HomeState> emit,
  ) async {
    var updatedPost = await postsRepository.likeOrUnlikePost(event.postId);
    print("got updated post like : ${updatedPost.userLiked}");
    emit(PostLikedOrUnliked(updatedPost: updatedPost));
  }

  FutureOr<void> getCommentsForPost(
    GetCommentsForPost event,
    Emitter<HomeState> emit,
  ) async {
    emit(CommentsLoading());
    List<PostComment> comments = await postsRepository.getPostComments(
      event.postId,
    );
    emit(
      CommentsLoaded(
        comments: comments,
      ),
    );
  }

  Future<FutureOr<void>> addCommnetOnPost(
    AddCommentOnPost event,
    Emitter<HomeState> emit,
  ) async {
    emit(SendingComment());
    var response = await postsRepository.addComment(
      postID: event.postId,
      comment: event.comment,
    );
    var comment = PostComment.fromJson(response);
    emit(CommentAdded(comment: comment));
  }
}
