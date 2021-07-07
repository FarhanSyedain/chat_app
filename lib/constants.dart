import 'package:flutter/material.dart';

//We'll add light mode later
//Let's stick to dark mode for now

var kDarkBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
var kDarkCardColor = Color.fromRGBO(25, 39, 52, 1);
var kDarkHoverColor = Color.fromRGBO(34, 48, 60, 1);
var kDarkPrimaryColor = Color.fromRGBO(255, 255, 255, 1);
var kDarkSecondaryColor = Colors.grey;

var darkTheme = ThemeData(
  primaryColor: kDarkBackgroundColor.withAlpha(200),
  backgroundColor: kDarkBackgroundColor,
  cardColor: kDarkCardColor,
  hoverColor: kDarkHoverColor,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: kDarkPrimaryColor,
      fontSize: 36,
      fontFamily: 'Sans-serif',
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: kDarkSecondaryColor,
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      color: kDarkPrimaryColor,
      fontSize: 18,
    ),
    subtitle1: TextStyle(
      color: kDarkPrimaryColor.withAlpha(220),
      fontSize: 16,
    ),
    subtitle2: TextStyle(
      color: Colors.blue,
      fontSize: 12,
    ),
  ),
);
