import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/AppConstant.dart';
import 'package:example/App/Theme/TSColors.dart';
import 'package:example/App/Theme/TSTextStyle.dart';

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
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: priceUnit,
        style: textStyle == null
            ? s12W700Dark(context).copyWith(fontFamily: '', color: color ?? TSColor.darkText)
            : textStyle!.copyWith(fontFamily: '', color: color ?? TSColor.darkText),
        children: <TextSpan>[
          TextSpan(
            text: ' ' + price.toStringAsFixed(2),
            style: textStyle == null
                ? s12W700Dark(context).copyWith(color: color ?? TSColor.darkText)
                : textStyle!.copyWith(color: color ?? TSColor.darkText),
          ),
        ],
      ),
    );
  }
}
