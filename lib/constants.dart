import 'package:flutter/material.dart';

//We'll add light mode later
//Let's stick to dark mode for now

var kDarkBackgroundColor = const Color.fromRGBO(0, 0, 0, 1);
var kDarkCardColor = const Color.fromRGBO(25, 39, 52, 1);
var kDarkHoverColor = const Color.fromRGBO(34, 48, 60, 1);
var kDarkPrimaryColor = const Color.fromRGBO(255, 255, 255, 1);
var kDarkSecondaryColor = Colors.grey;
var kLightBackgroundColor = const Color.fromRGBO(255, 255, 255, 1);
var kLightCardColor = const Color.fromRGBO(236, 236, 236, 1);
var kLightHoverColor = const Color.fromRGBO(255, 255, 255, 1);
var kLightPrimaryColor = const Color.fromRGBO(0, 0, 0, 1);
var kLightSecondaryColor = Colors.grey[850];

var darkTheme = ThemeData(
  primaryColor: kDarkBackgroundColor,
  backgroundColor: kDarkBackgroundColor,
  cardColor: kDarkCardColor,
  canvasColor: const Color(0xff121212),
  scaffoldBackgroundColor: kDarkBackgroundColor,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    // secondary: Color(0xff5D9187),
    secondary: const Color(0xFF475997),
    primary: const Color(0xff5D9187),
  ),
  hoverColor: kDarkHoverColor,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: kDarkPrimaryColor,
      fontSize: 36,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w800,
    ),
    caption: const TextStyle(color: Colors.grey),
    headline2: TextStyle(
      color: kDarkPrimaryColor,
      fontFamily: 'Sans',
      fontWeight: FontWeight.w800,
      fontSize: 25,
    ),
    bodyText2: TextStyle(
      color: kDarkSecondaryColor,
      fontSize: 13,
    ),
    bodyText1: TextStyle(
      color: kDarkPrimaryColor,
      fontSize: 16,
    ),
    subtitle1: TextStyle(
      color: kDarkPrimaryColor.withAlpha(220),
      fontSize: 14,
    ),
    subtitle2: const TextStyle(
      color: Colors.blue,
      fontSize: 12,
    ),
    headline4: const TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontFamily: 'Owl',
    ),
    headline5: TextStyle(
      fontSize: 20,
      color: kDarkPrimaryColor.withAlpha(220),
    ),
    headline6: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);

var lightTheme = ThemeData(
  primaryColor: kLightBackgroundColor,
  backgroundColor: kLightBackgroundColor,
  cardColor: kLightCardColor,
  hoverColor: kLightHoverColor,
  colorScheme: const ColorScheme.dark().copyWith(
    secondary: const Color(0xff5D9187),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: kLightPrimaryColor,
      fontSize: 36,
      fontFamily: 'Sans-serif',
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: kLightSecondaryColor,
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      color: kLightPrimaryColor,
      fontSize: 18,
    ),
    subtitle1: TextStyle(
      color: kLightPrimaryColor.withAlpha(220),
      fontSize: 16,
    ),
    subtitle2: const TextStyle(
      color: Colors.blue,
      fontSize: 12,
    ),
    headline4: const TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontFamily: 'Owl',
    ),
    headline5: TextStyle(
      color: kLightPrimaryColor.withAlpha(220),
    ),
  ),
);
