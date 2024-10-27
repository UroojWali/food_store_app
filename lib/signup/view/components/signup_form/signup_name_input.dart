part of 'signup_form.dart';

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(EvaIcons.person_outline),
            hintText: 'John Doe',
            labelText: 'Name',
            errorText: state.name.displayError?.name.split("_").join(" "),
            fillColor: Colors.transparent,
          ),
          onChanged: (name) {
            context.read<SignupBloc>().add(SignupNameChanged(name));
          },
        );
      },
    );
  }
}
