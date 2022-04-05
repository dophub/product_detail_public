import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/AppConstant.dart';
import 'package:example/App/Theme/AppColors.dart';
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
                    .copyWith(color: color ?? AppColor.darkText)
                : textStyle!.copyWith(color: color ?? AppColor.darkText))
        : RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: name,
              style: textStyle == null
                  ? s16W400Dark(context).copyWith(color: color ?? AppColor.darkText)
                  : textStyle!.copyWith(color: color ?? AppColor.darkText),
              children: <TextSpan>[
                TextSpan(
                  text: ' (+',
                  style: textStyle == null
                      ? s16W400Dark(context)
                          .copyWith(color: color ?? AppColor.primaryVariant)
                      : textStyle!
                          .copyWith(color: color ?? AppColor.primaryVariant),
                ),
                TextSpan(
                  text: priceUnit,
                  style: textStyle == null
                      ? s16W400Dark(context).copyWith(
                          fontFamily: '', color: color ?? AppColor.primaryVariant)
                      : textStyle!.copyWith(
                          fontFamily: '', color: color ?? AppColor.primaryVariant),
                ),
                TextSpan(
                  text: ' ${price!.toStringAsFixed(2)})',
                  style: textStyle == null
                      ? s16W400Dark(context)
                          .copyWith(color: color ?? AppColor.primaryVariant)
                      : textStyle!
                          .copyWith(color: color ?? AppColor.primaryVariant),
                ),
              ],
            ),
          );
  }
}
