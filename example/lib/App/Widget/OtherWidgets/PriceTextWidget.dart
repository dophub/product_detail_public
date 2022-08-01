import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/AppConstant.dart';
import 'package:example/App/Theme/AppColors.dart';
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
            ? s12W700Dark(context).copyWith(fontFamily: '', color: color ?? AppColor.darkText)
            : textStyle!.copyWith(fontFamily: '', color: color ?? AppColor.darkText),
        children: <TextSpan>[
          TextSpan(
            text: ' ${price.toStringAsFixed(2)}',
            style: textStyle == null
                ? s12W700Dark(context).copyWith(color: color ?? AppColor.darkText)
                : textStyle!.copyWith(color: color ?? AppColor.darkText),
          ),
        ],
      ),
    );
  }
}
