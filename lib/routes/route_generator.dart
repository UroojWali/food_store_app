import 'package:flutter/material.dart';
import 'package:food_store/authentication/bloc/authentication_bloc.dart';
import 'package:food_store/home/home.dart';
import 'package:food_store/login/view/login_page.dart';
import 'package:food_store/restaurant/model/restaurant.dart';
import 'package:food_store/restaurant/model/restaurant_food.dart';
import 'package:food_store/restaurant/view/restaurant_food_page.dart';
import 'package:food_store/restaurant/view/restaurant_page.dart';
import 'package:food_store/routes/route_path.dart';
import 'package:food_store/routes/route_transition.dart';
import 'package:food_store/signup/view/signup_page.dart';
import 'package:food_store/splash/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesGenerator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case RoutePath.splash:
          return SplashPage.route();

        // case RoutePath.onboarding:
        //   return RouteTransition.pageRouteBuilder(const OnboardingScreen());

        case RoutePath.login:
          return LoginPage.route();

        case RoutePath.signup:
          return SignupPage.route();

        case RoutePath.home:
          return Homepage.route();

        case RoutePath.restaurant:
          final restaurant = settings.arguments as Restaurant;
          return RestaurantPage.route(restaurant);

        case RoutePath.restaurantFood:
          final food = settings.arguments as RestaurantFood;
          return RestaurantFoodPage.route(food);

        default:
          return RouteTransition.pageRouteBuilder(const NotFoundScreen());
      }
    } catch (e) {
      return RouteTransition.pageRouteBuilder(
        ErrorScreen(message: e.toString()),
      );
    }
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Error found',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Text(
              'Error message: $message',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Page not found',
              style: TextStyle(color: Colors.black),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutPressed());
              },
              child: const Text('Clear User Data'),
            ),
          ],
        ),
      ),
    );
  }
}
