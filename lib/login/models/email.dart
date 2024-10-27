import 'package:formz/formz.dart';

// ignore: constant_identifier_names
enum EmailValidationError { email_cannot_be_empty, invalid_format_for_email }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.email_cannot_be_empty;
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return EmailValidationError.invalid_format_for_email;
    }
    return null;
  }
}
