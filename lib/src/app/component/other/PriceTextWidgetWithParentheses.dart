import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';
import 'package:product_detail/src/app/const/TSColors.dart';
import 'package:product_detail/src/app/const/TSTextStyle.dart';

/// section lerde gösterilen 'section Addı (+₺ 5.00)' şeklinde widget
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
    var percent = NumberFormat.currency(
        locale: Localizations.localeOf(context).languageCode,
        symbol: priceUnit,
        decimalDigits: 2);
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
                  text: '${percent.format(price!)})',
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
