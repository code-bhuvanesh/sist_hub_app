part of 'select_post_image_bloc.dart';

abstract class CreateNewPostEvent extends Equatable {
  const CreateNewPostEvent();

  @override
  List<Object> get props => [];
}

class GetAlbums extends CreateNewPostEvent {
  const GetAlbums();
}

class GetImagesFromAlbums extends CreateNewPostEvent {
  final Album album;
  const GetImagesFromAlbums({required this.album});
}

class CreateNewPost extends CreateNewPostEvent {
  final String postContent;
  final File?
      selectedImage; // for now just one image in future may be add an option for multiple images

  const CreateNewPost({
    required this.postContent,
    required this.selectedImage,
  });
}

class AddSelectedFile extends CreateNewPostEvent {
  final File selectedFile;

  const AddSelectedFile({required this.selectedFile});
}

class GetSelectedFile extends CreateNewPostEvent {}
