import 'package:flutter/foundation.dart';
import 'package:product_detail/src/app/const/GeneralEnum.dart';
import 'package:product_detail/src/app/const/TypeEnum.dart';
import 'package:product_detail/src/app/model/MenuDetailModel.dart';
import 'package:product_detail/src/app/model/PriceModel.dart';
import 'package:product_detail/src/app/model/ProductCartModel.dart';


/// Bu sınıfımız Genel tüm modüller için yazıldı.
///
/// [priceType] Bu değişkenimiz kullanıcı hangi modülde ise o modülün fiyat türünü tutmakta olup
///
class ProductDetailGeneralController  {

  /// Verilen [PriceModel] listesinden kullanıcının o anki bullunduğu mödüle göre fiyat döndürmekte.
  /// Gelen listede kullanılan modülün fiyat türü yok ise [PriceType.TABLE] fiyatını döndürmekte.
  double getPrice(PriceType priceType,List<PriceModel> list) {
    //Todo : İsDefault alanı kontrol edilmesi gerek
    late double tablePrice;
    double? getInPrice;
    double? tekOutPrice;
    for (PriceModel element in list) {
      if (element.orderDeliveryTypeId == describeEnum(PriceType.TABLE))
        tablePrice = element.price!;
      else if (element.orderDeliveryTypeId == describeEnum(PriceType.TAKEOUT))
        tekOutPrice = element.price;
      else if (element.orderDeliveryTypeId == describeEnum(PriceType.GETIN))
        getInPrice = element.price;
    }
    switch (priceType) {
      case PriceType.TABLE:
        return tablePrice;
      case PriceType.TAKEOUT:
        return tekOutPrice ?? tablePrice;
      case PriceType.GETIN:
        return getInPrice ?? tablePrice;
    }
  }


  /// Opsiyonsuz Order modeli oluşturmak için yazıldı.
  /// Opsiyonu olmayan ProductCard e olan sepete ekle buttonuna tıklandığında modeli oluşturmak için kullanılmakta.
  ItemOrder? getBasketModelWithOutOption(MenuProductModel product,PriceType priceType,TimeoutAction timeoutAction) {
    double amount = getPrice(priceType,product.price!);
    var item = ItemOrder(id: 0);
    /// Yeni ürün olduğuda 0 önceden eklenen ürünü güncelliyorsak order de dönen id yi veriyoruz
    item.id = 0;
    item.timeoutAction = describeEnum(timeoutAction);
    item.note = '';
    item.count = 1;
    item.itemAmount = amount;
    item.totalAmount = amount;
    item.note = '';
    item.product = Product();
    item.itemType = describeEnum(ItemType.PRODUCT);
    item.product!.itemId = product.id;
    item.product!.productName = product.productName;
    item.product!.options = null;
    return item;
  }
}

