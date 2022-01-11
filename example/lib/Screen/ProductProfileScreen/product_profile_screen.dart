import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:example/Screen/ProductProfileScreen/Controller/product_profile_controller.dart';
import 'package:example/Screen/ProductProfileScreen/View/product_profile.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:sip_models/request.dart';
import 'package:sip_models/response.dart';

/// Ürün profil ekranı
/// [dealerId] İşletme ID
/// [itemIdInOrder] Order Modelde [OrderModel] olan Item Id dir. Eğer sıfır ise yeni ürün demektir sıfır degil ise sepette olan ürünü güncelliyoruz demek
/// [menuItemModel] Ürün isim, açıklama, Fiyat ...vs ürün detayi yüklenirken gösterilsin diye bi önceki ekrandan çekiliyor
///
class ProductProfileScreen extends StatelessWidget {
  final int dealerId;
  final OrderItem? order;
  final ProductModel itemObject;

  const ProductProfileScreen({
    Key? key,
    required this.dealerId,
    this.order,
    required this.itemObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetBuilder(
      init: ProductProfileController(dealerId, itemObject, order),
      builder: (_) => ProductProfile(),
    );
  }
}
