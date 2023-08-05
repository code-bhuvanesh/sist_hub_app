// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sist_hub/data/model/post.dart';
import 'package:sist_hub/styles/styles.dart';

import '../../../data/model/user.dart';
import '../bloc/home_bloc.dart';

class CommentsBottomSheet extends StatefulWidget {
  final int postID;
  const CommentsBottomSheet({
    super.key,
    required this.postID,
  });

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  bool isLoading = false;
  List<PostComment> comments = [];
  @override
  void initState() {
    context.read<HomeBloc>().add(GetCommentsForPost(postId: widget.postID));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is CommentsLoading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is CommentsLoaded) {
          setState(() {
            isLoading = false;
            comments = state.comments;
          });
        }
      },
      child: ClipRRect(
        borderRadius: AppSizes.border15,
        child: Container(
          color: AppColors.postBorder,
          height: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "comments",
                  style: AppTextStyles.postTittleText,
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : comments.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return CommetWidget(
                                  comment: comments[0],
                                  user: OtherUser(
                                    email: "emil.com",
                                    token: "fsdfsdfs",
                                    username: "bhuvanesh",
                                    usertype: "student",
                                  ),
                                );
                              },
                              itemCount: 15, //comments.length,
                            )
                          : const Center(
                              child: Text("No Comments yet!"),
                            ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: AppSizes.border25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommetWidget extends StatelessWidget {
  final PostComment comment;
  final OtherUser user;
  const CommetWidget({
    Key? key,
    required this.comment,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: ClipRRect(
        borderRadius: AppSizes.border15,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          color: AppColors.background,
          child: Row(children: [
            profileButton(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.username,
                        style: AppTextStyles.commentTitle,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "5m ago",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  Text(
                    comment.comment,
                    style: AppTextStyles.commentSubTitle,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  profileButton() {
    return GestureDetector(
      child: Center(
        child: Container(
            padding: const EdgeInsets.only(left: 8),
            // width: 60.0,
            // height: 50.0,
            child: profilePic(size: 35)),
      ),
    );
  }

  profilePic({required double size}) {
    return ClipRRect(
      borderRadius: AppSizes.circleBorder,
      child: Container(
        height: size,
        width: size,
        color: Colors.grey[300],
        child: Image.asset(
          "assets/images/user_icon.png",
          color: Colors.black87,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
