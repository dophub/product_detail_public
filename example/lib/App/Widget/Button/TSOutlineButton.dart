import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/TSTextStyle.dart';

/// Standart turkcell yatay button
/// Dış cizgili
class TSOutlineButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? txt;
  final Widget? widget;
  final EdgeInsets? padding;
  final EdgeInsets? contactPadding;
  final ButtonStyle? style;
  final Color? textColor;

  final TextStyle? textStyle;

  const TSOutlineButton({
    Key? key,
    required this.onTap,
    this.txt = '',
    this.widget,
    this.padding,
    this.contactPadding,
    this.style,
    this.textColor,
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
      child: OutlinedButton(
        onPressed: onTap,
        style: style,
        child: widget ?? Padding(
          padding: contactPadding ?? const EdgeInsets.all(paddingXXS),
          child:
              Text(
                txt!,
                style: textStyle ??
                    s16W700Dark(context).copyWith(color: textColor ?? Colors.white),
              ),
        ),
      ),
    );
  }
}
