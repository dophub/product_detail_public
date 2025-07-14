import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Locale;
import 'lan/en.dart';
import 'lan/tr.dart';

/// Default Locale ayarlarımız
const kDefaultLocal = Locale('tr');

/// Ugulamanın desteklediği diler
const Map<String, AppLocalizationLabel> supportedLocalization = {
  'tr': TrLocalization(),
  'en': EnLocalization(),
};

abstract class AppLocalizationLabel {
  const AppLocalizationLabel();

  String get lanCode;

  String get productNote;

  String get close;

  String get addNote;

  String maxSelection(int maxCount);

  String get select;

  String get selectProductsToRemove;
}
