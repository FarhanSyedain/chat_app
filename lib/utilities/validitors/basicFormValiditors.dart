import 'package:chat_app/utilities/regex/emailRegexValidator.dart';
import 'package:chat_app/utilities/regex/passwordValidator.dart';

String? emailValidator(value) {
  if (value == null) {
    return 'Enter an email';
  }
  if (!validateEmail(value)) {
    return 'Enter a valid email';
  }
}

String? passwordValidator(value) {
  if (value == null) {
    return 'Enter a password';
  }
  if (!validatePassword(value)) {
    return 'Password must be atleast 6 charecters';
  }
}

String? confirmPasswordValidator(value, passwordTextFieldController) {
  final password = passwordTextFieldController.text;

  if (password != value) {
    return 'Passwords don\'t match';
  }
}