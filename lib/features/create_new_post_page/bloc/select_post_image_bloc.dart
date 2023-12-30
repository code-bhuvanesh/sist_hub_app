import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../../data/repository/posts_repository.dart';

part 'select_post_image_event.dart';
part 'select_post_image_state.dart';

class CreateNewPostBloc extends Bloc<CreateNewPostEvent, CreateNewPostState> {
  File? selectedFile;

  CreateNewPostBloc() : super(AddPostsInitial()) {
    on<GetAlbums>(getAlbums);
    on<GetImagesFromAlbums>(getImagesFromAlbums);
    on<CreateNewPost>(createNewPost);
    on<AddSelectedFile>(addSelectedFile);
    on<GetSelectedFile>(getSelectedFile);
  }

  Future<FutureOr<void>> getAlbums(
      GetAlbums event, Emitter<CreateNewPostState> emit) async {
    List<Album> albums = await PhotoGallery.listAlbums(newest: true);

    albums = albums.where((element) => element.name != null).toList();
    emit(AlbumsLoaded(albums: albums));
    // _selectedValue = dropDownItems[0];
  }

  Future<FutureOr<void>> getImagesFromAlbums(
      GetImagesFromAlbums event, Emitter<CreateNewPostState> emit) async {
    List<Medium> mediums = (await event.album.listMedia()).items;
    emit(ImagesLoaded(mediums: mediums));
  }

  Future<FutureOr<void>> createNewPost(
      CreateNewPost event, Emitter<CreateNewPostState> emit) async {
    var response = await PostsRepository().sharePost(
      postContent: event.postContent,
      file: event.selectedImage,
    );
    if (response["statuscode"] == 200) {
      emit(PostsAddedSucessfully());
    } else {
      emit(PostsAddedUnsucessful());
    }
  }

  FutureOr<void> addSelectedFile(
    AddSelectedFile event,
    Emitter<CreateNewPostState> emit,
  ) {
    selectedFile = event.selectedFile;
    if (selectedFile != null) {
      emit(SelectedFileState(selectedFile: event.selectedFile));
      emit(ChangeState()); //for now afterwards change it with equatable
    }
  }

  FutureOr<void> getSelectedFile(
    GetSelectedFile event,
    Emitter<CreateNewPostState> emit,
  ) {
    if (selectedFile != null) {
      emit(SelectedFileState(selectedFile: selectedFile!));
      emit(ChangeState()); //for now afterwards change it with equatable
    }
  }
}
