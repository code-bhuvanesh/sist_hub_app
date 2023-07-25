import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/settings/settings_screen.dart';
import 'package:sist_hub/features/splahScreen/splash_screen.dart';
import 'package:sist_hub/styles/styles.dart';

import 'features/login/bloc/login_bloc.dart';
import 'features/login/login_screen.dart';
import 'features/home/home_screen.dart';
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
      routes: {
        SplashScreen.routename: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => BlocProvider(
              create: (context) =>
                  LoginBloc(authBloc: context.read<AuthBloc>()),
              child: const LoginScreen(),
            ),
        SettingScreen.routename: (context) => const SettingScreen(),
      },
    );
  }
}
