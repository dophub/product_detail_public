import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';
import 'package:product_detail/src/app/const/TSColors.dart';
import 'package:product_detail/src/app/const/TSTextStyle.dart';

/// Fiyat göstergelerinde kullanılmakta.
/// '(+₺ 5.00)' şeklinde widget
class PriceTextWidget extends StatelessWidget {
  final double price;
  final TextStyle? textStyle;
  final Color? color;

  const PriceTextWidget({Key? key, required this.price, this.textStyle, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var percent = NumberFormat.currency(
        locale: Localizations.localeOf(context).languageCode,
        symbol: priceUnit,
        decimalDigits: 2);
    return Text(
      percent.format(price),
      textAlign: TextAlign.center,
      style: textStyle == null
          ? s12W700Dark(context).copyWith(color: color ?? TSColor.darkText)
          : textStyle!.copyWith(color: color ?? TSColor.darkText),
    );
  }
}
