import 'package:sip_models/enum.dart';
import 'package:sip_models/response.dart';

extension PriceModelExtension on List<PriceModel> {
  /// Verilen [PriceModel] listesinden kullanıcının o anki bullunduğu mödüle göre fiyat döndürmekte.
  /// Gelen listede kullanılan modülün fiyat türü yok ise [PriceType.TABLE] fiyatını döndürmekte.
  double getPrice(PriceType priceType) {
    late double tablePrice;
    double? getInPrice;
    double? tekOutPrice;

    /// Listeden fiyatları alıyoruz
    for (PriceModel element in this) {
      if (element.orderDeliveryTypeId == PriceType.TABLE.name) {
        tablePrice = element.price!;
      } else if (element.orderDeliveryTypeId == PriceType.TAKEOUT.name) {
        tekOutPrice = element.price;
      } else if (element.orderDeliveryTypeId == PriceType.GETIN.name) {
        getInPrice = element.price;
      }
    }

    /// AppModule göre fiyat döndürüyoruz
    switch (priceType) {
      case PriceType.TABLE:
        return tablePrice;
      case PriceType.TAKEOUT:
        return tekOutPrice ?? tablePrice;
      case PriceType.GETIN:
        return getInPrice ?? tablePrice;
    }
  }
}
