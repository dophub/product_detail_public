import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Constant/Assets/Assets.dart';
import 'package:example/App/Theme/AppColors.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/TSOutlineButton.dart';
import 'package:example/App/Widget/Dialog/TSSimpleDialog.dart';

class TimeOutServiceDialog {
  void show(
    BuildContext context, {
    required VoidCallback onTapContinueWithFriendBtn,
    required VoidCallback onTapNewServiceBtn,
    required String message,
  }) {
    TSSimpleDialog().show(context, barrierDismissible: true, children: [
      SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: paddingS),
            Text(
              message,
              style: s18W400Dark(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: paddingL),
            SizedBox(
              width: double.infinity,
              child: TSOutlineButton(
                onTap: onTapNewServiceBtn,
                widget: Row(
                  children: [
                    SvgPicture.asset(forkSpoonIcon),
                    SizedBox(width: paddingS),
                    Flexible(child: Text('Bana yeni bir servis aç', style: s16W400Dark(context).copyWith(color: AppColor.primaryVariant)))
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TSOutlineButton(
                onTap: onTapContinueWithFriendBtn,
                widget: Row(
                  children: [
                    SvgPicture.asset(addPersonIcon),
                    SizedBox(width: paddingS),
                    Flexible(
                        child: Text('Masadaki arkadaşlarıma katılacağım',
                            style: s16W400Dark(context).copyWith(color: AppColor.primaryVariant)))
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
