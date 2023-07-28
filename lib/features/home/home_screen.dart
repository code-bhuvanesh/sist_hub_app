import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/auth/bloc/auth_bloc.dart';
import 'package:sist_hub/features/home/bloc/home_bloc.dart';
import 'package:sist_hub/features/settings/settings_screen.dart';
import 'package:sist_hub/styles/styles.dart';
import 'package:sist_hub/utils/constants.dart';

import '../login/login_screen.dart';
import 'widgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
  int postionIndex = 0;
  @override
  void initState() {
    super.initState();
    print("constants url ${CurrentUser.instance.url}");
    context.read<HomeBloc>().add(LoadPosts());
  }

  void logout() {
    context.read<AuthBloc>().add(AuthLogout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: AppColors.background,
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.only(
              //   topRight: Radius.circular(20),
              //   bottomRight: Radius.circular(20),
              // ),
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  drawerUserInfo(),
                  const Divider(height: 20, thickness: 1),
                  drawerTiles(
                    title: "Upcoming Events",
                    iconImgLoc: "assets/icons/upcoming_events_icon.png",
                  ),
                  drawerTiles(
                    title: "Calender",
                    iconImgLoc: "assets/icons/calender_icon.png",
                  ),
                  drawerTiles(
                    title: "Find your Bus",
                    iconImgLoc: "assets/icons/bus_icon.png",
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(
                    thickness: 1,
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(SettingScreen.routename),
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: drawerTiles(
                          title: "settings",
                          iconImgLoc: "assets/icons/settings_icon.png",
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              systemOverlayStyle: systemOverlayStyle,
              backgroundColor: AppColors.background,
              leading: profileButton(context),
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
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  var loadedPosts = [];
                  if (state is PostsLoaded) {
                    loadedPosts = state.posts;
                  }
                  if (state is PostsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Expanded(
                      child: loadedPosts.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: loadedPosts.length,
                              itemBuilder: (context, index) => PostWidget(
                                  index: index + 1, post: loadedPosts[index]),
                            )
                          : const Text(
                              "no posts avaliable",
                              style: AppTextStyles.subTitleTextStyle,
                            ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  drawerTiles({required String title, required String iconImgLoc}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: AppSizes.border15,
        ),
        elevation: 2,
        color: AppColors.postBorder,
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage(iconImgLoc),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: AppTextStyles.appDrawerTitleTextStyle,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  drawerUserInfo() {
    return DrawerHeader(
      child: Row(
        children: [
          profilePic(size: 80),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bhuvanesh",
                style: AppTextStyles.titleTextStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              ClipRRect(
                borderRadius: AppSizes.border15,
                child: Container(
                  color: AppColors.postBorder,
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 5,
                  ),
                  child: const Text("view profile"),
                ),
              ),
            ],
          )
        ],
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

  profileButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Center(
        child: Container(
            padding: const EdgeInsets.only(left: 8),
            // width: 60.0,
            // height: 50.0,
            child: profilePic(size: 35)),
      ),
    );
  }
}
