part of 'signup_form.dart';

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    // final displayError = context.select(
    //   (SignupBloc bloc) => bloc.state.password.displayError,
    // );

    // final passwordHidden = context.select(
    //   (SignupBloc bloc) => bloc.state.passwordHidden,
    // );
    // logger.d(displayError);
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        // logger.d("Password build" + state.password.displayError.toString());
        return TextFormField(
          obscureText: state.passwordHidden,
          decoration: InputDecoration(
            prefixIcon: const Icon(EvaIcons.lock_outline),
            suffixIcon: IconButton(
              icon: state.passwordHidden
                  ? const Icon(EvaIcons.eye_off_outline)
                  : const Icon(EvaIcons.eye_outline),
              onPressed: () {
                // logger.d(passwordHidden);
                context.read<SignupBloc>().add(
                      const SignupPasswordVisibilityChanged(),
                    );
              },
            ),
            hintText: '•••••••••••',
            labelText: 'Password',
            errorText: state.password.displayError?.name.split("_").join(" "),
            fillColor: Colors.transparent,
          ),
          onChanged: (password) {
            context.read<SignupBloc>().add(SignupPasswordChanged(password));
          },
        );
      },
    );
  }
}
