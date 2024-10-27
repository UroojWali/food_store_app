import 'package:formz/formz.dart';

// ignore: constant_identifier_names
enum PasswordValidationError { password_cannot_be_empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.password_cannot_be_empty;
    }
    return null;
  }
}
