import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/create_new_post_page/bloc/select_post_image_bloc.dart';
import 'package:sist_hub/features/create_new_post_page/select_post_image.dart';
import 'package:sist_hub/utils/utils.dart';

import '../../styles/styles.dart';

class CreatePostPage extends StatefulWidget {
  static const routename = "/createpostpage";
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final postContentController = TextEditingController();
  File? selectedFile;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateNewPostBloc, CreateNewPostState>(
      listener: (context, state) {
        if (state is PostsAddedSucessfully) {
          showToast(msg: "post added sucessfully");
          if (mounted) {
            Navigator.of(context).pop();
          }
        } else if (state is PostsAddedUnsucessful) {
          showToast(msg: "error adding post");
        }

        if (state is SelectedFileState) {
          setState(() {
            selectedFile = state.selectedFile;
          });
        }
      },
      child: Scaffold(
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
              onPressed: () async {
                context.read<CreateNewPostBloc>().add(
                      CreateNewPost(
                        postContent: postContentController.text,
                        selectedImage: selectedFile,
                      ),
                    );
              },
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => AppColors.blue),
              ),
              child: const Text(
                "post",
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
        body: SafeArea(
          child: Container(
            height: double.infinity,
            margin: const EdgeInsets.all(7),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 3),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: postContentController,
                    decoration: const InputDecoration(
                        hintText: "enter some text...",
                        // fillColor: Colors.red,
                        // filled: true,6
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none),
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                  if (selectedFile != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: AppSizes.border10,
                        child: Container(child: Image.file(selectedFile!)),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () async {
            await Navigator.of(context)
                .pushNamed(SelectPostImageScreen.routename);
            if (mounted) {
              context.read<CreateNewPostBloc>().add(GetSelectedFile());
            }
          },
          child: const Icon(
            Icons.photo,
          ),
        ),
      ),
    );
  }
}
