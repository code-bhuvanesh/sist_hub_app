import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:sist_hub/common/post_image_viewer.dart';

import '../../../styles/styles.dart';
import '../add_post_page/add_post_screen.dart';
import '../permissions/bloc/permission_bloc.dart';
import 'bloc/select_post_image_bloc.dart';

class SelectPostImageScreen extends StatefulWidget {
  const SelectPostImageScreen({super.key});

  static const routename = "/selectpostimagescreen";

  @override
  State<SelectPostImageScreen> createState() => _SelectPostImageScreenState();
}

class _SelectPostImageScreenState extends State<SelectPostImageScreen> {
  List<Album> _dropDownItems = [];
  List<Medium> _media = [];
  Album? _selectedValue;
  int _selectedImage = 0;

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
      ),
    );
    super.dispose();
  }

  @override
  void initState() {
    print("add posts screen init");
    context.read<PermissionBloc>().add(GetAllPermissions());
    // getAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Post",
          style: AppTextStyles.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddPostScreen.routename,
                arguments: _media[_selectedImage],
              );
            },
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => AppColors.blue)),
            child: const Text(
              "Next",
              style: AppTextStyles.postTittleText,
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
      ),
      body: BlocListener<PermissionBloc, PermissionState>(
        listener: (_, state) {
          print("...........................................");
          if (state is PermissionGranted) {
            context.read<SelectPostImageBloc>().add(const GetAlbums());
          }
        },
        child: BlocBuilder<SelectPostImageBloc, SelectPostImageState>(
          builder: (context, state) {
            if (state is AlbumsLoaded) {
              _dropDownItems = state.albums;
              _selectedValue = _dropDownItems[0];
              context.read<SelectPostImageBloc>().add(
                    GetImagesFromAlbums(
                      album: _selectedValue!,
                    ),
                  );
            } else if (state is ImagesLoaded) {
              _media = state.mediums;
            }

            return SafeArea(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    if (_media.isNotEmpty)
                      Expanded(
                        child: PostImageViewer(
                          image: _media[_selectedImage],
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: AppColors.background,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          width: w / 2.5,
                          child: DropdownButton(
                            // inputDecorationTheme: const InputDecorationTheme(
                            //   contentPadding: EdgeInsets.only(left: 20, right: 10),
                            //   border: InputBorder.none,
                            // ),
                            underline: const SizedBox.shrink(),
                            elevation: 0,
                            menuMaxHeight: 300,
                            enableFeedback: true,
                            value: _selectedValue,
                            items: _dropDownItems
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: SizedBox(
                                          width: w / 3.5,
                                          child: Text(
                                            e.name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                                context.read<SelectPostImageBloc>().add(
                                    GetImagesFromAlbums(
                                        album: _selectedValue!));
                              });
                            },
                          ),
                        )
                      ]),
                    ),
                    Expanded(
                      child: GridView.builder(
                        // padding: const EdgeInsets.only(top: 10),
                        itemCount: _media.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        itemBuilder: (context, index) {
                          var medium = _media[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImage = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ClipRRect(
                                borderRadius: AppSizes.border8,
                                child: Container(
                                  color: AppColors.background,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: ThumbnailProvider(
                                      mediumId: medium.id,
                                      mediumType: medium.mediumType,
                                      highQuality: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
