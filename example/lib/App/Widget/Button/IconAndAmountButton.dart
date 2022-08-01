import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/TSButton.dart';
import 'package:example/App/Widget/OtherWidgets/PriceTextWidget.dart';

/// Ödeme Buttonu
/// icon - Ödenecek tutar - Metin Metinin
class IconAndAmountButton extends StatelessWidget {
  final Function()? onTap;

  final double amount;
  final String text;
  final String svg;

  const IconAndAmountButton({
    Key? key,
    this.onTap,
    required this.amount,
    required this.text,
    required this.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TSButton(
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      svg,
                      height: 21,
                      color: Colors.white,
                    ),
                    const SizedBox(width: paddingM),
                    Flexible(
                      child: PriceTextWidget(
                          price: amount,
                          textStyle: s18W700Dark(context),
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Text(
                text,
                style: s18W700Dark(context).copyWith(color: Colors.white),
              ),
            ],
          ),
          onTap: onTap),
    );
  }
}
