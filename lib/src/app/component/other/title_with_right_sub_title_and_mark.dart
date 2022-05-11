import 'package:flutter/material.dart';
import 'package:product_detail/src/app/const/padding_and_radius_size.dart';
import 'package:product_detail/src/app/const/app_colors.dart';
import 'package:product_detail/src/app/const/app_text_style.dart';

/// [SingleSectionRadioButton],[MultiSectionCheckBox] ..vs kullanılan başlık
/// [title] başlık
/// [subTitle] başlığın alt kısmında cıkan altBaşlık
/// [showMark] başlık sağ kısmında gösterilen [turkcellYellow] renginde işaret. [SingleSectionRadioButton],[MultiSectionCheckBox] ..vs tarafından item seçildimi diye gösteren bi işaret
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: titleStyle ?? s16W400Dark(context),
                    children: <TextSpan>[
                      TextSpan(
                          text: maxCount != null && maxCount != 0
                              ? ' (En Fazla: ' + maxCount.toString() + ' Seçim)'
                              : null,
                          style:
                              s14W400Dark(context).copyWith(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: paddingXXXS),
              Visibility(
                visible: showMark ?? false,
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                  child: CircleAvatar(
                    radius: radiusXXXS,
                    backgroundColor: AppColor.turkcellYellow,
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: subTitle != null && subTitle!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  height: paddingM,
                  color: AppColor.turkcellBlue,
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