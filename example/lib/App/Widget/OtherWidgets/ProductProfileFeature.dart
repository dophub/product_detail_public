import 'package:collection/collection.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:example/App/Constant/App/AppConstant.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Constant/Assets/Assets.dart';
import 'package:example/App/Theme/AppColors.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/OtherWidgets/TSImageNetwork.dart';

/// Ürün profilinde yatay şeklinde gösterilen ürün özelik kart ve list ( icon \n text) şekinde
/// Kalori, Hazırlama Süresi VS
class ProductProfileFeature extends StatelessWidget {
  final List<String> list;
  final int? calorie;
  final int? makeTime;

  const ProductProfileFeature({
    Key? key,
    required this.list,
    required this.calorie,
    required this.makeTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeHorizontal * 20,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
            Visibility(
              visible: makeTime != null && makeTime != 0,
              child: MiniCard(
                assets: watchIcon,
                txt: makeTime.toString() + minuteUnite,
              ),
            ),
            Visibility(
              visible: calorie != null && calorie != 0,
              child: MiniCard(
                assets: kcalIcon,
                txt: calorie.toString(),
              ),
            ),
            Row(
            children: list.mapIndexed((index, element) => Padding(
                padding: EdgeInsets.symmetric(vertical: paddingXXXS),
                child: Row(
                  children: [
                    SizedBox(width: paddingM),
                    AspectRatio(
                      aspectRatio: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radiusXS)),
                        elevation: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            TSImageNetwork(
                              imageUrl: element,
                              width: SizeConfig.blockSizeHorizontal * 9,
                              height: SizeConfig.blockSizeHorizontal * 9,
                            ),
                            Spacer(),
                            Text(
                              '143dk',
                              style: s12W400Dark(context)
                                  .copyWith(color: AppColor.primaryVariant),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: paddingXXXS),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: index == (list.length - 1) ? paddingM : 0),
                  ],
                ),
              ),
            ).toList(),
          )
        ]
      ),
    );
  }
}

/// Calori ve hazırlama süresinin kartı
class MiniCard extends StatelessWidget {
  const MiniCard({
    Key? key,
    required this.assets,required this.txt,
  }) : super(key: key);

  final String assets;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingXXXS),
      child: Row(
        children: [
          SizedBox(width: paddingM),
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radiusXS)),
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  SvgPicture.asset(
                    assets,
                    width: SizeConfig.blockSizeHorizontal * 9,
                    height: SizeConfig.blockSizeHorizontal * 9,
                    color: AppColor.primaryVariant,
                  ),
                  Spacer(),
                  Text(
                    txt,
                    style: s12W400Dark(context).copyWith(color: AppColor.primaryVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: paddingXXXS),
                ],
              ),
            ),
          ),
        //  SizedBox(width: index == (list.length - 1) ? paddingM : 0),
        ],
      ),
    );
  }
}
