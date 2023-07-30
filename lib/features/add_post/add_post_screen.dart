import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:sist_hub/common/post_image_viewer.dart';
import 'package:sist_hub/features/add_post/bloc/add_post_bloc.dart';
import 'package:sist_hub/features/main/main_screen.dart';
import 'package:sist_hub/utils/utils.dart';

import '../../styles/styles.dart';

class AddPostScreen extends StatefulWidget {
  static const routename = "/addpostscreen";
  final Medium postImage;
  const AddPostScreen({super.key, required this.postImage});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _decription = TextEditingController();
  File? _uploadFile;

  @override
  void initState() {
    loadFile();
    super.initState();
  }

  void loadFile() async {
    _uploadFile = await widget.postImage.getFile();
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.black),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_uploadFile != null) {
                context.read<AddPostBloc>().add(AddPostToServer(
                      discription: _decription.text,
                      file: _uploadFile!,
                    ));
              } else {
                showToast(msg: "file is not selected!");
              }
            },
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => AppColors.blue)),
            child: const Text(
              "Post",
              style: AppTextStyles.postTittleText,
            ),
          )
        ],
      ),
      body: BlocListener<AddPostBloc, AddPostState>(
        listener: (_, state) {
          if (state is PostsAddedSucessfully) {
            showToast(msg: "sucessfully posted");
            Navigator.of(context).pushNamedAndRemoveUntil(
              MainScreen.routeName,
              (route) => false,
            );
          } else if (state is PostsAddedUnsucessful) {
            showToast(msg: "error adding posts");
          }
        },
        child: Container(
          color: AppColors.postBorder,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PostImageViewer(
                  image: widget.postImage,
                ),
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: AppSizes.border15,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: AppColors.background,
                            child: TextField(
                              controller: _decription,
                              maxLength: 100,
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "write description here",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
