import 'package:flutter/material.dart';
import 'package:product_detail/src/app/const/PaddingAndRadiusSize.dart';

/// Standart turkcell yatay button
class TSButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? txt;
  final Widget? widget;
  final EdgeInsets? padding;
  final EdgeInsets? buttonPadding;

  final ButtonStyle? style;
  final TextStyle? textStyle;

  const TSButton({
    Key? key,
    required this.onTap,
    this.txt = '',
    this.widget,
    this.padding,
    this.buttonPadding,
    this.style,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
            left: paddingM,
            right: paddingM,
            bottom: paddingM,
          ),
      child: ElevatedButton(
        onPressed: onTap,
        style: style,
        child: Padding(
          padding: buttonPadding ?? EdgeInsets.symmetric(vertical: paddingM),
          child: widget ??
              Text(
                txt!,
                style: textStyle,
              ),
        ),
      ),
    );
  }
}
