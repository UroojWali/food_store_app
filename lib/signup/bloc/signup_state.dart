part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.status = FormzSubmissionStatus.initial,
    this.name = const SignupName.pure(),
    this.email = const SignupEmail.pure(),
    this.password = const SignupPassword.pure(),
    this.isValid = false,
    this.passwordHidden = true,
    this.errorMessage,
  });

  final FormzSubmissionStatus status;
  final SignupName name;
  final SignupEmail email;
  final SignupPassword password;
  final bool isValid;
  final bool passwordHidden;
  final String? errorMessage;

  SignupState copyWith({
    FormzSubmissionStatus? status,
    SignupName? name,
    SignupEmail? email,
    SignupPassword? password,
    bool? isValid,
    bool? passwordHidden,
    String? errorMessage,
  }) {
    return SignupState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      passwordHidden: passwordHidden ?? this.passwordHidden,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        name,
        email,
        password,
        isValid,
        passwordHidden,
      ];
}
