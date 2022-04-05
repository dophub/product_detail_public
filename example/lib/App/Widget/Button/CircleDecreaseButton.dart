import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/AppColors.dart';

/// Yuvarlak mavi Mıktar ARTIRMA butonu
class CircleDecreaseButton extends StatelessWidget {
  final Function() onTap;
  final int? quantity;
  final bool deleteAble;

  final double? iconSize;

  const CircleDecreaseButton({
    Key? key,
    required this.onTap,
    this.iconSize,
    this.quantity,
    this.deleteAble = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minHeight: iconSize == null ? 38 : iconSize! + 17,
        minWidth: iconSize == null ? 38 : iconSize! + 17,
      ),
      icon: Container(
        width: iconSize == null ? 28 : iconSize! + 7,
        height: iconSize == null ? 28 : iconSize! + 7,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusXXXL),
          border: Border.all(width: 1, color: AppColor.primaryVariant),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds:350),
          switchInCurve: Curves.bounceOut,
          reverseDuration: Duration(milliseconds:0),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              quantity == 1
                  ? ScaleTransition(
                      scale: animation,
                      child: child,
                    )
                  : FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
          child: quantity == 1 && deleteAble
              ? Icon(
                  CupertinoIcons.delete,
                  key: ValueKey('CircleDecreaseButtonDelete'),
                  size: iconSize ?? 18,
                  color: AppColor.primaryVariant,
                )
              : Icon(
                  CupertinoIcons.minus,
                  key: ValueKey('CircleDecreaseButtonDeleteMinus'),
                  size: iconSize ?? 18,
                  color: AppColor.primaryVariant,
                ),
        ),
      ),
    );
  }
}
