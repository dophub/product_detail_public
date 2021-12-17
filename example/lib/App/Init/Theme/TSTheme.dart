import 'package:flutter/material.dart';

abstract class TSTheme {
  late final Brightness brightness;
  late final Color backgroundColor;
  late final Color scaffoldBackgroundColor;
  late final IconThemeData accentIconTheme;
  late final IconThemeData primaryIconTheme;
  late final IconThemeData iconTheme;
  late final Color cardColor = Colors.black;
  late final Color bottomAppBarColor = Colors.black;
  late final Color dividerColor;
  late final ColorScheme colorScheme;
  late final ColorScheme buttonColorScheme;
  late final CardTheme cardTheme;
  late final TextTheme textTheme;
  late final ElevatedButtonThemeData elevatedButtonTheme;
  late final InputDecorationTheme inputDecorationTheme;
  late final TextSelectionThemeData textSelectionThemeData;
  late final TextButtonThemeData textButtonThemeData;
  late final OutlinedButtonThemeData outlinedButtonThemeData;
  late final CheckboxThemeData checkboxThemeData;
  late final RadioThemeData radioThemeData;
  late final DividerThemeData dividerTheme;
  late final AppBarTheme appBarTheme;
}
