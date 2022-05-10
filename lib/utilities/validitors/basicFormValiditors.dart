import '/utilities/regex/emailRegexValidator.dart';
import '/utilities/regex/passwordValidator.dart';

String? emailValidator(value) {
  if (value == null) {
    return 'Enter an email';
  }
  if (!validateEmail(value)) {
    return 'Enter a valid email';
  }
  return null;
  
}

String? passwordValidator(value) {
  if (value == null) {
    return 'Enter a password';
  }
  if (!validatePassword(value)) {
    return 'Password must be atleast 6 charecters';
  }
  return null;
}

String? confirmPasswordValidator(value, passwordTextFieldController) {
  final password = passwordTextFieldController.text;

  if (password != value) {
    return 'Passwords don\'t match';
  }
  return null;
}