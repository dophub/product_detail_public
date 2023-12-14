import 'package:flutter/material.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';

/// Standart turkcell yatay button
class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? txt;
  final Widget? widget;
  final EdgeInsets? padding;
  final EdgeInsets? buttonPadding;

  final ButtonStyle? style;
  final TextStyle? textStyle;

  const AppButton({
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
          const EdgeInsets.only(
            left: paddingM,
            right: paddingM,
            bottom: paddingM,
          ),
      child: ElevatedButton(
        onPressed: onTap,
        style: style,
        child: Padding(
          padding: buttonPadding ?? const EdgeInsets.symmetric(vertical: paddingM),
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
