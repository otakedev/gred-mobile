import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gred_mobile/theme/colors.dart';

double _offset = 0;
double get offset => _offset;
set offset(double offset) {
  _offset = offset;
}

ThemeData appTheme({double fontOffset = 0}) {
  offset = fontOffset;
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primarySwatch: generateMaterialColor(kColorPrimary),
    accentColor: kColorAccent,
    // scaffoldBackgroundColor: kColorBackground,
    scaffoldBackgroundColor: kColorBackground,

    // Define the default font family.
    fontFamily: 'ArialRounded',

    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      textTheme: ButtonTextTheme.primary,
    ),

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 72.0 + fontOffset,
        fontWeight: FontWeight.bold,
        color: kColorSecondary,
      ),
      headline5: TextStyle(
        fontSize: 24.0 + fontOffset,
        fontWeight: FontWeight.bold,
        color: kColorSecondary,
      ),
      headline6: TextStyle(
        fontSize: 20.0 + fontOffset,
        color: kColorSecondary,
      ),
      bodyText1: TextStyle(
        fontSize: 16.0 + fontOffset,
        color: kColorSecondary,
      ),
      bodyText2: TextStyle(
        fontSize: 14.0 + fontOffset,
        color: kColorSecondaryText,
      ),
    ),
  );
}
