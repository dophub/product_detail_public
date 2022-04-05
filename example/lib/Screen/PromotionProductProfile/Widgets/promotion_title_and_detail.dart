import 'package:flutter/material.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/AppColors.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Button/TSCloseButton.dart';
import 'package:sip_models/enum.dart';


/// Product Profile screen de gösterilen Ürün Başlık,Alt Başlık ve Detay
///
class PromotionTitleAndDetail extends StatelessWidget {
  final bool showCloseButton;

  const PromotionTitleAndDetail({
    Key? key,
    required this.title,
    this.subTitle,
    this.detail,
    required this.showCloseButton,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingM),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(minHeight: 46),
            child: Row(
              children: [
                ///Bottom sheet tam ekran olduğunda Geri dönme butonu gözükecek
                showCloseButton
                    ? Padding(
                      padding: const EdgeInsets.only(right: paddingXS),
                      child: TSCloseButton(sizeType: SizeType.S,),
                    )
                    : SizedBox(),
                Flexible(
                  child: Text(
                    title,
                    style: s20W700Dark(context),
                  ),
                ),
              ],
            ),
          ),
          subTitle == null || subTitle!.isEmpty
              ? SizedBox()
              : Padding(
                padding: const EdgeInsets.only(bottom:paddingS),
                child: Text(
                    subTitle!,
                    style: s12W400Dark(context).copyWith(color: AppColor.paleTextColor),
                  ),
              ),
          detail == null || detail!.isEmpty
              ? SizedBox()
              : Padding(
                padding: const EdgeInsets.only(bottom:paddingS),
                child: Text(
                    detail!,
                    style: s14W400Dark(context),
                  ),
              ),
        ],
      ),
    );
  }
}
