import 'package:formz/formz.dart';

// ignore: constant_identifier_names
enum NameValidationError { name_cannot_be_empty }

class SignupName extends FormzInput<String, NameValidationError> {
  const SignupName.pure() : super.pure('');
  const SignupName.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.name_cannot_be_empty;
    }
    return null;
  }
}
