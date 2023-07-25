import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/features/auth/bloc/auth_bloc.dart';

import '../../styles/styles.dart';
import '../login/login_screen.dart';

class SettingScreen extends StatefulWidget {
  static var routename = "/settings";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (authContext, state) {
          if (state is UnAuthenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName, (route) => false);
          }
        },
        child: Center(
            child: logoutButton("logout", onPressed: () {
          context.read<AuthBloc>().add(AuthLogout());
        })),
      ),
    );
  }

  logoutButton(String text, {required void Function() onPressed}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              foregroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.black),
              shape:
                  RoundedRectangleBorder(borderRadius: AppSizes.circleBorder)),
          child: Text(" $text "),
        ),
      ),
    );
  }
}
