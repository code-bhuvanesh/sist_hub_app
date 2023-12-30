import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:sist_hub/features/bus_page/find_bus_screen.dart';
import 'package:sist_hub/features/chats_page/bloc/chats_bloc.dart';
import 'package:sist_hub/features/chats_page/all_chats_page.dart';
import 'package:sist_hub/features/chats_page/chats_page.dart';
import 'package:sist_hub/features/create_new_post_page/create_post_page.dart';
import 'package:sist_hub/features/profile_page/profile_page.dart';
import 'package:sist_hub/features/search_page/search_result_screen.dart';

import 'features/add_post_page/add_post_screen.dart';
import 'features/add_post_page/bloc/add_post_bloc.dart';
import 'features/create_new_post_page/bloc/select_post_image_bloc.dart';
import 'features/create_new_post_page/select_post_image.dart';
import 'features/login_page/bloc/login_bloc.dart';
import 'features/login_page/login_screen.dart';
import 'features/main_page/main_screen.dart';
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
      BlocProvider<CreateNewPostBloc>(
        create: (_) => CreateNewPostBloc(),
      )
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
      case ProfilePage.routename:
        return pageTransition(
          ProfilePage(
            userId: settings.arguments as int,
          ),
        );
      case SettingScreen.routename:
        return pageTransition(const SettingScreen());
      case SelectPostImageScreen.routename:
        return slideFromDownPageTransistion(
          const SelectPostImageScreen(),
        );
      case CreatePostPage.routename:
        return pageTransition(
          const CreatePostPage(),
        );
      case AddPostScreen.routename:
        return slideFromSidePageTransistion(
          BlocProvider(
            create: (context) => AddPostBloc(),
            child: AddPostScreen(
              postImage: settings.arguments as Medium,
            ),
          ),
        );
      case SearchResultScreen.routename:
        return slideFromSidePageTransistion(
          BlocProvider(
            create: (context) => AddPostBloc(),
            child: SearchResultScreen(
              searchText: settings.arguments as String,
            ),
          ),
        );
      case AllChatsPage.routename:
        return slideFromSidePageTransistion(
          BlocProvider(
            create: (context) => ChatsBloc(),
            child: const AllChatsPage(),
          ),
        );
      case chatsPage.routename:
        return slideFromSidePageTransistion(
          BlocProvider(
            create: (context) => ChatsBloc(),
            child: chatsPage(
              userid: (settings.arguments as List)[0] as int,
              username: (settings.arguments as List)[1] as String,
            ),
          ),
        );
      case FindBusScreen.routename:
        return slideFromSidePageTransistion(
          const FindBusScreen(),
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
