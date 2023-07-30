import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/auth/bloc/auth_bloc.dart';

import '../login_page/login_screen.dart';
import '../main_page/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routename = "splashScreen";

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AppStarted());
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).popAndPushNamed(MainScreen.routeName);
          } else {
            Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
          }
        },
        child: const Center(
            // child: LogoWidget(),
            ),
      ),
    );
  }
}
