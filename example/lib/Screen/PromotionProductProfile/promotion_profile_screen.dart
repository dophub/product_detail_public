import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sip_models/sip_general_models.dart';
import 'Controller/promotion_profile_controller.dart';
import 'View/promotion_profile.dart';

/// Ürün profil ekranı
/// [dealerId] İşletme ID
/// [itemIdInOrder] Order Modelde [OrderModel] olan Item Id dir. Eğer sıfır ise yeni ürün demektir sıfır degil ise sepette olan ürünü güncelliyoruz demek
/// [menuItemModel] Ürün isim, açıklama, Fiyat ...vs ürün detayi yüklenirken gösterilsin diye bi önceki ekrandan çekiliyor
///
class PromotionProfileScreen extends StatelessWidget {
  final int dealerId;
  final OrderItem? order;
  final ProductModel itemObject;

  const PromotionProfileScreen({
    Key? key,
    required this.dealerId,
    this.order,
    required this.itemObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetBuilder(
      init: PromotionProfileController(dealerId, itemObject, order),
      builder: (_) => PromotionProfile(),
    );
  }
}
