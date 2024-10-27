part of 'signup_form.dart';

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(EvaIcons.email_outline),
            hintText: 'example@gmail.com',
            labelText: 'Email',
            errorText: state.email.displayError?.name.split("_").join(" "),
            fillColor: Colors.transparent,
          ),
          onChanged: (email) {
            context.read<SignupBloc>().add(SignupEmailChanged(email));
          },
        );
      },
    );
  }
}
