import 'package:flutter/material.dart';
import 'package:sist_hub/styles/styles.dart';

class PostWidget extends StatelessWidget {
  final int index;

  const PostWidget({
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double postViewMinHeight = h / 2.7;
    double postViewMaxHeight = h / 2;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        color: AppColors.postBorder,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            postTop(),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: postViewMinHeight,
                maxHeight: postViewMaxHeight,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              child: Card(
                elevation: 2,
                color: AppColors.postBackgound,
                shape: RoundedRectangleBorder(
                  borderRadius: AppSizes.border15,
                ),
                child: ClipRRect(
                  borderRadius: AppSizes.border15,
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      // "https://www.technosummit.in/static/media/poster.4ae2e49b660356619f9e.jpeg",
                      "assets/dummy/workshop_$index.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            postBottom(),
          ],
        ),
      ),
    );
  }
}

postTop() {
  return Container(
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
  );
}

postUserInfo() {
  return const Row(children: [
    CircleAvatar(
      foregroundImage: AssetImage("assets/dummy/hack_sist_logo.jpeg"),
    ),
    SizedBox(width: 10),
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hack SIST", style: AppTextStyles.postTittleText),
        Text("workshop", style: AppTextStyles.postSubTittleText),
      ],
    ),
  ]);
}

postBottom() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: AppSizes.circleBorder,
          child: Container(
            color: Colors.white70,
            margin: const EdgeInsets.symmetric(vertical: 1),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Row(
              children: [
                ImageIcon(AssetImage("assets/icons/like_icon.png")),
                SizedBox(
                  width: 5,
                ),
                Text("100"),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ClipRRect(
          borderRadius: AppSizes.circleBorder,
          child: Container(
            color: Colors.white70,
            margin: const EdgeInsets.symmetric(vertical: 1),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Row(
              children: [
                ImageIcon(AssetImage("assets/icons/comment_icon.png")),
                SizedBox(
                  width: 5,
                ),
                Text("100"),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
