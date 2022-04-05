import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/TSColors.dart';

/// Yuvarlak mavi Miktar AZALTMA butonu
class CircleAddButton extends StatelessWidget {
  final Function() onTap;

  final double? iconSize;

  final Color? splashColor;

  final Color? highlightColor;

  const CircleAddButton(
      {Key? key,
      required this.onTap,
      this.iconSize,
      this.splashColor,
      this.highlightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: splashColor,
      highlightColor: highlightColor,
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
          color: AppColor.primaryVariant,
          borderRadius: BorderRadius.circular(radiusXXXL),
        ),
        child: Icon(
          CupertinoIcons.add,
          size: iconSize ?? 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
