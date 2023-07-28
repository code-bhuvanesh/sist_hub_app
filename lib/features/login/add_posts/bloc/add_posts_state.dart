part of 'add_posts_bloc.dart';

abstract class AddPostsState extends Equatable {
  const AddPostsState();
  
  @override
  List<Object> get props => [];
}

class AddPostsInitial extends AddPostsState {}
