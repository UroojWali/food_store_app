part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

final class SignupNameChanged extends SignupEvent {
  const SignupNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

final class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);
  final String password;
  @override
  List<Object> get props => [password];
}

final class SignupPasswordVisibilityChanged extends SignupEvent {
  const SignupPasswordVisibilityChanged();
  @override
  List<Object> get props => [];
}

final class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
