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

class GetCommentsForPost extends HomeEvent {
  final int postId;
  const GetCommentsForPost({
    required this.postId,
  });
}

class AddCommentOnPost extends HomeEvent {
  final int postId;
  final String comment;
  const AddCommentOnPost({required this.postId, required this.comment});
}
