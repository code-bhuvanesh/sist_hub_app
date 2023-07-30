part of 'select_post_image_bloc.dart';

abstract class SelectPostImageState extends Equatable {
  const SelectPostImageState();

  @override
  List<Object> get props => [];
}

class AddPostsInitial extends SelectPostImageState {}

class AlbumsLoaded extends SelectPostImageState {
  final List<Album> albums;

  const AlbumsLoaded({required this.albums});
}

class ImagesLoaded extends SelectPostImageState {
  final List<Medium> mediums;

  const ImagesLoaded({required this.mediums});
}
