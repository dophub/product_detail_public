<!-- 
Türkcell Siparişim uygulamasının ürün profil ekranının detay kısmını kapsamaktadır. 
-->

## Kullanımı

Paketi projeye eklemek için 'pubspec.yaml' dosyasına girip altaki kod bluğu ekliyoruz 
```dart
  product_detail:
    git:
      url: https://bitbucket.org/digital-operasyon-merkezi/product_detail_public.git
      ref: prod
```

Controlleri import etmek için
```dart
import 'package:product_detail/controller.dart';
```

ProductDetail'i import etmek için
```dart
import 'package:product_detail/product_detail.dart';
```

Product,Promotion ve Basket modellerini import etmek için 
```dart
import 'package:product_detail/model.dart';
```

Kontrolumuzu init yapıyoruz
```dart
final ProductViewController productViewController =  ProductViewController(orderItem,productDetailModel);
```

View kısmında bu kod bluğunu ekliyoruz
```dart
Container(
     child: ProductDetailView(
      controller: controller.productViewController,
),)
```

Tutar değişkenini dinlemek istediğmizde
```dart
productViewController.addListener(() {   
  amount = productViewController.value;
});
```
 
Ürün Adedini güncellemek istersek
```dart
void onTapQuantityBtn(int _count) {
  int _count = 4;
  productViewController.count = _count;
}
```

Sepet modelini seçilen özeliklere göre getirmek istersek
```dart
var item = productViewController.getBasketModel(TimeoutAction.Add);
```

Dealer de Masa TimeOut durumu.
```dart
///[None] Sepete Ilk eklemede ekleyeceğmiz durum.
///[New] Yeni Service Başlatmak istiyorum.
///[Add] Masaya açık olan service devam etmek istiyorum.
enum TimeoutAction { None, New, Add }
```

Sepete eklemek istediğimizde controllerden Sepet modelini Çekip Http işlemleri yapacaz.
```dart
Future<void> onTapAddToCartBtn(TimeoutAction timeoutAction) async {
  BuildContext context = scaffoldKey.currentContext!;
  LoadingProgress.showLoading(context);
  var item = optionViewController.getBasketModel(TimeoutAction.Add);
  await Future.delayed(Duration(seconds: 1)); // Http işlemi
  LoadingProgress.done(context);
  showToastMessage(context, textMessage: 'Ürün sepete eklendi');
}
```

Dispose işlemi
```dart
@override
void onClose() {
  promotionViewController.dispose();   
  super.onClose();
}
```
