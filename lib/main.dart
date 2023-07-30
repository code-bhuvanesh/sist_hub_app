import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

import 'features/add_post_page/add_post_screen.dart';
import 'features/add_post_page/bloc/add_post_bloc.dart';
import 'features/login_page/bloc/login_bloc.dart';
import 'features/login_page/login_screen.dart';
import 'features/main_page/main_screen.dart';
import 'features/select_post_image_page/bloc/select_post_image_bloc.dart';
import 'features/select_post_image_page/select_post_image.dart';
import 'styles/styles.dart';
import 'transitions/page_transisition.dart';
import 'features/permissions/bloc/permission_bloc.dart';
import 'features/settings_page/settings_screen.dart';
import 'features/splahScreen_page/splash_screen.dart';
import 'features/auth/bloc/auth_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.background,
      systemNavigationBarColor: AppColors.background,
    ),
  );
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(),
      ),
      BlocProvider<PermissionBloc>(
        create: (_) => PermissionBloc(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routename:
        return pageTransition(const SplashScreen());
      case MainScreen.routeName:
        return pageTransition(const MainScreen());
      case LoginScreen.routeName:
        return pageTransition(
          BlocProvider(
            create: (context) => LoginBloc(
              authBloc: context.read<AuthBloc>(),
            ),
            child: const LoginScreen(),
          ),
        );
      case SettingScreen.routename:
        return pageTransition(const SettingScreen());
      case SelectPostImageScreen.routename:
        return slideFromDownPageTransistion(
          BlocProvider(
            create: (context) => SelectPostImageBloc(),
            child: const SelectPostImageScreen(),
          ),
        );
      case AddPostScreen.routename:
        return slideFromSidePageTransistion(
          BlocProvider(
            create: (context) => AddPostBloc(),
            child: AddPostScreen(postImage: settings.arguments as Medium),
          ),
        );
    }
    return pageTransition(const SplashScreen());
  }

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
}
