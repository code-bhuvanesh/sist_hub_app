import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/styles/styles.dart';
import '../select_post_image/select_post_image.dart';
import '../auth/bloc/auth_bloc.dart';
import '../home/bloc/home_bloc.dart';
import '../home/home_screen.dart';
import '../settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = "/mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var systemOverlayStyle = const SystemUiOverlayStyle(
    // statusBarIconBrightness: Brightness.dark,
    statusBarColor: AppColors.background,
    // statusBarBrightness: Brightness.light
    // systemNavigationBarColor: AppColors.background,
  );
  int postionIndex = 0;
  @override
  void initState() {
    super.initState();
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
              Expanded(
                child: Column(
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
              ),
              Expanded(
                child: Column(
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
                ),
              )
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) {
          Scaffold.of(context).openDrawer();
          return HomeBloc();
        },
        child: Builder(builder: (context) {
          return IndexedStack(
            index: postionIndex,
            children: [
              HomeScreen(
                mainScreenContext: context,
              ),
              HomeScreen(
                mainScreenContext: context,
              ),
              HomeScreen(
                mainScreenContext: context,
              ),
              HomeScreen(
                mainScreenContext: context,
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 2) {
            Navigator.of(context).pushNamed(SelectPostImageScreen.routename);
            value = postionIndex;
          }
          setState(() {
            postionIndex = value;
          });
        },
        enableFeedback: true,
        useLegacyColorScheme: true,
        elevation: 1005,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        currentIndex: postionIndex,
        showSelectedLabels: false,
        items: [
          navigationBarItem(
            label: "home",
            is2Icons: true,
          ),
          navigationBarItem(label: "search"),
          navigationBarItem(label: "add_post"),
          navigationBarItem(label: "notification", is2Icons: true),
        ],
      ),
    );
  }

  navigationBarItem({required String label, is2Icons = false}) {
    return BottomNavigationBarItem(
      label: label,
      icon: ImageIcon(
        AssetImage("assets/icons/${label}_icon.png"),
        color: Colors.grey,
      ),
      activeIcon: is2Icons
          ? ImageIcon(
              AssetImage("assets/icons/${label}_icon_filled.png"),
              color: Colors.black,
            )
          : ImageIcon(
              AssetImage("assets/icons/${label}_icon.png"),
              color: Colors.black,
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
}
