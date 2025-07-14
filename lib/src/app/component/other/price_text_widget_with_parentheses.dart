import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';

/// section lerde gösterilen 'section Addı (+₺ 5.00)' şeklinde widget
class PriceTextWidgetWithParentheses extends StatelessWidget {
  final double? price;
  final TextStyle? textStyle;
  final Color? color;
  final Color? priceColor;
  final String name;
  final int? maxLines;

  const PriceTextWidgetWithParentheses({
    super.key,
    required this.price,
    required this.color,
    required this.name,
    required this.priceColor,
    this.textStyle,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final _textColor = color ?? Theme.of(context).colorScheme.onBackground;
    final _priceColor = priceColor ?? Theme.of(context).colorScheme.primary;
    final _textStyle = textStyle == null ? s14W400Dark(context) : textStyle!;
    final percent = NumberFormat.currency(
      locale: Localizations.localeOf(context).languageCode,
      symbol: '',
      decimalDigits: 2,
    );
    return price == null || price == 0
        ? Text(
            name,
            style: _textStyle.copyWith(color: _textColor),
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
                  ? s14W400Dark(context).copyWith(color: _textColor)
                  : textStyle!.copyWith(color: _textColor),
              children: <TextSpan>[
                TextSpan(
                  text: ' (+',
                  style: _textStyle.copyWith(color: _priceColor),
                ),
                TextSpan(
                  text: priceUnit,
                  style: _textStyle.copyWith(fontFamily: '', color: _priceColor),
                ),
                TextSpan(
                  text: '${percent.format(price!)})',
                  style: _textStyle.copyWith(color: _priceColor),
                ),
              ],
            ),
          );
  }
}
