import 'package:flutter/material.dart';

//We'll add light mode later
//Let's stick to dark mode for now

var kDarkBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
var kDarkCardColor = Color.fromRGBO(25, 39, 52, 1);
var kDarkHoverColor = Color.fromRGBO(34, 48, 60, 1);
var kDarkPrimaryColor = Color.fromRGBO(255, 255, 255, 1);
var kDarkSecondaryColor = Colors.grey;
var kLightBackgroundColor = Color.fromRGBO(255, 255, 255, 1);
var kLightCardColor = Color.fromRGBO(236, 236, 236, 1);
var kLightHoverColor = Color.fromRGBO(255, 255, 255, 1);
var kLightPrimaryColor = Color.fromRGBO(0, 0, 0, 1);
var kLightSecondaryColor = Colors.grey[850];

var darkTheme = ThemeData(
  primaryColor: kDarkBackgroundColor.withAlpha(200),
  backgroundColor: kDarkBackgroundColor,
  // backgroundColor: Color.fromRGBO(21, 32, 44, 1),
  cardColor: kDarkCardColor,
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  hoverColor: kDarkHoverColor,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: kDarkPrimaryColor,
      fontSize: 36,
      fontFamily: 'Space',
      fontWeight: FontWeight.w800,
    ),
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
    subtitle2: TextStyle(
      color: Colors.blue,
      fontSize: 12,
    ),
    headline4: TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontFamily:'Owl',
     
    ),
    headline5: TextStyle(
      fontSize: 20,
      color: kDarkPrimaryColor.withAlpha(220),
    ),
    headline6: TextStyle(
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
    subtitle2: TextStyle(
      color: Colors.blue,
      fontSize: 12,
    ),
    headline4: TextStyle(
      fontSize: 25,
      color: Colors.white,
      fontFamily: 'Owl',
    ),
    headline5: TextStyle(
      color: kLightPrimaryColor.withAlpha(220),
    ),
  ),
);
