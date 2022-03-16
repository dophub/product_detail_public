
import 'package:sip_models/enum.dart';

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
  /// app/dealer/{dealer_id}/products/{product_id}
  static String getProductDetails(int dealerId, int productId) => 'app/dealer/$dealerId/products/$productId';

  /// Promotion menu getirir
  /// app/dealer/{dealer_id}/promotion_menu/{promotion_menu_id}
  static String getPromotionMenu(int dealerId, int promotionMenuId) =>
      'app/dealer/$dealerId/promotion_menu/$promotionMenuId';
}
