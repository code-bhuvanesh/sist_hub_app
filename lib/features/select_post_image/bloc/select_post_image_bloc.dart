import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

part 'select_post_image_event.dart';
part 'select_post_image_state.dart';

class SelectPostImageBloc
    extends Bloc<SelectPostImageEvent, SelectPostImageState> {
  SelectPostImageBloc() : super(AddPostsInitial()) {
    on<GetAlbums>(getAlbums);
    on<GetImagesFromAlbums>(getImagesFromAlbums);
  }

  Future<FutureOr<void>> getAlbums(
      GetAlbums event, Emitter<SelectPostImageState> emit) async {
    List<Album> albums = await PhotoGallery.listAlbums(newest: true);

    albums = albums.where((element) => element.name != null).toList();
    emit(AlbumsLoaded(albums: albums));
    // _selectedValue = dropDownItems[0];
  }

  Future<FutureOr<void>> getImagesFromAlbums(
      GetImagesFromAlbums event, Emitter<SelectPostImageState> emit) async {
    List<Medium> mediums = (await event.album.listMedia()).items;
    emit(ImagesLoaded(mediums: mediums));
  }
}
