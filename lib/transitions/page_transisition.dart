import 'package:flutter/material.dart';

Route slideFromDownPageTransistion(Widget newPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => newPage,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var beginOffset = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween =
          Tween(begin: beginOffset, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route slideFromSidePageTransistion(Widget newPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => newPage,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var beginOffset = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween =
          Tween(begin: beginOffset, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route pageTransition(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
  );
}
