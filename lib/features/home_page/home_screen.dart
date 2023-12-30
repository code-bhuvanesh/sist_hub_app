// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sist_hub/features/auth/bloc/auth_bloc.dart';
import 'package:sist_hub/features/chats_page/all_chats_page.dart';
import 'package:sist_hub/features/home_page/widgets/pull_to_refresh.dart';
import 'package:sist_hub/styles/styles.dart';

import '../login_page/login_screen.dart';
import 'bloc/home_bloc.dart';
import 'widgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
  final BuildContext mainScreenContext;
  const HomeScreen({
    Key? key,
    required this.mainScreenContext,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var systemOverlayStyle = const SystemUiOverlayStyle(
    // statusBarIconBrightness: Brightness.dark,
    // statusBarColor: AppColors.background,
    // statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.postBorder,
  );
  var loadedPosts = [];
  int postionIndex = 0;
  var isLoadingPost = false;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadPosts());
  }

  void logout() {
    context.read<AuthBloc>().add(AuthLogout());
  }

  Future<void> onRefresh() async {
    context.read<HomeBloc>().add(LoadPosts());
    Future bloc = context.read<HomeBloc>().stream.first;
    return await bloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              systemOverlayStyle: systemOverlayStyle,
              backgroundColor: AppColors.background,
              leading: profileButton(),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AllChatsPage.routename),
                    // icon: const Icon(Icons.chat),
                    icon: Image.asset("assets/icons/chat_icon.png"),
                  ),
                ),
              ],
              title: const Text(
                "SIST HUB",
                style: AppTextStyles.logoTextStyle,
              ),
              foregroundColor: Colors.black,
              centerTitle: true,
              floating: true,
              snap: true,
              elevation: 0,
            ),
          ];
        },
        body: BlocListener<AuthBloc, AuthState>(
          listener: (authContext, state) {
            if (state is UnAuthenticated) {
              Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
            }
          },
          child: Container(
            color: AppColors.background,
            child: Center(
              child: BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is PostsLoaded) {
                    loadedPosts = state.posts;
                  }
                  if (state is PostsLoading) {
                    isLoadingPost = true;
                  } else {
                    isLoadingPost = false;
                  }
                },
                builder: (context, state) {
                  return Stack(
                    children: [
                      PullToRefresh(
                        onRefresh: onRefresh,
                        child: loadedPosts.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.all(5),
                                itemCount: loadedPosts.length,
                                itemBuilder: (context, index) => PostWidget(
                                  index: index + 1,
                                  post: loadedPosts[index],
                                  parentContext: context,
                                ),
                              )
                            : !isLoadingPost
                                ? Stack(
                                    children: [
                                      const Center(
                                        child: Text(
                                          "no posts avaliable",
                                          style:
                                              AppTextStyles.subTitleTextStyle,
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              MediaQuery.of(context)
                                                  .padding
                                                  .top -
                                              MediaQuery.of(context)
                                                  .padding
                                                  .bottom,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                      ),
                      if (isLoadingPost)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  profileButton() {
    return GestureDetector(
      onTap: () => Scaffold.of(widget.mainScreenContext).openDrawer(),
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
