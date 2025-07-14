import '../default_localization.dart';

class EnLocalization extends AppLocalizationLabel {
  const EnLocalization();

  @override
  final String lanCode = 'en';

  @override
  String get productNote => 'Product Note';

  @override
  String get close => 'Close';

  @override
  String get addNote => 'Add Note';

  @override
  String maxSelection(int maxCount) => '(Maximum: $maxCount Selection)';

  @override
  String get select => 'Select';

  @override
  String get selectProductsToRemove => 'Please select the products you want to remove';
}
