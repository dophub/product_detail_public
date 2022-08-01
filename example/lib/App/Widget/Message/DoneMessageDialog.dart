import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Constant/Assets/Assets.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/TSOutlineButton.dart';
import 'package:example/App/Widget/Dialog/TSSimpleDialog.dart';

class DoneMessageDialog {
  Future show(BuildContext context, {String? text, Function()? onTap,String? buttonText}) {
    return TSSimpleDialog().show(
      context,
      children: [
        SizedBox(
          width: SizeConfig.safeBlockHorizontal * 50,
          child: Column(
            children: [
              SvgPicture.asset(
                outlineDoneIcon,
                height: 63,
              ),
              const SizedBox(height: paddingM),
              text != null
                  ? Column(
                      children: [
                        Text(
                          text,
                          style: s18W700Dark(context),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: paddingM),
                      ],
                    )
                  : const SizedBox(),
              TSOutlineButton(
                contactPadding: const EdgeInsets.symmetric(horizontal: paddingL),
                onTap: onTap ?? () => Navigator.of(context,rootNavigator: true).maybePop(),
                txt: buttonText ?? 'Kapat',
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
