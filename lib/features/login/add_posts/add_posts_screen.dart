import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../styles/styles.dart';

class AddPostsScreen extends StatefulWidget {
  static const routename = "/addposts";
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Post",
          style: AppTextStyles.titleTextStyle,
        ),
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
          color: Colors.white,
          child: Center(child: const Text("return back")),
        ),
      ),
    );
  }
}
