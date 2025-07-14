import 'package:flutter/cupertino.dart';
import 'default_localization.dart';

class AppLocalization<T extends AppLocalizationLabel> {
  final Locale locale;
  final T labels;

  static AppLocalization? _instance;

  const AppLocalization._(this.locale, this.labels);

  static AppLocalization _load(Locale locale) {
    final localization = AppLocalization._(
      locale,
      supportedLocalization[locale.languageCode] ?? supportedLocalization[kDefaultLocal.languageCode]!,
    );
    return localization;
  }

  static AppLocalizationLabel getLabels(BuildContext context) {
    try {
      final locale = Localizations.localeOf(context);
      if (_instance?.locale.languageCode != locale.languageCode) _instance = AppLocalization._load(locale);
      return _instance!.labels;
    } catch (_) {
      return AppLocalization._(kDefaultLocal, supportedLocalization[kDefaultLocal.languageCode]!).labels;
    }
  }
}
