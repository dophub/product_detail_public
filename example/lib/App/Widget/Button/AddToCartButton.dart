import 'package:flutter/material.dart';
import 'package:example/App/Constant/Assets/Assets.dart';
import 'IconAndAmountButton.dart';

/// Turkcell mavisi ile Sepete Ekle butonu
/// 'sipariş ikonu - fiyat - Sepete Ekle' Şeklinde
class AddToCartButton extends StatelessWidget {
  final VoidCallback? onTap;

  final double price;

  final String? text;

  const AddToCartButton({Key? key, required this.onTap, required this.price, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconAndAmountButton(
      onTap: onTap,
      text: text ?? 'Sepete Ekle',
      amount: price,
      svg: orderIcon,
    );
  }
}
