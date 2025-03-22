import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Push with animation
  static Future<T?> push<T>(Widget page) {
    if (navigatorKey.currentState == null) return Future.value(null);
    return navigatorKey.currentState!.push<T>(_createRoute<T>(page));
  }

  // Replace with animation
  static Future<T?> pushReplacement<T>(Widget page) {
    if (navigatorKey.currentState == null) return Future.value(null);
    return navigatorKey.currentState!.pushReplacement<T, void>(_createRoute<T>(page));
  }

  // Pop current screen
  static void pop<T>([T? result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState!.pop(result);
    }
  }

  // Pop until a specific condition is met
  static void popUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState?.popUntil(predicate);
  }

  // Custom page route with animation
  static PageRouteBuilder<T> _createRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
