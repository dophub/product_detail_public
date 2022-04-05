import 'package:flutter/material.dart';
import 'package:example/App/Constant/Assets/Assets.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Extension/ExtensionWidgetsScale.dart';
import 'package:example/App/Theme/TSColors.dart';

import 'TSTheme.dart';

class TSLightTheme implements TSTheme {
  @override
  Brightness brightness = Brightness.light;
  @override
  Color backgroundColor = AppColor.background;
  @override
  Color scaffoldBackgroundColor = AppColor.background;
  @override
  IconThemeData accentIconTheme = const IconThemeData(color: Colors.white);
  @override
  IconThemeData primaryIconTheme = const IconThemeData(color: Colors.white);
  @override
  IconThemeData iconTheme = const IconThemeData(color: Colors.black);
  @override
  Color cardColor = AppColor.background;
  @override
  Color bottomAppBarColor = Colors.white;
  @override
  Color dividerColor = AppColor.lightWhite;
  @override
  Color shadowColor = Colors.black26;

  @override
  ColorScheme colorScheme = ColorScheme(
    primary: AppColor.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColor.primaryVariant,
    secondary: AppColor.turkcellYellow,
    onSecondary: AppColor.darkText,
    secondaryContainer: AppColor.darkText,
    surface: Colors.white,
    onSurface: AppColor.darkText,
    background: AppColor.background,
    onBackground: AppColor.darkText,
    error: Colors.red,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  @override
  ColorScheme buttonColorScheme = const ColorScheme(
    primary: AppColor.primaryVariant,
    primaryContainer: AppColor.primaryVariant,
    secondary: AppColor.primary,
    secondaryContainer: AppColor.primary,
    surface: Colors.white,
    background: AppColor.primaryVariant,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  @override
  CardTheme cardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusXS)),
    color: AppColor.cardColor,
    margin: EdgeInsets.zero,
  );

  @override
  TextTheme textTheme = TextTheme(
    ///HeadLine
    headline1: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
    headline2: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
    headline3: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
    headline4: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
    headline5: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
    headline6: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),

    ///BodyText
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
    bodyText2: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
    subtitle1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
    subtitle2: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w700,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
  );

  @override
  ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor:
      MaterialStateProperty.all<Color>(AppColor.primaryVariant),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: Colors.white,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXL),
        ),
      ),
    ),
  );

  @override
  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    labelStyle: TextStyle(
      color: Colors.black,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ),
    hintStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily,
      color: AppColor.paleTextColor,
      fontSize: 14,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        radiusS,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        radiusS,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        radiusS,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(
        radiusS,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(
        radiusS,
      ),
    ),
  );

  @override
  TextSelectionThemeData textSelectionThemeData = TextSelectionThemeData(
    cursorColor: AppColor.primaryVariant,
    selectionColor: AppColor.primaryVariant.withOpacity(0.2),
    selectionHandleColor: AppColor.primaryVariant,
  );

  @override
  TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor:
      MaterialStateProperty.all<Color>(AppColor.primaryVariant),
      shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
      overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: AppColor.primary,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    ),
  );

  @override
  OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: AppColor.darkText)),
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: paddingM)),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          color: AppColor.darkText,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXL),
        ),
      ),
    ),
  );

  @override
  CheckboxThemeData checkboxThemeData = CheckboxThemeData(
    fillColor: MaterialStateProperty.all<Color?>(AppColor.primaryVariant),
    checkColor: MaterialStateProperty.all<Color?>(Colors.white),
    side: const BorderSide(width: 0.7, color: AppColor.primaryVariant),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radiusXXS),
    ),
  );

  @override
  RadioThemeData radioThemeData = RadioThemeData(
    fillColor: MaterialStateProperty.all<Color>(AppColor.primaryVariant),
  );

  @override
  DividerThemeData dividerTheme = DividerThemeData(
    color: AppColor.lightWhite,
    space: 0,
  );

  @override
  AppBarTheme appBarTheme = AppBarTheme(
    titleSpacing: 0,
    elevation: 0,
    color: AppColor.primaryVariant,
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: fontFamily,
    ),
    centerTitle: true,
    actionsIconTheme: const IconThemeData(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  @override
  TabBarTheme tabBarTheme = TabBarTheme(
    labelColor: AppColor.primaryVariant,
    labelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColor.primaryVariant,
      fontFamily: fontFamily,
    ),
    unselectedLabelColor: AppColor.darkText,
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColor.darkText,
      fontFamily: fontFamily,
    ),
  );

  @override
  Color indicatorColor = AppColor.primaryVariant;

  @override
  BottomAppBarTheme bottomAppBarTheme = const BottomAppBarTheme(
    color: Colors.transparent,
    elevation: 0,
  );
}
