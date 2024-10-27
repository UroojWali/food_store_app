import 'package:flutter/material.dart';

class RouteTransition {
  /// fade page route builder
  static Route<dynamic> fadePageRouteBuilder(Widget screen) {
    return PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return screen;
      },
    );
  }

  /// slide page route builder
  static Route<dynamic> slidePageRouteBuilder(Widget screen) {
    return PageRouteBuilder(
      barrierDismissible: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return screen;
      },
    );
  }

  /// page route builder
  static Route<dynamic> pageRouteBuilder(Widget screen) {
    return PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return screen;
      },
    );
  }
}
