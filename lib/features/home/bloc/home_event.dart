part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends HomeEvent {}

class LikeOrUnlikePost extends HomeEvent {
  final int postId;
  const LikeOrUnlikePost({required this.postId});
}

class CommentOnPost extends HomeEvent {
  final int postId;
  final String comment;

  const CommentOnPost({required this.postId, required this.comment});
}
