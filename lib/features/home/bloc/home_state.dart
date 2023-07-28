part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class PostsLoading extends HomeState{}

class PostsLoaded extends HomeState {
  final List<Post> posts;

  const PostsLoaded({required this.posts});

}
