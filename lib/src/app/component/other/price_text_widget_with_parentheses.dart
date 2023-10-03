import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_colors.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';

/// section lerde gösterilen 'section Addı (+₺ 5.00)' şeklinde widget
class PriceTextWidgetWithParentheses extends StatelessWidget {
  final double? price;
  final TextStyle? textStyle;
  final Color? color;
  final String name;
  final int? maxLines;

  const PriceTextWidgetWithParentheses({
    Key? key,
    required this.price,
    this.textStyle,
    this.color,
    required this.name,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textStyle = textStyle == null
        ? s16W400Dark(context).copyWith(color: color ?? AppColor.turkcellBlue)
        : textStyle!.copyWith(color: color ?? AppColor.turkcellBlue);
    var percent = NumberFormat.currency(
      locale: Localizations.localeOf(context).languageCode,
      symbol: '',
      decimalDigits: 2,
    );
    return price == null || price == 0
        ? Text(
            name,
            style: textStyle == null
                ? s16W400Dark(context).copyWith(color: color ?? AppColor.darkText)
                : textStyle!.copyWith(color: color ?? AppColor.darkText),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          )
        : RichText(
            textAlign: TextAlign.start,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: name,
              style: textStyle == null
                  ? s16W400Dark(context).copyWith(color: color ?? AppColor.darkText)
                  : textStyle!.copyWith(color: color ?? AppColor.darkText),
              children: <TextSpan>[
                TextSpan(
                  text: ' (+',
                  style: _textStyle,
                ),
                TextSpan(
                  text: priceUnit,
                  style: _textStyle.copyWith(fontFamily: ''),
                ),
                TextSpan(
                  text: '${percent.format(price!)})',
                  style: _textStyle,
                ),
              ],
            ),
          );
  }
}
