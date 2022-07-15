import 'package:sip_models/enum.dart';
import 'package:sip_models/response.dart';

/// [LoadingStatus] Enumun durumlarını kontrol etmek için yazıldı
extension LoadingStatusExtension on LoadingStatus {
  get isLoading => this == LoadingStatus.Loading;

  get isInit => this == LoadingStatus.Init;

  get isError => this == LoadingStatus.Error;

  get isLoaded => this == LoadingStatus.Loaded;
}

/// [BaseModelStatus] Enumun durumlarını kontrol etmek için yazıldı
extension BaseModelStatusExtension on BaseModelStatus {
  get isOk => this == BaseModelStatus.Ok;

  get isAction => this == BaseModelStatus.Action;

  get isError => this == BaseModelStatus.Error;

  get isUnprocessableEntity => this == BaseModelStatus.UnprocessableEntity;

  get isTimeOut => this == BaseModelStatus.TimeOut;
}

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
