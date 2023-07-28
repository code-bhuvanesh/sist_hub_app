import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/auth/bloc/auth_bloc.dart';
import 'package:sist_hub/features/home/bloc/home_bloc.dart';
import 'package:sist_hub/features/login/add_posts/add_posts_screen.dart';
import 'package:sist_hub/styles/styles.dart';

import '../home/home_screen.dart';

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
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: IndexedStack(
          index: postionIndex,
          children: const [
            HomeScreen(),
            HomeScreen(),
            HomeScreen(),
            HomeScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value == 2) {
            Navigator.of(context).pushNamed(AddPostsScreen.routename);
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
}
