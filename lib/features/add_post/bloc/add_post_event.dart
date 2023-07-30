part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class AddPostToServer extends AddPostEvent {
  final String discription;
  final String? postType;
  final File file;

  const AddPostToServer({
    required this.discription,
    this.postType,
    required this.file,
  });
}
