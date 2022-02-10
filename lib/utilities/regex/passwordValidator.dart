bool validatePassword(String value) {
  String pattern =
     '(?=.*[0-9a-zA-Z]).{6,}';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}