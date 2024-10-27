import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/components/button/action_button.dart';
import 'package:food_store/l10n/l10n.dart';
import 'package:food_store/login/login.dart';
import 'package:food_store/utilities/helpers/gap.dart';
import 'package:food_store/utilities/helpers/snackbar_helper.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';

part 'login_email_input.dart';
part 'login_password_input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBarHelper.errorSnackBar(
                  Colors.red.shade600, state.errorMessage!),
            );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: state.status.isInProgress,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1d102d),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        l10n.login,
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    vGap(30),
                    const _EmailInput(),
                    vGap(20),
                    const _PasswordInput(),
                    vGap(20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // logger.d('Forgot Password!');
                        },
                        child: Text(l10n.forgotPassword),
                      ),
                    ),
                    vGap(30),
                    ActionBtn(
                      text: l10n.login,
                      onPressed: () {
                        // logger.d('Login Button Pressed!');
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (state.status.isInProgress)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                // width: 150.w,
                // height: 150.h,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
