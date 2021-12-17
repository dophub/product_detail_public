import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/AppConstant.dart';
import 'package:example/App/Theme/TSColors.dart';
import 'package:example/App/Theme/TSTextStyle.dart';

/// Section lerde gösterilen 'Section Addı (+₺ 5.00)' şeklinde widget
class PriceTextWidgetWithParentheses extends StatelessWidget {
  final double? price;
  final TextStyle? textStyle;
  final Color? color;
  final String name;

  const PriceTextWidgetWithParentheses(
      {Key? key,
      required this.price,
      this.textStyle,
      this.color,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return price == null || price == 0
        ? Text(name,
            style: textStyle == null
                ? s16W400Dark(context)
                    .copyWith(color: color ?? TSColor.darkText)
                : textStyle!.copyWith(color: color ?? TSColor.darkText))
        : RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: name,
              style: textStyle == null
                  ? s16W400Dark(context).copyWith(color: color ?? TSColor.darkText)
                  : textStyle!.copyWith(color: color ?? TSColor.darkText),
              children: <TextSpan>[
                TextSpan(
                  text: ' (+',
                  style: textStyle == null
                      ? s16W400Dark(context)
                          .copyWith(color: color ?? TSColor.turkcellBlue)
                      : textStyle!
                          .copyWith(color: color ?? TSColor.turkcellBlue),
                ),
                TextSpan(
                  text: priceUnit,
                  style: textStyle == null
                      ? s16W400Dark(context).copyWith(
                          fontFamily: '', color: color ?? TSColor.turkcellBlue)
                      : textStyle!.copyWith(
                          fontFamily: '', color: color ?? TSColor.turkcellBlue),
                ),
                TextSpan(
                  text: ' ${price!.toStringAsFixed(2)})',
                  style: textStyle == null
                      ? s16W400Dark(context)
                          .copyWith(color: color ?? TSColor.turkcellBlue)
                      : textStyle!
                          .copyWith(color: color ?? TSColor.turkcellBlue),
                ),
              ],
            ),
          );
  }
}
