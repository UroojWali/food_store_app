import 'package:flutter/material.dart';
import 'package:food_store/routes/route_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static Route<dynamic> route() {
    return RouteTransition.pageRouteBuilder(
      const SplashPage(),
    );
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Page'),
      ),
    );
  }
}
