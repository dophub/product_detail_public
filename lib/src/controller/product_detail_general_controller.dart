import 'package:product_detail/src/app/extension/general_extension.dart';
import 'package:sip_models/enum.dart';
import 'package:sip_models/response.dart';

class ProductDetailGeneralController  {

  /// Opsiyonsuz Order modeli oluşturmak için yazıldı.
  /// Opsiyonu olmayan ProductCard e olan sepete ekle buttonuna tıklandığında modeli oluşturmak için kullanılmakta.
  ItemOrder? getBasketModelWithOutOption(ProductModel product,PriceType priceType,TimeoutAction timeoutAction) {
    double amount = product.price!.getPrice(priceType);
    var item = ItemOrder(id: 0);
    /// Yeni ürün olduğuda 0 önceden eklenen ürünü güncelliyorsak order de dönen id yi veriyoruz
    item.id = 0;
    item.timeoutAction = timeoutAction.name;
    item.note = '';
    item.count = 1;
    item.itemAmount = amount;
    item.totalAmount = amount;
    item.note = '';
    item.product = Product();
    item.itemType = ItemType.PRODUCT.name;
    item.product!.itemId = product.id;
    item.product!.productName = product.productName;
    item.product!.options = null;
    return item;
  }
}

