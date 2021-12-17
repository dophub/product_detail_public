import 'package:flutter/material.dart';
import '../../controller/ProductController.dart';
import 'feature_and_option.dart';

/// Ürün detayının View kısmınıdır
class ProductDetailView extends StatelessWidget {
  final ProductViewController controller;

  const ProductDetailView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FeatureAndOption();
  }
}
