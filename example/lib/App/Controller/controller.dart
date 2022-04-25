import 'package:example/App/BL/General.dart';
import 'package:example/App/Constant/App/HttpUrl.dart';
import 'package:example/App/Extension/GeneralExtension.dart';
import 'package:example/App/Widget/Dialog/LoadingProgress.dart';
import 'package:example/App/Widget/Message/ToastMessage.dart';
import 'package:example/Screen/ProductProfileScreen/product_profile_screen.dart';
import 'package:example/Screen/PromotionProductProfile/promotion_profile_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sip_models/enum.dart';
import 'package:sip_models/response.dart';
import 'package:sip_models/status.dart';
import 'package:uuid/uuid.dart';

/// Bu sınıfımız Genel tüm modüllerin için yazıldı.
///
/// Uygulamnın genelinde kullanılan metodlarımızı buraya yazmaktayız.
///
/// [priceType] Bu değişkenimiz kullanıcı hangi modülde ise o modülün fiyat türünü tutmakta olup
/// [Controller.getPrice] fonksiyonumuz türüne göre fiyat getirmekte.
/// [loadingStatus] Bu değişkenimiz [Controller] Api işlemlerinin durmunu tutmak için kullanılmaka.
///
class Controller extends GetxController  {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late LoadingStatus loadingStatus;
  String sessionId = '';

  Controller() {
    loadingStatus = LoadingStatus.Init;
  }

  /// Token çekmek için yazıldı
  Future<void> getToken(BuildContext context) async {
    LoadingProgress.showLoading(context);
    sessionId = Uuid().v4();
    BaseHttpModel response = await General().getToken(sessionId);
    if (response.status.isOk) {
      HttpUrl.token = response.data.accessToken;
      showToastMessage(context, textMessage: 'Get token success');
    } else {
      showToastMessage(context, textMessage: 'Get token error');
    }
    LoadingProgress.done(context);
  }


  /// Menu list item tıklandığında çalışan metod.
  /// [ProductProfileScreen] e gider.
  void goToProductProfileScreen(BuildContext context, int dealerId, ProductModel productModel) {
    productModel.itemType == describeEnum(ItemType.PRODUCT)
        ? Navigator.push(context, MaterialPageRoute(builder: (_) => ProductProfileScreen(itemObject: productModel, dealerId: dealerId)))
        : Navigator.push(context, MaterialPageRoute(builder: (_) => PromotionProfileScreen(dealerId: dealerId, itemObject: productModel)));
  }

  /// Verilen [images] Listesinden ID si [imageSizeId] olan resimleri hepsini List<ImagesModel> türünde döndürür.
  List<ImagesModel> getImages(List<ImagesModel> images,ImageSizeId imageSizeId) => images.where((ImagesModel element) => element.imageSizeId == describeEnum(imageSizeId)).toList();

  /// Verilen [images] Listesinden ID si [imageSizeId] olan resimlerden ilk yakladığını String türünde döndürür.
  String getImage(List<ImagesModel> images,ImageSizeId imageSizeId) => images.firstWhere((ImagesModel element) => element.imageSizeId == describeEnum(ImageSizeId.mobile_list),orElse: () => ImagesModel()..imageUrl = '').imageUrl!;

  void onTapGetProductBtn(BuildContext context) {
    ProductModel model = ProductModel()
      ..id = 179
      ..price = [
        PriceModel(
            price: 0, id: 108, isDefault: false, orderDeliveryTypeId: 'TABLE')
      ]
      ..images = [
        ImagesModel(
            id: 0,
            imageUrl:
                'https://dynaimage.cdn.cnn.com/cnn/q_auto,w_1100,c_fill,g_auto,h_619,ar_16:9/http%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F200401171739-06-best-turkish-foods-yaprak-dolma.jpg',
            imageSizeId: describeEnum(ImageSizeId.mobile_detail))
      ]
      ..calorie = 0
    ..itemType = describeEnum(ItemType.PRODUCT)
    ..makeTime = 0
    ..listOrder = 0
    ..productName = 'Product'
    ..shortDescription = 'shortDescription';
    goToProductProfileScreen(context, 594,model);
  }

  void onTapGetPromotionProductBtn(BuildContext context){
    ProductModel model = ProductModel()..id = 67..price = [PriceModel(price: 0,id: 108,isDefault: false,orderDeliveryTypeId: 'TABLE')]
      ..images = [
        ImagesModel(
            id: 0,
            imageUrl: 'https://dynaimage.cdn.cnn.com/cnn/q_auto,w_1100,c_fill,g_auto,h_619,ar_16:9/http%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F200401171739-06-best-turkish-foods-yaprak-dolma.jpg',
            imageSizeId: describeEnum(ImageSizeId.mobile_detail))
      ]
      ..calorie = 0
    ..itemType = describeEnum(ItemType.PROMOTION_MENU)
    ..makeTime = 0
    ..listOrder = 0
    ..productName = 'Product'
    ..shortDescription = 'shortDescription';
    goToProductProfileScreen(context, 603, model);
  }
}

