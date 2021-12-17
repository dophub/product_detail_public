import 'package:flutter/material.dart';
import 'package:example/App/Constant/Assets/Assets.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Extension/ExtensionWidgetsScale.dart';
import 'package:example/App/Theme/TSColors.dart';

import 'TSTheme.dart';

class TSLightTheme implements TSTheme {
  Brightness brightness = Brightness.light;
  Color backgroundColor = TSColor.background;
  Color scaffoldBackgroundColor = TSColor.background;
  IconThemeData accentIconTheme = IconThemeData(color: Colors.white);
  IconThemeData primaryIconTheme = IconThemeData(color: Colors.white);
  IconThemeData iconTheme = IconThemeData(color: Colors.black);
  Color cardColor = Colors.white;
  Color bottomAppBarColor = Colors.white;
  Color dividerColor = TSColor.lightWhite;

  ColorScheme colorScheme = ColorScheme(
    primary: TSColor.turkcellLightBlue,
    primaryVariant: TSColor.turkcellBlue,
    secondary: Colors.white,
    secondaryVariant: Colors.white,
    surface: TSColor.cardColor,
    background: TSColor.background,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: TSColor.paleTextColor,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  ColorScheme buttonColorScheme = ColorScheme(
    primary: Colors.black,
    primaryVariant: Colors.black,
    secondary: Colors.black,
    secondaryVariant: Colors.black,
    surface: Colors.black,
    background: TSColor.turkcellBlue,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  CardTheme cardTheme = CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusXS)),
      color: TSColor.background,
      margin: EdgeInsets.zero);

  TextTheme textTheme = TextTheme(
    ///HeadLine
    headline1: TextStyle(
      fontSize: 12.textScale,
      fontWeight: FontWeight.w400,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
    headline2: TextStyle(
      fontSize: 12.textScale,
      fontWeight: FontWeight.w700,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
    headline3: TextStyle(
      fontSize: 18.textScale,
      fontWeight: FontWeight.w400,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
    headline4: TextStyle(
      fontSize: 18.textScale,
      fontWeight: FontWeight.w700,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
    headline5: TextStyle(
      fontSize: 20.textScale,
      fontWeight: FontWeight.w400,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
    headline6: TextStyle(
      fontSize: 20.textScale,
      fontWeight: FontWeight.w700,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),

    ///BodyText
    bodyText1: TextStyle(
      fontSize: 14.textScale,
      fontWeight: FontWeight.w400,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
    bodyText2: TextStyle(
      fontSize: 14.textScale,
      fontWeight: FontWeight.w700,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
    subtitle1: TextStyle(
      fontSize: 16.textScale,
      fontWeight: FontWeight.w400,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
    subtitle2: TextStyle(
      fontSize: 16.textScale,
      fontWeight: FontWeight.w700,
      color: TSColor.darkText,
      fontFamily: fontFamily,
    ),
  );

  ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(TSColor.turkcellBlue),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: Colors.white,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 18.textScale,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusXXS))),
    ),
  );

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    labelStyle: TextStyle(
      color: Colors.black,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 16.textScale,
    ),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
      color: TSColor.paleTextColor,
      fontSize: 16.textScale,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        radiusXXS,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        radiusXXS,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        radiusXXS,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(
        radiusXXS,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        radiusXXS,
      ),
    ),
  );

  TextSelectionThemeData textSelectionThemeData = TextSelectionThemeData(
    cursorColor: TSColor.turkcellBlue,
    selectionColor: TSColor.turkcellBlue.withOpacity(0.2),
    selectionHandleColor: TSColor.turkcellBlue,
  );

  TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(TSColor.turkcellBlue),
      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: TSColor.turkcellLightBlue,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16.textScale,
        ),
      ),
    ),
  );

  OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      side: MaterialStateProperty.all<BorderSide>(BorderSide(color: TSColor.turkcellBlue)),
      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: paddingM)),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: Colors.white,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 18.textScale,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusXXS))),
    ),
  );

  CheckboxThemeData checkboxThemeData = CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color?>(TSColor.turkcellBlue),
    checkColor: MaterialStateProperty.all<Color?>(Colors.white),
    side: BorderSide(width: 0.7, color: TSColor.turkcellBlue),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusXXXL),
    ),
  );

  RadioThemeData radioThemeData = RadioThemeData(
    fillColor: MaterialStateProperty.all<Color>(TSColor.turkcellBlue),
  );

  DividerThemeData dividerTheme = DividerThemeData(
    color: TSColor.lightWhite,
    space: 0,
  );

  @override
  AppBarTheme appBarTheme = AppBarTheme(
    color: TSColor.turkcellBlue,
    centerTitle: true,
  );

//MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio
}
