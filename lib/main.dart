import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/login/add_posts/add_posts_screen.dart';
import 'package:sist_hub/features/main/main_screen.dart';
import 'package:sist_hub/features/settings/settings_screen.dart';
import 'package:sist_hub/features/splahScreen/splash_screen.dart';
import 'package:sist_hub/styles/styles.dart';
import 'package:sist_hub/transitions/page_transisition.dart';

import 'features/login/login_screen.dart';
import 'features/auth/bloc/auth_bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.background,
      systemNavigationBarColor: AppColors.background,
    ),
  );
  runApp(BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIST HUB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: false,
      ),
      initialRoute: SplashScreen.routename,
      onGenerateRoute: routes,
      // routes: {
      //   SplashScreen.routename: (context) => const SplashScreen(),
      //   MainScreen.routeName: (context) => const MainScreen(),
      //   LoginScreen.routeName: (context) => BlocProvider(
      //         create: (context) =>
      //             LoginBloc(authBloc: context.read<AuthBloc>()),
      //         child: const LoginScreen(),
      //       ),
      //   SettingScreen.routename: (context) => const SettingScreen(),
      //   AddPostsScreen.routename:(context) => SlideUpPageTransistion(newPage)
      // },
    );
  }

  Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routename:
        return pageTransition(const SplashScreen());
      case MainScreen.routeName:
        return pageTransition(const MainScreen());
      case LoginScreen.routeName:
        return pageTransition(const LoginScreen());
      case SettingScreen.routename:
        return pageTransition(const SettingScreen());
      case AddPostsScreen.routename:
        return SlideUpPageTransistion(const AddPostsScreen());
    }
    return pageTransition(const SplashScreen());
  }
}
