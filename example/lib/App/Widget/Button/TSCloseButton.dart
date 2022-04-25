import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:sip_models/enum.dart';

/// Geri dönme butonu
/// Yuvarlak şeklinde
class TSCloseButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final SizeType? sizeType;

  const TSCloseButton({
    Key? key,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.sizeType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.maybePop(context),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: CircleAvatar(
          radius: sizeType == SizeType.S ? radiusM
              : sizeType == SizeType.XS ? radiusS : radiusL - 2,
          backgroundColor: backgroundColor ?? Theme.of(context).buttonTheme.colorScheme!.background,
          child: Icon(
            CupertinoIcons.clear,
            size: (sizeType == SizeType.S ? radiusM:sizeType == SizeType.XS ? radiusS : radiusL - 2),
            color: iconColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
