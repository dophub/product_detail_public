import 'package:example/App/Constant/Enums/IdEnum.dart';

class HttpUrl {
  /// Api Url
  static late final String baseUrl;

  static late String token;

  /// Api Key
  static const String apiKey = '7d3b663c-176d-4e4f-aa24-bac5b0cb0ba8';

  /// Secret Key
  static const String secretKey = 'F45GH65DS3RTDOP45';

  /// client
  static const ClientPointId clientId = ClientPointId.MOBILE_APP;

  /// GET (for get new token)
  static const String getToken = 'gettoken/app';

  /// Ürün detay getirir
  /// app/products/detail/{dealer_id}/{product_id}
  static const String getProductDetails = 'app/products/detail';

  /// Promotion menu getirir
  /// app/promotion_menu/detail/{dealer_id}/{promotion_menu_id}
  static const String getPromotionMenu = 'app/promotion_menu/detail';
}
