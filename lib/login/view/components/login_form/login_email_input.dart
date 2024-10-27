part of 'login_form.dart';

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    // final displayError = context.select(
    //   (LoginBloc bloc) => bloc.state.email.displayError,
    // );

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // logger.d("Email build" + state.email.displayError.toString());
        return TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(EvaIcons.email_outline),
            hintText: 'example@gmail.com',
            labelText: 'Email',
            errorText: state.email.displayError?.name.split("_").join(" "),
            fillColor: Colors.transparent,
          ),
          onChanged: (email) {
            context.read<LoginBloc>().add(LoginEmailChanged(email));
          },
        );
      },
    );
  }
}
