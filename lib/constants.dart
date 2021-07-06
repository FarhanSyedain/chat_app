import 'package:flutter/material.dart';

//We'll add light mode later
//Let's stick to dark mode for now

var kDarkBackgroundColor = Color.fromRGBO(21, 32, 43, 1);
var kDarkCardColor = Color.fromRGBO(25, 39, 52, 1);
var kDarkHoverColor = Color.fromRGBO(34, 48, 60, 1);
var kDarkPrimaryColor = Color.fromRGBO(255, 255, 255, 1);
var kDarkSecondaryColor = Color.fromRGBO(136, 153, 166, 1);

var darkTheme = ThemeData(
  primaryColor: kDarkBackgroundColor.withAlpha(200),
  backgroundColor: kDarkBackgroundColor,
  cardColor: kDarkCardColor,
  hoverColor: kDarkHoverColor,
);
