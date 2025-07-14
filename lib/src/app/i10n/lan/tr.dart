import '../default_localization.dart';

class TrLocalization extends AppLocalizationLabel {
  const TrLocalization();

  @override
  final String lanCode = 'tr';

  @override
  String get productNote => 'Ürün Notu';

  @override
  String get close => 'Kapat';

  @override
  String get addNote => 'Not Ekle';

  @override
  String maxSelection(int maxCount) => '(En Fazla: $maxCount Seçim)';

  @override
  String get select => 'Seçiniz';

  @override
  String get selectProductsToRemove => 'Lütfen çıkarmak istediğiniz ürünleri seçiniz';
}
