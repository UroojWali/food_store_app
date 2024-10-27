import 'package:formz/formz.dart';

// ignore: constant_identifier_names
enum PasswordValidationError { password_cannot_be_empty }

class SignupPassword extends FormzInput<String, PasswordValidationError> {
  const SignupPassword.pure() : super.pure('');
  const SignupPassword.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.password_cannot_be_empty;
    }
    return null;
  }
}
