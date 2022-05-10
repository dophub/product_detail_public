import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';

/// Fiyat göstergelerinde kullanılmakta.
/// '₺5.00' şeklinde widget
class PriceTextWidget extends StatelessWidget {
  final double price;
  final TextStyle? textStyle;
  final Color? color;
  final bool withOutDigitNumber;
  final int? maxLines;
  final String? symbol;

  const PriceTextWidget(
      {Key? key,
        required this.price,
        this.textStyle,
        this.color,
        this.withOutDigitNumber = false,
        this.maxLines, this.symbol})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var percent = NumberFormat.currency(
        locale: Localizations.localeOf(context).languageCode,
        symbol: '',
        decimalDigits: withOutDigitNumber ? 0 : 2);
    return RichText(
      maxLines: maxLines,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: symbol ?? priceUnit,
        style: textStyle == null
            ? s12W700Dark(context).copyWith(fontFamily: '',color: color)
            : textStyle!.copyWith(fontFamily: '',height: 1),
        children: <TextSpan>[
          TextSpan(
            text: percent.format(price),
            style: textStyle == null
                ? s12W700Dark(context).copyWith(color: color)
                : textStyle!,
          ),
        ],
      ),
    );
  }
}
