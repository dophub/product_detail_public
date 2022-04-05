import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Constant/Assets/Assets.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:example/App/Theme/TSColors.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/TSOutlineButton.dart';
import 'package:example/App/Widget/Dialog/TSSimpleDialog.dart';

class ErrorMessageDialog {
  Future show(BuildContext context,
      {required String text,
        Function()? onTap,
      String? buttonText,
      bool? barrierDismissible}) {
    return TSSimpleDialog().show(
      context,
      barrierDismissible: barrierDismissible,
      children: [
        SizedBox(
          width: SizeConfig.safeBlockHorizontal * 50,
          child: Column(
            children: [
              SvgPicture.asset(
                outlineErrorIcon,
                color: AppColor.turkcellYellow,
                height: 63,
              ),
              SizedBox(height: paddingM),
              Text(
                text,
                style: s18W700Dark(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: paddingM),
              TSOutlineButton(
                contactPadding: const EdgeInsets.symmetric(horizontal: paddingL),
                onTap: onTap ?? () => Navigator.of(context,rootNavigator: true).maybePop(),
                txt: buttonText ?? 'Tekrar Dene',
                textColor: Theme.of(context).textTheme.bodyText1!.color!,
                style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                        ),
                      ),
                    ),
              )
            ],
          ),
        )
      ],
    );
  }
}
