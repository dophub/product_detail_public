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
  final TextOverflow overflow;

  const PriceTextWidgetWithParentheses({
    super.key,
    required this.price,
    required this.color,
    required this.name,
    required this.priceColor,
    this.textStyle,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _textColor = color ?? theme.colorScheme.onBackground;
    final _priceColor = priceColor ?? theme.colorScheme.primary;
    final _textStyle = textStyle ?? s13W400Dark(context);
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
            overflow: overflow,
          )
        : RichText(
            textAlign: TextAlign.start,
            maxLines: maxLines,
            overflow: overflow,
            text: TextSpan(
              text: name,
              style: _textStyle.copyWith(color: _textColor),
              children: <TextSpan>[
                TextSpan(
                  text: ' (+$priceUnit${percent.format(price!)})',
                  style: _textStyle.copyWith(color: _priceColor),
                ),
              ],
            ),
          );
  }
}
