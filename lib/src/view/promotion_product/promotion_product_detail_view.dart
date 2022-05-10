import 'package:flutter/material.dart';
import 'package:product_detail/src/controller/promotion_controller.dart';
import 'promotion_details.dart';

/// Promosyonlu Ürün detayının View kısmınıdır
class PromotionProductDetailView extends StatelessWidget {
  final PromotionViewController controller;

  const PromotionProductDetailView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PromotionDetails();
  }
}
