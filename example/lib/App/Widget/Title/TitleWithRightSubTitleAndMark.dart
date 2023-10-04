import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/AppColors.dart';
import 'package:example/App/Theme/TSTextStyle.dart';

/// [SingleSectionRadioButton],[MultiSectionCheckBox] ..vs kullanılan başlık
/// [title] başlık
/// [subTitle] başlığın alt kısmında cıkan altBaşlık
class TitleWithRightSubTitleAndMark extends StatelessWidget {
  final bool? showMark;
  final String? subTitle;
  final String title;
  final int? maxCount;
  final TextStyle? titleStyle;

  const TitleWithRightSubTitleAndMark({
    Key? key,
    this.showMark,
    this.subTitle,
    required this.title,
    this.maxCount, this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: titleStyle ?? s16W400Dark(context),
                  children: <TextSpan>[
                    TextSpan(
                        text: maxCount != null && maxCount != 0
                            ? ' (En Fazla: $maxCount Seçim)'
                            : null,
                        style:
                            s14W400Dark(context).copyWith(color: Colors.red)),
                  ],
                ),
              ),
              const SizedBox(width: paddingXXXS),
              Visibility(
                visible: showMark ?? false,
                child: CircleAvatar(
                  radius: radiusXXXS,
                  backgroundColor: AppColor.turkcellYellow,
                ),
              )
            ],
          ),
          Visibility(
            visible: subTitle != null && subTitle!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: paddingM,
                  color: AppColor.primaryVariant,
                ),
                Text(
                  subTitle!,
                  style: s14W400Dark(context),
                ),
              ],
            ),
          ) ,
        ],
      ),
    );
  }
}
