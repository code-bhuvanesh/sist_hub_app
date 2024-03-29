import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/styles/styles.dart';

import '../../../data/model/post.dart';
import '../bloc/home_bloc.dart';
import 'comments_bottom_sheet.dart';
import 'custom_bootom_sheet.dart';

class PostWidget extends StatefulWidget {
  final int index;
  final Post post;
  final BuildContext parentContext;

  const PostWidget(
      {required this.index,
      super.key,
      required this.post,
      required this.parentContext});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool imageFullScreen = true;
  bool isHeightisBigger = true;

  void likePost() {
    context.read<HomeBloc>().add(LikeOrUnlikePost(postId: widget.post.id));
    setState(() {
      widget.post.userLiked = !widget.post.userLiked;
      if (widget.post.userLiked) {
        widget.post.likes += 1;
      } else {
        widget.post.likes -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // double postViewMinHeight = h / 3;
    double postViewMinHeight = 50;
    double postViewMaxHeight = h / 1.8;
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 3,
          color: AppColors.postBorder,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...postTop(),
              Container(
                width: double.infinity,
                // height: postViewMinHeight,
                constraints: BoxConstraints(
                  minHeight: postViewMinHeight,
                  // maxHeight: postViewMaxHeight,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            widget.post.description,
                            style: AppTextStyles.postTextStyle,
                          ),
                        ),
                      ),
                      if (widget.post.postimg.isNotEmpty)
                        ClipRRect(
                          borderRadius: AppSizes.border10,
                          child: Container(
                            width: w / 1.3,
                            constraints: BoxConstraints(
                              maxHeight: postViewMaxHeight / 1.2,
                            ),
                            child: GestureDetector(
                              onTap: () => setState(() {
                                imageFullScreen = !imageFullScreen;
                              }),
                              child: CachedNetworkImage(
                                imageUrl: widget.post.postimg,
                                // fit: imageFullScreen ? BoxFit.fill : BoxFit.contain,

                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) => Center(
                                  child: Column(
                                    children: [
                                      const Icon(Icons.error),
                                      Text(error.toString())
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              ...postBottom(),
            ],
          ),
        ),
      ),
    );
  }

  postTop() {
    return [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            postUserInfo(),
            Center(
              child: SizedBox(
                width: 50,
                height: 30,
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text(
                    "●●●",
                    style: TextStyle(fontSize: 13),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
      const Divider(color: AppColors.postBackgound),
    ];
  }

  postUserInfo() {
    return Row(children: [
      const CircleAvatar(
        foregroundImage: AssetImage("assets/dummy/hack_sist_logo.jpeg"),
      ),
      const SizedBox(width: 10),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.post.username, style: AppTextStyles.postTittleText),
          Text(widget.post.postType, style: AppTextStyles.postSubTittleText),
        ],
      ),
    ]);
  }

  postBottom() {
    return [
      const Divider(color: AppColors.postBackgound),
      BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is CommentAdded) {
            setState(() {
              widget.post.comments += 1;
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: likePost,
                child: ClipRRect(
                  borderRadius: AppSizes.circleBorder,
                  child: Container(
                    width: 80,
                    color: AppColors.background,
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        widget.post.userLiked
                            ? const ImageIcon(
                                AssetImage("assets/icons/like_icon.png"),
                                color: Colors.red,
                              )
                            : const ImageIcon(
                                AssetImage("assets/icons/unlike_icon.png"),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.post.likes.toString()),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppSizes.commentTopSideBorder,
                    ),
                    backgroundColor: AppColors.postBorder,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: BlocProvider(
                          create: (context) => HomeBloc(),
                          child: CustomBottomSheet(
                            child: CommentsBottomSheet(postID: widget.post.id),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: AppSizes.circleBorder,
                  child: Container(
                    width: 80,
                    color: AppColors.background,
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        const ImageIcon(
                            AssetImage("assets/icons/comment_icon.png")),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.post.comments.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ];
  }
}
