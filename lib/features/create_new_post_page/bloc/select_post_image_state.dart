part of 'select_post_image_bloc.dart';

abstract class CreateNewPostState extends Equatable {
  const CreateNewPostState();

  @override
  List<Object> get props => [];
}

class AddPostsInitial extends CreateNewPostState {}

class AlbumsLoaded extends CreateNewPostState {
  final List<Album> albums;

  const AlbumsLoaded({required this.albums});
}

class ImagesLoaded extends CreateNewPostState {
  final List<Medium> mediums;

  const ImagesLoaded({required this.mediums});
}

class PostsAddedSucessfully extends CreateNewPostState {}

class PostsAddedUnsucessful extends CreateNewPostState {}

class SelectedFileState extends CreateNewPostState {
  final File selectedFile;

  const SelectedFileState({required this.selectedFile});
}

class ChangeState extends CreateNewPostState {} //for now afterwards change it with equatable