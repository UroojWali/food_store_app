import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/authentication/repository/authentication_repository.dart';
import 'package:food_store/components/background/top_left_background.dart';
import 'package:food_store/contants/image_contants.dart';
import 'package:food_store/l10n/l10n.dart';
import 'package:food_store/login/login.dart';
import 'package:food_store/login/view/components/login_form/login_form.dart';
import 'package:food_store/routes/route_path.dart';
import 'package:food_store/routes/route_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_store/user/repository/user_repository.dart';
import 'package:food_store/utilities/helpers/gap.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<dynamic> route() {
    return RouteTransition.pageRouteBuilder(
      const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.black,
      body: TopLeftBackground(
        child: BlocProvider(
          create: (context) => LoginBloc(
            userRepository: context.read<UserRepository>(),
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  vGap(30),
                  Image.asset(ImageContants.logo),
                  vGap(20),
                  Text(
                    l10n.loginPageHeadline,
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  vGap(20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: const LoginForm(),
                  ),
                  vGap(20),
                  Text(l10n.dontHaveAnAccount),
                  vGap(10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutePath.signup,
                        (route) => false,
                      );
                    },
                    child: Text(l10n.register),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
