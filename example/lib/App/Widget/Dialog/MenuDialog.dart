import 'package:flutter/material.dart';
import 'package:example/App/Init/Screen/SizeConfig.dart';
import 'package:example/App/Constant/App/PaddingAndRadiusSize.dart';
import 'package:example/App/Theme/AppColors.dart';
import 'package:example/App/Theme/TSTextStyle.dart';
import 'package:example/App/Widget/Dialog/TSDialog.dart';
import 'package:example/App/Widget/OtherWidgets/TSImageNetwork.dart';
import 'package:sip_models/response.dart';

/// Dealer profil ekranında appbar daki buttona tıklandığında menuleri gösteren dialog
class MenuDialog {
  Future showMenuDialog(BuildContext context,
      {required List<MenuModel> list, required Function(int) onTap}) {
    return TSDialog().showDynamicDialog(
      context,
      barrierColor: Colors.black45,
      widget: SimpleDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusXS)),
        children: [
          SizedBox(
            width: SizeConfig.safeBlockHorizontal * 100,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingM),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: paddingM),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 310,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusXS),
                                  color: Colors.deepOrange,
                                ),
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusXS),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.expand,
                                    children: [
                                      TSImageNetwork(
                                        imageUrl: list[index].menuImage!,
                                      ),
                                      Container(
                                        color: AppColor.cardBarrierColor,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: paddingXXS),
                                        child: Text(
                                          list[index].menuName!,
                                          style: s16W700Dark(context).copyWith(color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            onTap(index);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: paddingM);
                      },
                    ),
                    SizedBox(height: paddingM),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
