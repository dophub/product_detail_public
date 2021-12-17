import 'package:flutter/material.dart';
import 'TSTheme.dart';

ThemeData getTheme<T extends TSTheme>(T theme) => ThemeData(
      colorScheme: theme.colorScheme,
      backgroundColor: theme.backgroundColor,
      scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
      cardColor: theme.cardColor,
      cardTheme: theme.cardTheme,
      textTheme: theme.textTheme,
      appBarTheme: theme.appBarTheme,
      bottomAppBarColor: theme.bottomAppBarColor,
      iconTheme: theme.iconTheme,
      brightness: theme.brightness,
      elevatedButtonTheme: theme.elevatedButtonTheme,
      textSelectionTheme: theme.textSelectionThemeData,
      inputDecorationTheme: theme.inputDecorationTheme,
      primaryIconTheme: theme.primaryIconTheme,
      textButtonTheme: theme.textButtonThemeData,
      dividerColor: theme.dividerColor,
      dividerTheme: theme.dividerTheme,
      outlinedButtonTheme: theme.outlinedButtonThemeData,
      checkboxTheme: theme.checkboxThemeData,
      buttonTheme: ButtonThemeData(
        colorScheme: theme.buttonColorScheme,
      ),
      radioTheme: theme.radioThemeData,
    );
