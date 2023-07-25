import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/auth/bloc/auth_bloc.dart';
import 'package:sist_hub/features/home/home_screen.dart';
import 'package:sist_hub/features/login/login_screen.dart';

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
            Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
          } else {
            Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
          }
        },
        child: Container(
          child: const Center(
              // child: LogoWidget(),
              ),
        ),
      ),
    );
  }
}
