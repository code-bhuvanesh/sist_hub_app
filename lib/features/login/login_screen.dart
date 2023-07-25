import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sist_hub/common/widgets/logo.dart';
import 'package:sist_hub/features/home/home_screen.dart';
import 'package:sist_hub/features/login/bloc/login_bloc.dart';
import 'package:sist_hub/styles/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static var routeName = "/loginscreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController =
      TextEditingController(text: "bhuvanesh41110296@sist.com");

  final _passwordTextController = TextEditingController(text: "1234");

  var isLoginLoading = false;

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top;
    // var h = MediaQuery.of(context).size.height;
    // var w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Container(
          height: double.infinity,
          color: AppColors.background,
          padding: EdgeInsets.only(top: topPadding),
          child: SingleChildScrollView(
            child: Column(children: [
              const LogoWidget(),
              greetingText(),
              emptySpace(15),
              loginTextField(
                  controller: _emailTextController, hintText: "Email"),
              loginTextField(
                  controller: _passwordTextController,
                  hintText: "Password",
                  isPassword: true),
              emptySpace(15),
              loginButton(
                "Login",
              ),
              BlocListener<LoginBloc, LoginState>(
                  listener: (loginContext, state) {
                    print("listener is : $state");
                    if (state is LoginLoading) {
                      setState(() {
                        isLoginLoading = true;
                      });
                    }
                    if (state is LoginSucessfull || state is LoginFailure) {
                      setState(() {
                        isLoginLoading = false;
                      });
                      Navigator.of(context)
                          .popAndPushNamed(HomeScreen.routeName);
                    }
                  },
                  child: Container()),
            ]),
          ),
        ),
        if (isLoginLoading)
          Container(
            color: const Color.fromARGB(36, 0, 0, 0),
            child: const Center(child: CircularProgressIndicator()),
          )
      ]),
    );
  }

  loginButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: ElevatedButton(
          onPressed: LoginButtonOnPressed,
          onLongPress: () => LoginButtonOnPressed(longPressed: true),
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

  greetingText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: const Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Welcome,",
              style: AppTextStyles.titleTextStyle,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "login to continue.",
              style: AppTextStyles.subTitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  emptySpace(double space) {
    return Padding(
      padding: EdgeInsets.only(top: space),
    );
  }

  bool _passwordNotVisible = true;
  loginTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputAction? inputType,
    bool isPassword = false,
  }) {
    var normalTextBoxDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
    var passwordTextBoxDecoration = InputDecoration(
      suffixIcon: IconButton(
        icon: _passwordNotVisible
            ? Icon(Icons.visibility_off_outlined)
            : Icon(Icons.visibility_outlined),
        onPressed: () {
          setState(() {
            _passwordNotVisible = !_passwordNotVisible;
          });
        },
      ),
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        obscureText: isPassword ? _passwordNotVisible : false,
        obscuringCharacter: '●',
        controller: controller,
        textInputAction: inputType,
        decoration:
            !isPassword ? normalTextBoxDecoration : passwordTextBoxDecoration,
      ),
    );
  }

  void LoginButtonOnPressed({bool longPressed = false}) {
    print("loginPressed");
    context.read<LoginBloc>().add(
          LoginButtonPressed(
              email: _emailTextController.text,
              password: _passwordTextController.text,
              longPressed: longPressed),
        );
  }
}
