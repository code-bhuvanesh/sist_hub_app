part of 'select_post_image_bloc.dart';

abstract class SelectPostImageEvent extends Equatable {
  const SelectPostImageEvent();

  @override
  List<Object> get props => [];
}

class GetAlbums extends SelectPostImageEvent {
  const GetAlbums();
}

class GetImagesFromAlbums extends SelectPostImageEvent {
  final Album album;
  const GetImagesFromAlbums({required this.album});
}
